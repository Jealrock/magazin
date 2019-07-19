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
          <SearchBar />
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
          <h2 class="title font-weight-bold my-3">Объявления</h2>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <Gallery
            :items="this.allOffers"
            :items-in-row="4" />
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
import SearchBar from './search-bar/SearchBar';
import Gallery from './gallery/Gallery';

export default {
  components: {
    CategoriesBar, SearchBar, Gallery,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE,
  }),

  computed: {
    ...mapGetters(['allOffers', 'offersPaginationData']),
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

  created() {
    this.loadOffers();
  },

  channels: {
    PageNotificationsChannel: {
      connected() {
        console.log('Connected!');
      },

      rejected() {
        console.log('Rejected!');
      },

      received(data) {
        debugger;
        const message = data;
        console.log(message);
      },

      disconnected() {
        console.log('Disconnected!');
      },
    }
  },

  mounted() {
    this.$cable.subscribe({
      channel: 'PageNotificationsChannel',
    });
  },

  watch: {
    '$route': 'loadOffers'
  },
};
</script>
