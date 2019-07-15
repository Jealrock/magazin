<template>
  <nav class="nav categories-bar align-center py-1">
    <v-img :src="appLogo" 
      :max-width="'110px'" />
    <router-link :to="offerTypeLink('ExchangeOffer')"
      class="link link_blue body-1 py-2 px-3"
    >Обменяю</router-link>
    <router-link :to="offerTypeLink('CashOffer')"
      class="link link_blue body-1 py-2 pr-3"
    >Продам</router-link>
    <router-link :to="offerTypeLink('ServiceOffer')"
      class="link link_blue body-1 py-2 pr-3"
    >Услуги</router-link>
    <router-link :to="offerTypeLink('FreeOffer')"
      class="link link_blue body-1 py-2 pr-3"
    >Подарю БисмилЛах1</router-link>
    <router-link :to="offerTypeLink(null)"
      class="link link_blue body-1 py-2 pr-3"
    >Все</router-link>
    <v-menu :max-width="875" 
      offset-y>
      <template v-slot:activator="{ on }">
        <span
          class="link link_blue body-1 py-2 pr-3"
          style="cursor: pointer;"
          v-on="on"
        >ещё...</span>
      </template>
      <v-layout row wrap class="white">
        <v-flex v-for="(main, mainIndex) in mainCategories"
          :key="mainIndex"
          class="pa-2">
          <router-link :to="categoryLink(main.title)"
            class="link link_blue body-1 font-weight-bold">
            {{ main.title }}
          </router-link>
          <router-link v-for="(child, childIndex) in childCategories(main.id)"
            :to="categoryLink(child.title)"
            class="link link_blue caption d-block">
            {{ child.title }}
          </router-link>
        </v-flex>
      </v-layout>
    </v-menu>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data: () => ({
    appLogo: require('@frontend/assets/logo.png'),
  }),

  computed: {
    ...mapGetters(['allCategories', 'mainCategories', 'childCategories']),

    categoryLink() {
      return title => {
        const category = this.allCategories.find(category => category.title == title);
        if (!category) return { path: '/search' };

        return {
          path: '/search',
          query: {
            by_category_id: category.id
          }
        }
      };
    },

    offerTypeLink() {
      return (title) => {
        return {
          path: '/search',
          query: {
            by_type: title,
          },
        }
      };
    },
  },
}
</script>
