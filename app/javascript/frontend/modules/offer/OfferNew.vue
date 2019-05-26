<template>
  <div class="offer-new">
    <v-container pa-0 px-3>
      <v-layout row wrap>
        <v-flex xs12>
          <h1 class="title font-weight-regular grey--text my-2">Новое объявление</h1>
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
              <h4 class="title font-weight-bold black--text">Параметры</h4>
              <v-select
                :items="acquireMethodsItems"
                item-text="label"
                item-value="value"
                v-model="acquireMethod"
                v-validate="'required'"
                label="Вид объявления"
                data-vv-name="method"
                :error-messages="errors.collect('method')"
                required
              />
              <v-text-field
                v-if="acquireMethod === 'priced'"
                v-model="price"
                v-validate="'required'"
                label="Цена"
                type="text"
                data-vv-name="price"
                :error-messages="errors.collect('price')"
                required
              />
              <v-text-field
                v-model="title"
                v-validate="'required'"
                label="Название объявления"
                type="text"
                data-vv-name="title"
                :error-messages="errors.collect('title')"
                required
                hint="Не пишите в названии цену и контактную информацию — для этого есть отдельные поля"
                persistent-hint
                @keyup.enter="submit"
              />
              <v-textarea
                v-model="description"
                v-validate="'required|min:10'"
                label="Описание объявления"
                data-vv-name="description"
                :error-messages="errors.collect('description')"
                required
                hint="Не указывайте в описании телефон и e-mail — для этого есть отдельные поля"
                persistent-hint
              />
              <v-text-field
                v-model="youtubeVideoURL"
                label="Видео с YouTube"
              />
              <h4 class="title font-weight-bold black--text mt-4">Контактная информация</h4>
              <v-text-field
                v-model="address"
                label="Адрес"
              />
              <v-text-field
                v-model="email"
                v-validate="'required|email'"
                label="Электронная почта"
                type="email"
                data-vv-name="email"
                :error-messages="errors.collect('email')"
                required
              />
              <v-text-field
                v-model="phoneNumber"
                v-validate="'required'"
                label="Телефон"
                type="tel"
                data-vv-name="phone number"
                :error-messages="errors.collect('phone number')"
                required
              />
              <v-radio-group
                :mandatory="false"
              >
                <v-radio
                  label="По телефону и в сообщениях"
                  value="bothWays"
                  color="info"
                />
                <v-radio
                  label="По телефону"
                  value="phoneCallOnly"
                  color="info"
                />
                <v-radio
                  label="В сообщениях"
                  value="commentsOnly"
                  color="info"
                />
              </v-radio-group>
              <v-btn
                color="info"
                @click="submit"
              >
                Далее
              </v-btn>
            </v-form>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import { offersService } from '@frontend/core/services/offersService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  data: () => ({
    valid: true,
    acquireMethodsItems: [{
      label: 'Отдаю даром',
      value: 'free',
    }, {
      label: 'Продам',
      value: 'priced',
    }],

    title: '',
    description: '',
    acquireMethod: '',
    price: '',
    youtubeVideoURL: '',
    address: '',
    email: '',
    phoneNumber: '',
  }),

  computed: {
    ...mapGetters([
      'currentUser',
    ]),
  },

  methods: {
    ...mapActions([
      'createOffer',
    ]),

    async submit() {
      /*
      await this.$validator.validateAll();
      if (!this.valid) return;
      */

      offersService.postOffer({
        title: 'lol',
        description: 'kek',
      })
        .then((response) => {
          console.log(response);
        });
    },
  },
};
</script>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
