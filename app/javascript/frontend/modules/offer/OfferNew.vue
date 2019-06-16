<template>
  <div class="offer-new">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap>
        <v-flex xs12>
          <h1 class="title font-weight-regular grey--text my-3">Новое объявление</h1>
          <v-divider />
        </v-flex>
      </v-layout>
      <v-layout row wrap mt-4>
        <v-flex xs12>
          <div>
            <v-form
              ref="form"
              v-model="valid"
            >
              <h4 class="title font-weight-bold black--text mb-4">
                Параметры
              </h4>

              <v-select
                v-model="category_id" 
                v-validate="'required'"
                :items="categories"
                item-value="id"
                label="Категория"
                data-vv-name="category"
                :error-messages="errors.collect('category')"
                required
              >
                <template slot="item" slot-scope="data">
                  <div class="v-list__tile__content">
                    <div class="v-list__tile__title"
                      :class="{
                        'body-1' : data.item.parent_id,
                        'subheading font-weight-bold' : !data.item.parent_id,
                      }">
                      {{ data.item.title }}
                    </div>
                  </div>
                </template>
                <template slot="selection" slot-scope="data">
                  <div class="v-select__selection v-select__selection--comma">
                    {{ data.item.title }}
                  </div>
                </template>
              </v-select>
              <v-select
                v-model="type" 
                v-validate="'required'"
                :items="types"
                label="Вид объявления"
                data-vv-name="method"
                :error-messages="errors.collect('method')"
                required
              />
              <v-text-field
                v-if="type === 'CashOffer' || type === 'ServiceOffer'"
                v-model="price"
                v-validate="'required'"
                label="Цена"
                type="text"
                data-vv-name="price"
                :error-messages="errors.collect('price')"
                @keyup.enter="submit"
                required
              />
              <v-text-field
                v-if="type === 'ExchangeOffer'"
                v-model="exchangeItem"
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
                v-model="title"
                v-validate="'required'"
                :label="`Название ${type === 'ServiceOffer' ? 'услуги' : 'объявления'}`"
                type="text"
                data-vv-name="title"
                :error-messages="errors.collect('title')"
                @keyup.enter="submit"
                required
                hint="Не пишите в названии цену и контактную информацию — для этого есть отдельные поля"
                persistent-hint
              />
              <v-textarea
                v-model="description"
                :label="`Описание ${type === 'ServiceOffer' ? 'услуги' : 'объявления'}`"
                @keyup.enter="submit"
                hint="Не указывайте в описании телефон и e-mail — для этого есть отдельные поля"
                persistent-hint
              />

              <MultiplePhotoUpload @update="onPhotosUpdated" :max="10"/>

              <h4 class="title font-weight-bold black--text mt-4 mb-4">
                Контактная информация
              </h4>

              <AutocompleteInput 
                :items="suggestedAddresses"
                :label="'Адрес'"
                :loaded="suggestedAddressesLoaded"
                @update="onAddressUpdate"
                @change="onAddressChange"
              />

              <v-text-field
                v-model="phoneNumber"
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
                color="info"
                class="ma-0 mt-4"
                @click="submit"
              >
                Добавить
              </v-btn> </v-form>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import MultiplePhotoUpload from './form/MultiplePhotoUpload';
import AutocompleteInput from '@frontend/core/components/form/AutocompleteInput';
import { mapGetters, mapMutations } from 'vuex';
import { offersService } from './services/offersService';
import geolocationsService from '@frontend/core/services/geolocationsService';

export default {
  $_veeValidate: {
    validator: 'new',
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

    type: 'CashOffer',
    category_id: null,
    photos: [],
    title: '',
    description: '',
    price: '',
    exchangeItem: '',
    address: '',
    phoneNumber: '',
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

  methods: {
    ...mapMutations([
      'setOffer',
    ]),

    onPhotosUpdated(photos) {
      this.photos = photos;
    },

    onAddressChange(address) {
      this.address = address;
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

      offersService.create({
        type: this.type,
        category_id: this.category_id,
        photos: this.photos,
        price: this.price,
        exchange_item: this.exchangeItem,
        title: this.title,
        description: this.description,
        address: this.address,
        phone_number: this.phoneNumber,
      })
        .then((response) => {
          this.setOffer(response.data.data.attributes);
          this.$router.push(`/offer/${response.data.data.id}`);
        })
        .catch((error) => {
          this.error = error;
        });
    },
  },
};
</script>
