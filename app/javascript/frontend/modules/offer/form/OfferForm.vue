<template>
  <div>
    <v-form
      ref="form"
      v-model="valid"
    >
      <h4 class="title font-weight-bold black--text mb-4">
        Параметры
      </h4>

      <v-select
        v-model="offer.category_id" 
        v-validate="'required'"
        :items="categories"
        item-value="id"
        item-text="title"
        label="Категория"
        data-vv-name="category"
        :error-messages="errors.collect('category')"
        required
      >
        <template slot="item" slot-scope="data">
          <v-list-tile-content>
            <v-list-tile-title
              :class="{
                'body-1' : data.item.parent_id,
                'subheading font-weight-bold' : !data.item.parent_id,
              }">
              {{ data.item.title }}
            </v-list-tile-title>
          </v-list-tile-content>
        </template>
      </v-select>
      <v-select
        v-model="offer.type" 
        v-validate="'required'"
        :disabled="this.method === 'patch'"
        :items="types"
        label="Вид объявления"
        data-vv-name="method"
        :error-messages="errors.collect('method')"
        required
      />
      <v-text-field
        v-if="offer.type === 'CashOffer' || offer.type === 'ServiceOffer'"
        v-model="offer.price"
        v-validate="{
          required: true,
          regex: /^(([\d ]+)(\.\d{1,2})?)$/
        }"
        label="Цена"
        type="text"
        data-vv-name="price"
        :error-messages="errors.collect('price')"
        @keyup.enter="submit"
        required
      />
      <v-text-field
        v-if="offer.type === 'ExchangeOffer'"
        v-model="offer.exchange_item"
        v-validate="'required'"
        label="На что меняете?"
        type="text"
        data-vv-name="exchange item"
        :error-messages="errors.collect('exchange item')"
        @keyup.enter="submit"
        required
        hint="Если вы не ещё не определились - оставьте поле пустым"
        persistent-hint
      />
      <v-text-field
        v-model="offer.title"
        v-validate="'required'"
        :label="`Название ${offer.type === 'ServiceOffer' ? 'услуги' : 'объявления'}`"
        type="text"
        data-vv-name="title"
        :error-messages="errors.collect('title')"
        @keyup.enter="submit"
        required
        hint="Не пишите в названии цену и контактную информацию — для этого есть отдельные поля"
        persistent-hint
      />
      <v-textarea
        v-model="offer.description"
        :label="`Описание ${offer.type === 'ServiceOffer' ? 'услуги' : 'объявления'}`"
        @keyup.enter="submit"
        hint="Не указывайте в описании телефон и e-mail — для этого есть отдельные поля"
        persistent-hint
      />

      <MultiplePhotoUpload @update="onPhotosUpdated"
        :max="10"
        ref="photoUpload" />

      <h4 class="title font-weight-bold black--text mt-4 mb-4">
        Контактная информация
      </h4>

      <AutocompleteInput 
        :items="suggestedAddresses"
        :label="'Адрес'"
        :value="this.offer.address"
        :loaded="suggestedAddressesLoaded"
        @update="onAddressUpdate"
        @change="onAddressChange"
      />

      <v-text-field
        v-model="offer.phone_number"
        v-validate="'required'"
        label="Телефон"
        type="tel"
        data-vv-name="phone number"
        :error-messages="errors.collect('phone number')"
        @keyup.enter="submit"
        required
      />

      <v-alert
        :value="error"
        type="error"
        class="mx-0 mb-3"
        outline
      >
        <div v-html="error" />
      </v-alert>

      <v-btn
        depressed
        color="info"
        class="ma-0 mt-4"
        @click="submit"
      >
        Добавить
      </v-btn> </v-form>
  </div>
</template>

<script>
import axios from 'axios'

import MultiplePhotoUpload from './MultiplePhotoUpload';
import AutocompleteInput from '@frontend/core/components/form/AutocompleteInput';
import { mapGetters, mapMutations } from 'vuex';
import { offersService } from '@frontend/modules/offer/services/offersService';
import geolocationsService from '@frontend/core/services/geolocationsService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  props: {
    method: {
      type: String,
      required: true,
    },
    offerItem: Object,
  },

  components: {
    MultiplePhotoUpload,
    AutocompleteInput,
  },

  data: () => ({
    valid: true,
    suggestedAddresses: [],
    suggestedAddressesLoaded: true,
    types: [{
      text: 'Продам',
      value: 'CashOffer',
    }, {
      text: 'Обменяю',
      value: 'ExchangeOffer',
    }, {
      text: 'Услуга',
      value: 'ServiceOffer',
    }, {
      text: 'Отдам БисмилЛах1',
      value: 'FreeOffer',
    }],

    offer: {
      type: 'CashOffer',
      category_id: null,
      photos: [],
      title: '',
      description: '',
      price: '',
      exchange_item: '',
      address: '',
      phone_number: '',
    },

    error: null,
  }),

  computed: {
    ...mapGetters([
      'currentUser', 'mainCategories', 'childCategories',
    ]),

    categories() {
      return this.mainCategories.reduce((acc, cur) => {
        if (acc.length != 0) acc.push({ divider: true });
        acc.push(cur);
        return acc.concat(this.childCategories(cur.id).map(category => category));
      }, []);
    },
  },

  created() {
    if (!this.offerItem) return;

    this.offer.category_id = this.offerItem.category_id;
    this.offer.type = this.offerItem.type;
    this.offer.title = this.offerItem.title;
    this.offer.description = this.offerItem.description;
    this.offer.phone_number = this.offerItem.phone_number;

    if (this.offerItem.price) this.offer.price = this.offerItem.price;
    if (this.offerItem.exchange_item) this.offer.exchange_item = this.offerItem.exchange_item;

    this.suggestedAddresses = [this.offerItem.address];
    this.offer.address = this.offerItem.address;
  },

  mounted() {
    if (!this.offerItem) return;

    this.setPhotos();
  },

  methods: {
    ...mapMutations([
      'setOffer',
    ]),

    onPhotosUpdated(photos) {
      this.offer.photos = photos;
    },

    onAddressChange(address) {
      this.offer.address = address;
    },

    async setPhotos() {
      const requests = this.offerItem.photos.map(photo => {
        return axios.get(photo.url, { responseType: 'blob' })
                    .then(resp => resp)
                    .catch(error => error)
      });

      const responses = await Promise.all(requests);
      const validResponses = responses.filter((response) => !(response instanceof Error));

      responses.filter((response) => (response instanceof Error)).forEach((error) => {
        console.error(error)
      });

      const photoFiles = validResponses.map((response, index) => {
        return new File([response.data], this.offerItem.photos[index].name);
      });

      this.offer.photos = photoFiles;
      this.$refs.photoUpload.photos = photoFiles;
    },

    async onAddressUpdate(inputAddress) {
      this.suggestedAddressesLoaded = false;

      geolocationsService.search(inputAddress)
        .then(locations => this.suggestedAddresses = locations.map(location => location.address))
        .catch(error => this.error = error)
        .finally(() => this.suggestedAddressesLoaded = true)
    },

    async submit() {
      await this.$validator.validateAll();
      if (!this.valid) return;

      if (this.method && this.method === 'post') {
        offersService.create(this.offer)
          .then((response) => {
            this.setOffer(response.data.data.attributes);
            this.$router.push(`/offer/${response.data.data.id}`);
          })
          .catch((error) => {
            this.error = error;
          });
      } else if (this.method && this.method === 'patch') {
        offersService.update({
          id: this.offerItem.id,
          ...this.offer,
        })
          .then((response) => {
            this.setOffer(response.data.data.attributes);
            this.$router.push(`/offer/${response.data.data.id}`);
          })
          .catch((error) => {
            this.error = error;
          });
      }
    },
  },
};
</script>
