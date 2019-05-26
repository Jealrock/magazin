<template>
  <div class="offer-view">
    <v-container class="pa-0 px-3">
      <v-layout
        row
        wrap
      >
        <v-flex xs12>
          <Search />
        </v-flex>
      </v-layout>
      <v-layout
        row
        wrap
        align-center
        mt-5
      >
        <v-flex xs6>
          <h1>{{ offer.title }}</h1>
        </v-flex>
        <v-flex xs6>
          <p class="headline ma-0 text-xs-right">
            {{ offer.price }}
          </p>
        </v-flex>
        <v-flex xs12>
          <p>Размещено {{ offer.publicationDate | moment('calendar').toLowerCase() }}</p>
        </v-flex>
      </v-layout>
      <v-layout
        row
        wrap
      >
        <v-flex xs9>
          <img
            :src="offer.coverImageUrl"
            alt=""
            aspect-ratio="1"
          >
        </v-flex>
        <v-flex xs3>
          <v-btn
            depressed
            color="info"
          >
            Показать телефон
          </v-btn>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import Search from '@frontend/modules/dashboard/search/Search';

export default {
  computed: {
    ...mapGetters([
      'offerByID',
    ]),
    offer() {
      const offerID = Number(this.$route.params.id);

      return this.offerByID(offerID);
    },
  },
  components: {
    Search,
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
