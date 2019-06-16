<template>
  <div class="favorites-list">
    <v-container class="pa-0 px-3 pb-5">
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
      <v-layout row wrap>
        <v-flex xs12>
          <Gallery :items="allFavorites" />
        </v-flex>
      </v-layout>
      <v-layout row wrap justify-center>
        <v-pagination
          v-if="favoritesPaginationData.total_count > per_page"
          total-visible="per_page"
          circle
          :value="favoritesPaginationData.page"
          :length="favoritesPaginationData.pages"
          @input="changePage"
        ></v-pagination>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import { DEFAULT_PER_PAGE, favoritesService } from '@frontend/modules/favorites/services/favoritesService';

import CategoriesBar from '@frontend/modules/dashboard/categories/CategoriesBar';
import Gallery from '@frontend/modules/dashboard/gallery/Gallery';

export default {
  components: {
    CategoriesBar, Gallery,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE,
  }),

  computed: {
    ...mapGetters([
      'allFavorites',
      'favoritesPaginationData',
    ]),
  },

  methods: {
    ...mapMutations([
      'setFavorites'
    ]),

    loadFavorites() {
      favoritesService.all({
          ...this.$route.query, 
          per_page: this.per_page
        })
        .then((response) => {
          this.setFavorites(response);
        });
    },

    changePage(page) {
      this.$router.push({
        path: '/favorites',
        query: {
          ...this.$route.query,
          page: page,
        },
      });
    },
  },

  created() {
    this.loadFavorites();
  },

  watch: {
    '$route' : 'loadFavorites',
  },
};
</script>
