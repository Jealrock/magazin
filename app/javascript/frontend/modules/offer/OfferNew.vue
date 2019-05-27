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
                v-model="type"
                v-validate="'required'"
                :items="types"
                label="Вид объявления"
                data-vv-name="method"
                :error-messages="errors.collect('method')"
                outline
                required
              />
              <v-text-field
                v-if="type === 'CashOffer'"
                v-model="price"
                v-validate="'required'"
                label="Цена"
                type="text"
                data-vv-name="price"
                :error-messages="errors.collect('price')"
                outline
                required
              />
              <v-text-field
                v-if="type === 'ExchangeOffer'"
                v-model="exchangeItem"
                label="На что меняете?"
                type="text"
                outline
                hint="Если вы не ещё не определились - оставьте поле пустым"
                persistent-hint
              />
              <v-text-field
                v-model="title"
                v-validate="'required'"
                label="Название объявления"
                type="text"
                data-vv-name="title"
                :error-messages="errors.collect('title')"
                outline
                required
                hint="Не пишите в названии цену и контактную информацию — для этого есть отдельные поля"
                persistent-hint
              />
              <v-textarea
                v-model="description"
                v-validate="'required|min:10'"
                label="Описание объявления"
                data-vv-name="description"
                :error-messages="errors.collect('description')"
                outline
                required
                hint="Не указывайте в описании телефон и e-mail — для этого есть отдельные поля"
                persistent-hint
              />
              <h4 class="title font-weight-bold black--text mt-4">Контактная информация</h4>
              <v-text-field
                v-model="location"
                label="Адрес"
                outline
              />
              <v-text-field
                v-model="email"
                v-validate="'required|email'"
                label="Электронная почта"
                type="email"
                data-vv-name="email"
                :error-messages="errors.collect('email')"
                outline
                required
              />
              <v-text-field
                v-model="phoneNumber"
                v-validate="'required'"
                label="Телефон"
                type="tel"
                data-vv-name="phone number"
                :error-messages="errors.collect('phone number')"
                @keyup.enter="submit"
                outline
                required
              />
              <v-btn
                color="info"
                class="ma-0"
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
import { mapGetters, mapMutations } from 'vuex';
import { offersService } from './services/offersService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  data: () => ({
    valid: true,
    types: [{
      text: 'Отдаю даром',
      value: 'FreeOffer',
    }, {
      text: 'Продам',
      value: 'CashOffer',
    }, {
      text: 'Обменяю',
      value: 'ExchangeOffer',
    }],

    type: 'CashOffer',
    title: '',
    description: '',
    price: '',
    exchangeItem: '',
    location: '',
    email: '',
    phoneNumber: '',
  }),

  computed: {
    ...mapGetters([
      'currentUser',
    ]),
  },

  methods: {
    ...mapMutations([
      'setOffer',
    ]),

    async submit() {
      /*
      await this.$validator.validateAll();
      if (!this.valid) return;
      */

      offersService.postOffer({
        type: this.type,
        price: this.price,
        exchange_item: this.exchangeItem,
        title: this.title,
        description: this.description,
        location: this.location,
        email: this.email,
        phone_number: this.phoneNumber,
      })
        .then((response) => {
          this.setOffer(response.data.data.attributes);
          this.$router.push(`/offer/${response.data.data.id}`);
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
