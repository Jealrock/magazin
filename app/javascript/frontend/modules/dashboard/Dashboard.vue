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
          <p class="body-2 font-weight-regular black--text mb-1">
            Все объявления в
            <span class="dashboard__location">Москве</span>:
            <span class="dashboard__items-count grey--text">0</span>
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
          <Gallery
            title="Обьявления"
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
      <!-- <v-layout row wrap> -->
      <!--   <v-flex xs12> -->
      <!--     <Gallery title="Новые объявления" /> -->
      <!--   </v-flex> -->
      <!-- </v-layout> -->
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import { DEFAULT_PER_PAGE, offersService } from '@frontend/modules/offer/services/offersService';

import CategoriesBar from './categories/CategoriesBar';
import CategoriesList from './categories/CategoriesList';
import Search from './search/Search';
import Gallery from './gallery/Gallery';

export default {
  components: {
    CategoriesBar, CategoriesList, Search, Gallery,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE
  }),

  computed: {
    ...mapGetters(['allOffers', 'offersPaginationData'])
  },

  methods: {
    ...mapMutations(['setAllOffers']),

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
        query: { page }
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
