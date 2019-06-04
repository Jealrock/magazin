<template>
  <div class="item">
    <v-btn small depressed flat fab absolute
      class="item__add-to-favorites-button"
      @click="checkoutFavorite">
      <v-icon v-if="isFavorite(item.id)">favorite</v-icon>
      <v-icon v-else>favorite_border</v-icon>
    </v-btn>
    <router-link
      :to="`/offer/${item.id}`">
      <v-card class="elevation-0">
        <v-img
          :src="item.photos[0] && item.photos[0].url"
          alt="photo"
          class="grey lighten-3"
          aspect-ratio="1.5"
        />
        <v-card-title class="px-0">
          <div class="body-2">
            <p class="item__title font-weight-bold primary--text text--accent-4 ma-0">{{ item.title }}</p>
            <p class="item__price ma-0 font-weight-bold">{{ price }}</p>
            <p class="item__location ma-0 font-weight-regular black--text">{{ item.location }}</p>
            <p class="item__publication-date ma-0 font-weight-regular grey--text text--lighten-1">{{ item.created_at | moment('calendar') }}</p>
          </div>
        </v-card-title>
      </v-card>
    </router-link>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import { favoritesService } from '@frontend/modules/favorites/services/favoritesService';

export default {
  props: {
    item: Object,
  },
  
  computed: {
    ...mapGetters([
      'isFavorite'
    ]),

    price() {
      if (this.item.type === 'CashOffer') return this.item.price + ' руб.';
      if (this.item.type === 'ExchangeOffer') {
        if (this.item.exchange_item) return `Обмен на ${this.item.exchange_item.toLowerCase()}`;
        return 'Обмен';
      }
      if (this.item.type === 'FreeOffer') return 'Отдам даром';
      return 'Уточнить';
    }
  },

  methods: {
    ...mapMutations([
      'addToFavorites',
      'removeFromFavorites',
    ]),

    checkoutFavorite() {
      const id = this.item.id;
      if (this.isFavorite(id)) {
        favoritesService.delete(id);
        this.removeFromFavorites(id);
      }
      else {
        favoritesService.post({
          offer_id: id,
        });
        this.addToFavorites(id);
      }
    },
  },
};
</script>

<style scoped>
.item {
  position: relative;
}

.item__add-to-favorites-button {
  right: 8px;
  top: 4px;
}
</style>
