<template>
  <div class="offer-view">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex xs12>
          <Search />
        </v-flex>
      </v-layout>
      <v-layout
        v-if="!loaded"
        row
        wrap
        justify-center
        align-content-center
        class="offer-view__loader"
      >
        <v-progress-circular
          indeterminate
          color="info"
          :size="100"
          :width="10"
        />
      </v-layout>
      <div v-else>
        <v-layout row wrap class="mt-5">
          <v-flex xs12 sm6>
            <h1 class="display-1">{{ offer.title }}</h1>
          </v-flex>
          <v-flex xs12 sm6>
            <p class="mb-0 text-xs-right display-1">{{ this.offerPrice }}</p>
          </v-flex>
          <v-flex xs12>
            <p>{{ offer.updated_at | moment('calendar') }}</p>
          </v-flex>
        </v-layout>
        <v-layout row wrap>
          <v-flex xs12 sm8>
            <div class="offer-view__image-placeholder grey lighten-2 d-flex align-center">
              <p class="grey--text text-xs-center title">Без фото</p>
            </div>
          </v-flex>
          <v-flex xs12 sm4 class="pl-4">
            <v-btn
              block
              large
              flat
              depressed
              class="offer-view__show-phone-button button_blue white--text title text-none font-weight-regular ma-0"
            >
              Показать телефон<br>
              {{ hiddenPhoneNumber }}
            </v-btn>
            <v-btn v-if="closable" block flat depressed class="ma-0 mt-2" @click="close">
              Закрыть объявление
            </v-btn>
            <!--- TODO: Stilno nujno --->
            <h3 v-if="offer.closed">Закрытое обьявление</h3>
          </v-flex>
          <v-layout row wrap class="mt-3">
            <v-flex xs12>
              <p class="mb-0 py-3">
                <span class="grey--text">Адрес:</span>
                {{ offer.location }}
              </p>
              <v-divider />
            </v-flex>
            <v-flex xs12>
              <p class="mb-0 py-3">{{ offer.description }}</p>
              <v-divider />
            </v-flex>
            <v-flex xs12>
              <p class="mb-0 py-3">{{ offer.user.name }}</p>
              <v-img v-if="offer.user.photo.url" :src="offer.user.photo.url" contain :height="100" alt="photo"/>
              <!--- TODO: Стас поправь плиз) --->
              <p v-else>Без фото</p>
              <p class="mb-0 py-3">Зарегестрирован {{ offer.user.created_at | moment('calendar') }}</p>
            </v-flex>
          </v-layout>
        </v-layout>
      </div>
    </v-container>
  </div>
</template>

<script>
import Search from '@frontend/modules/dashboard/search/Search';

import { mapGetters, mapMutations } from 'vuex';

import { offersService } from './services/offersService';

export default {
  components: {
    Search,
  },

  data() {
    return {
      userPhone: null,
    };
  },

  computed: {
    ...mapGetters({
      offer: 'getOffer',
      loaded: 'isOfferLoaded',
      user: 'currentUser',
    }),

    offerPrice() {
      if (this.offer.type === 'CashOffer') return this.offer.price;
      if (this.offer.type === 'ExchangeOffer') {
        if (this.offer.exchange_item) return `Обмен на ${this.offer.exchange_item.toLowerCase()}`;
        return 'Обмен';
      }
      if (this.offer.type === 'FreeOffer') return 'Отдам даром';
      return 'Уточнить';
    },

    hiddenPhoneNumber() {
      let replaceCount = this.offer.phone_number.length - 6;
      if (replaceCount < 0) replaceCount = 0;

      const regex = new RegExp(`.{${replaceCount}}$`);
      return this.offer.phone_number.replace(regex, 'X'.repeat(replaceCount));
    },
    
    closable() {
      return this.user.id === this.offer.user_id &&
             !this.offer.closed;
    }
  },

  methods: {
    ...mapMutations(['setOffer']),

    close() {
      offersService.close(this.offer.id)
        .then(resp => this.setOffer(resp));
    }
  }
};
</script>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}

.offer-view__image-placeholder {
  height: 300px;
}

.offer-view__loader {
  height: 400px;
}

.offer-view__show-phone-button {
  height: 64px;
}
</style>
