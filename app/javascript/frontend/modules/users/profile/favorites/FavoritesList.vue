<template>
  <div class="favorites-list">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap
        class="mt-3">
        <v-flex xs12 sm3>
          <ProfileNavigation :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"/>
        </v-flex>
        <v-flex xs12 sm9>
          <h1 class="font-weight-bold">Избранное</h1>
          <v-divider class="my-3" />
          <Gallery :items="allFavorites"
            :items-in-row="4" />
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
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import Gallery from '@frontend/modules/dashboard/gallery/Gallery';
import ProfileNavigation from '@frontend/modules/users/profile/ProfileNavigation';

import { DEFAULT_PER_PAGE, favoritesService } from './services/favoritesService';

export default {
  components: {
    Gallery, ProfileNavigation,
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
