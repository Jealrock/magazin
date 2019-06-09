<template>
  <div class="offer-view">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesBar />
        </v-flex>
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
            <p class="mt-1 mb-0 text-xs-left text-sm-right"
              :class="{
                'display-1' : $vuetify.breakpoint.smAndUp
              }">
              {{ this.offerPrice }}</p>
          </v-flex>
          <v-flex xs12 class="mt-3">
            <v-layout row align-center>
              <div v-if="user.uid">
                <v-btn v-if="!isFavorite(offer.id)"
                  outline small depressed
                  :loading="loading"
                  :disabled="loading"
                  color="grey"
                  class="ma-0 mr-4"
                  @click="startToggleFavorite">
                  <v-icon color="info">favorite_border</v-icon>
                  <p class="body-1 text-none black--text mb-0 ml-2">
                    Добавить в избранное
                  </p>
                </v-btn>
                <v-btn v-else
                  small depressed
                  :loading="loading"
                  :disabled="loading"
                  color="info"
                  class="ma-0 mr-4"
                  @click="startToggleFavorite">
                  <v-icon color="white">favorite</v-icon>
                  <p class="body-1 text-none white--text mb-0 ml-2">
                    В избранном
                  </p>
                </v-btn>
              </div>
              <p class="body-1 mb-0">
                Размещено {{ offer.created_at | moment('calendar').toLowerCase() }}
              </p>
              <p class="body-1 mb-0 error--text ml-4"
                v-if="offer.closed">
                Объявление было закрыто владельцем
              </p>
            </v-layout>
          </v-flex>
        </v-layout>
        <v-layout row wrap
          class="mt-4">
          <v-flex xs12 sm8>
            <v-carousel v-if="offer.photos.length"
              class="elevation-0"
              :cycle="false">
              <v-carousel-item
                v-for="(item, i) in offer.photos"
                :key="i"
                :src="item.url">
              </v-carousel-item>
            </v-carousel>
            <div v-else class="offer-view__image-placeholder grey lighten-3 d-flex align-center">
              <p class="grey--text text-xs-center title">Без фото</p>
            </div>
          </v-flex>
          <v-flex xs12 sm4 :class="{ 
              'pl-4' : $vuetify.breakpoint.smAndUp,
              'pt-4' : $vuetify.breakpoint.xsOnly
            }">
            <v-btn block flat depressed
              class="offer-view__button-show-phone button_blue ma-0"
              @click="phoneVisible = !phoneVisible">
                <p class="white--text text-none ma-0">
                  <span class="title font-weight-regular">{{ phoneVisible ? 'Скрыть телефон' : 'Показать телефон' }}</span><br>
                  <span class="body-1">{{ phoneNumber }}</span>
                </p>
            </v-btn>
            <v-btn v-if="closable"
              block flat depressed
              color="error"
              class="ma-0 mt-3"
              @click="close">
              Закрыть объявление
            </v-btn>

            <v-btn v-if="this.user.id === this.offer.user_id"
              block flat depressed
              color="error"
              class="ma-0 mt-3"
              @click="notify">
              Отправить PUSH нотификацию 
            </v-btn>

            <v-layout row justify-space-between
              class="mt-5">
              <div class="pr-1">
                <p class="mb-0 body-2">{{ offer.user.name || 'Имя не указано' }}</p>
                <p class="mb-0 caption">Зарегистрирован {{ offer.user.created_at | moment('calendar').toLowerCase() }}</p>
              </div>
              <div>
                <v-avatar :size="60"
                  color="grey lighten-3">
                  <v-img v-if="offer.user.photo.url"
                    :src="offer.user.photo.url"
                    alt="photo"/>
                  <v-icon v-else>person_outline</v-icon>
                </v-avatar>
              </div>
            </v-layout>
          </v-flex>
        </v-layout>
        <v-layout row wrap class="mt-5">
          <v-flex xs12>
            <p class="mb-0 py-3">
              <span class="grey--text">Адрес:</span>
              {{ offer.address }}
            </p>
            <v-divider />
          </v-flex>
          <v-flex xs12>
            <p class="mb-0 py-3">{{ offer.description }}</p>
          </v-flex>
        </v-layout>
      </div>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

import Search from '@frontend/modules/dashboard/search/Search';
import CategoriesBar from '@frontend/modules/dashboard/categories/CategoriesBar';

import { offersService } from './services/offersService';

export default {
  components: {
    Search, CategoriesBar,
  },

  data() {
    return {
      phoneVisible: false,
      loading: false,
    };
  },

  computed: {
    ...mapGetters({
      offer: 'getOffer',
      isFavorite: 'isFavorite',
      loaded: 'isOfferLoaded',
      user: 'currentUser',
    }),

    offerPrice() {
      if (this.offer.type === 'CashOffer') return `${this.offer.price} руб.`;
      if (this.offer.type === 'ExchangeOffer') {
        if (this.offer.exchange_item) return `Обмен на ${this.offer.exchange_item.toLowerCase()}`;
        return 'Обмен';
      }
      if (this.offer.type === 'FreeOffer') return 'Отдам даром';
      return 'Уточнить';
    },

    phoneNumber() {
      if (this.phoneVisible) return this.offer.phone_number;

      const replaceCount = Math.round(this.offer.phone_number.length * 0.6);
      const regex = new RegExp(`.{${replaceCount}}$`);
      return this.offer.phone_number.replace(regex, 'X'.repeat(replaceCount));
    },

    closable() {
      return this.user.id === this.offer.user_id
        && !this.offer.closed;
    },
  },

  methods: {
    ...mapMutations([
      'setOffer',
    ]),

    ...mapActions([
      'toggleFavorite',
    ]),

    close() {
      offersService.close(this.offer.id)
        .then(resp => this.setOffer(resp));
    },

    startToggleFavorite() {
      this.loading = true
      this.toggleFavorite(this.offer.id)
        .then((response) => this.loading = false)
    },

    notify() {
      offersService.notify(this.offer.id)
        .then(resp => this.setOffer(resp));
    },
  },
};
</script>

<style scoped>
.offer-view__image-placeholder {
  height: 300px;
}

.offer-view__loader {
  height: 400px;
}

.offer-view__button-show-phone {
  height: 64px;
}
</style>
