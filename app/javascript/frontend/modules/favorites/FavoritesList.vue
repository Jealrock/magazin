<template>
  <div class="favorites-index">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesBar />
        </v-flex>
      </v-layout>
      <v-divider />
      <v-layout row wrap class="mt-4">
        <v-flex xs12>
          <h1 class="headline font-weight-bold">
            Избранное
          </h1>
        </v-flex>
      </v-layout>
      <Gallery :items="allFavorites" />
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import CategoriesBar from '@frontend/modules/dashboard/categories/CategoriesBar';
import Gallery from '@frontend/modules/dashboard/gallery/Gallery';

export default {
  components: {
    CategoriesBar, Gallery,
  },

  computed: {
    ...mapGetters([
      'allFavorites',
    ]),
  },
};
</script>
