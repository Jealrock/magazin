<template>
  <div class="user-profile">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap
        class="mt-3">
        <v-flex xs12 sm3>
          <ProfileNavigation :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"/>
        </v-flex>
        <v-flex xs12 sm9>
          <h1 class="font-weight-bold">Мои объявления</h1>
          <v-btn depressed flat
            class="button_green white--text body-1 font-weight-regular text-none px-3 ma-0 mt-2"
            @click="$router.push('/offer')">
            Подать объявление
          </v-btn>
          <v-divider class="my-3" />
          <p v-if="!userOffers.length">Пока у вас нет объявлений</p>
          <Gallery v-else
            :items="userOffers" 
            :items-in-row="4"/>
          <v-layout row wrap justify-center>
            <v-pagination
              v-if="userOffersPaginationData.total_count > per_page"
              total-visible="per_page"
              circle
              :value="userOffersPaginationData.page"
              :length="userOffersPaginationData.pages"
              @input="changePage" />
          </v-layout>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import { DEFAULT_PER_PAGE, usersService } from '@frontend/modules/users/services/usersService';

import Gallery from '@frontend/modules/dashboard/gallery/Gallery';
import ProfileNavigation from './ProfileNavigation';

export default {
  components: {
    Gallery, ProfileNavigation,
  },

  data: () => ({
    per_page: DEFAULT_PER_PAGE,
  }),

  computed: {
    ...mapGetters([
      'userOffers',
      'userOffersPaginationData',
    ]),
  },

  created() {
    this.loadOffers();
  },

  methods: {
    ...mapMutations([
      'setUserOffers',
    ]),

    loadOffers() {
      usersService.getOffers(this.$route.query)
        .then((response) => {
          this.setUserOffers(response);
        })
        .catch((error) => {
          return this.$router.push('/');
        });
    },

    changePage(page) {
      this.$router.push({
        path: '/profile',
        query: {
          ...this.$route.query,
          page: page,
        },
      });
    },
  },

  watch: {
    '$route' : 'loadOffers',
  },
};
</script>

<style>
.button {
  &_green {
    background: #97cf27;
  }
}
</style>
