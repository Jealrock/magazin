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
      </v-layout>
      <v-layout
        row
        wrap
        class="mt-3"
      >
        <v-flex xs12>
          {{ offer.updated_at }}
        </v-flex>
        <v-flex xs9>
          <div class="offer-view__image-placeholder"></div>
        </v-flex>
        <v-flex xs3>
          {{ offer.phone_number }}
          {{ offer.email }}
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          {{ offer.location }}
        </v-flex>
        <v-flex xs12>
          {{ offer.description }}
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import Search from '@frontend/modules/dashboard/search/Search';

import { mapGetters } from 'vuex';

export default {
  components: {
    Search,
  },

  computed: {
    ...mapGetters({
      offer: 'getOffer',
    }),
  },
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
  background: #f0f0f0;
}
</style>
