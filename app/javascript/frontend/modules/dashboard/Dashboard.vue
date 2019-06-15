<template>
  <div class="dashboard">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesBar />
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <Search />
        </v-flex>
      </v-layout>
      <v-layout row wrap class="mt-3">
        <v-flex xs12>
          <p class="body-2 font-weight-regular black--text mb-0">
            Всего обьявлений: 
            <span class="dashboard__items-count grey--text">{{ offersPaginationData.total_count }}</span>
          </p>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesList />
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <h2 class="title font-weight-bold mt-3 mb-2">Объявления</h2>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex class="pr-3"
          :class="{
            'xs3' : filtersVisibility,
            'd-none' : !filtersVisibility,
          }">
          <Filters />
        </v-flex>
        <v-flex :class="{
            'xs9' : filtersVisibility,
            'xs12' : !filtersVisibility,
          }">
          <Gallery
            :items="this.allOffers"
            :items-in-row="4"
          />
        </v-flex>
      </v-layout>
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
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

import { DEFAULT_PER_PAGE, offersService } from '@frontend/modules/offer/services/offersService';

import CategoriesBar from './categories/CategoriesBar';
import CategoriesList from './categories/CategoriesList';
import Search from './search/Search';
import Gallery from './gallery/Gallery';
import Filters from './filters/Filters';

export default {
  components: {
    CategoriesBar, CategoriesList, Search, Gallery, Filters,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE
  }),

  computed: {
    ...mapGetters(['allOffers', 'offersPaginationData']),

    filtersVisibility: function() {
      if(Object.keys(this.$route.query).length > 0) return true;
      else return false;
    },
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
          page: page 
        }
      })
    },
  },

  created() {
    this.loadOffers()
  },

  watch: {
    '$route': 'loadOffers'
  }
};
</script>
