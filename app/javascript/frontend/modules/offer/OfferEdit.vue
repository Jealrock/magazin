<template>
  <div class="offer-edit">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap>
        <v-flex xs12>
          <h1 class="title font-weight-regular grey--text my-3">Изменить объявление</h1>
          <v-divider></v-divider>
        </v-flex>
      </v-layout>
      <v-layout row wrap mt-4>
        <v-flex xs12>
          <OfferForm :method="'patch'" :offer-item="offer" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import OfferForm from './form/OfferForm';

import { mapGetters } from 'vuex';

export default {
  components: {
    OfferForm,
  },

  computed: {
    ...mapGetters({
      offer: 'getOffer',
    }),
  },
};
</script>
