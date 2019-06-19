<template>
  <div>
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesBar />
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <SearchBar />
        </v-flex>
      </v-layout>
      <v-layout row wrap class="mt-3">
        <v-flex xs12>
          <p class="body-2 font-weight-regular black--text mb-0">
            Найдено: 
            <span class="dashboard__items-count grey--text">{{ offersPaginationData.total_count }}</span>
          </p>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <h2 class="title font-weight-bold my-3">Поиск</h2>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs3>
          <Filters class="mr-3" />
        </v-flex>
        <v-flex xs9>
          <Gallery
            :items="this.allOffers"
            :items-in-row="4" />
          <v-layout row wrap justify-center>
            <v-pagination
              v-if="offersPaginationData.total_count > per_page"
              total-visible="per_page"
              circle
              :value="offersPaginationData.page"
              :length="offersPaginationData.pages"
              @input="changePage"
            ></v-pagination>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

import { DEFAULT_PER_PAGE, offersService } from '@frontend/modules/offer/services/offersService';

import CategoriesBar from '@frontend/modules/dashboard/categories/CategoriesBar';
import SearchBar from '@frontend/modules/dashboard/search-bar/SearchBar';
import Gallery from '@frontend/modules/dashboard/gallery/Gallery';
import Filters from '@frontend/modules/dashboard/filters/Filters';

export default {
  components: {
    CategoriesBar, SearchBar, Gallery, Filters,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE,
  }),

  computed: {
    ...mapGetters(['allOffers', 'offersPaginationData']),
  },

  watch: {
    '$route': 'loadOffers'
  },

  created() {
    this.loadOffers();
  },

  methods: {
    ...mapMutations(['setAllOffers']),

    ...mapActions(['showAlert']),

    loadOffers() {
      offersService.all(this.$route.query)
        .then((response) => {
          this.setAllOffers(response);
        })
        .catch((error) => {
          return this.$router.push('/');
        });
    },

    changePage(page) {
      this.$router.push({
        path: '/',
        query: {
          ...this.$route.query,
          page: page,
        },
      });
    },
  },
};
</script>
