<template>
  <div class="item">
    <router-link
      :to="`/offer/${item.id}`">
      <v-card class="elevation-0">
        <v-img
          :src="item.coverImageUrl"
          alt="photo"
          :class="'indigo'"
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
export default {
  props: {
    item: Object,
  },
  
  computed: {
    price() {
      if (this.item.type === 'CashOffer') return this.item.price + ' руб.';
      if (this.item.type === 'ExchangeOffer') {
        if (this.item.exchange_item) return `Обмен на ${this.item.exchange_item.toLowerCase()}`;
        return 'Обмен';
      }
      if (this.item.type === 'FreeOffer') return 'Отдам даром';
      return 'Уточнить';
    }
  }
};
</script>
