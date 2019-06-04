<template>
  <div class="favorites-index">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex v-for="(item, index) in allFavorites" xs3>
          <p>{{ item }}</p>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import { favoritesService } from './services/favoritesService';

export default {
  computed: {
    ...mapGetters([
      'allFavorites',
    ]),
  },
};
</script>
