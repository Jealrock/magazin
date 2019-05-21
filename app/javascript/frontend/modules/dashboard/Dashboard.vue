<template>
  <div class="dashboard">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex sm12>
          <nav class="nav">
            <a
              href="#"
              class="header__link pl-0"
            >Авто</a>
            <a
              href="#"
              class="header__link"
            >Недвижимость</a>
            <a
              href="#"
              class="header__link"
            >Работа</a>
            <a
              href="#"
              class="header__link"
            >Услуги</a>
            <a
              href="#"
              class="header__link"
            >ещё...</a>
          </nav>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex sm12>
          <Search />
        </v-flex>
      </v-layout>
      <v-layout row wrap class="mt-3">
        <v-flex xs12>
          <p class="body-2 font-weight-regular black--text mb-1">
            Все объявления в
            <span class="dashboard__location">Москве</span>:
            <span class="dashboard__items-count grey--text">1 178 011</span>
          </p>
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex xs12>
          <CategoriesList />
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex sm12>
          <Gallery
            title="VIP-объявления"
            :items="allItems"
            :items-in-row="3"
          />
        </v-flex>
      </v-layout>
      <v-layout row wrap>
        <v-flex sm12>
          <Gallery title="Новые объявления" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import CategoriesList from './categories-list/CategoriesList';
import Search from './search/Search';
import Gallery from './gallery/Gallery';

export default {
  components: {
    CategoriesList, Search, Gallery,
  },
  computed: {
    ...mapGetters([
      'allOffers',
    ]),
    allItems() {
      return this.allOffers;
    },
  },
};
</script>

<style>
.dashboard .header__link {
  color: #0091d9;
}
</style>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
