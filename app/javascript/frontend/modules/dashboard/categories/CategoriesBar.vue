<template>
  <nav class="nav categories-bar">
    <router-link :to="categoryLink('Автомобили')"
      class="link link_blue body-1 py-2 pr-3"
    >Авто</router-link>
    <router-link :to="categoryLink('Недвижимость')"
      class="link link_blue body-1 py-2 pr-3"
    >Недвижимость</router-link>
    <router-link :to="categoryLink('Услуги')"
      class="link link_blue body-1 py-2 pr-3"
    >Услуги</router-link>
    <router-link :to="categoryLink('Работа')"
      class="link link_blue body-1 py-2 pr-3"
    >Работа</router-link>
    <v-menu offset-y>
      <template v-slot:activator="{ on }">
        <span
          class="link link_blue body-1 py-2 pr-3"
          style="cursor: pointer;"
          v-on="on"
        >Eщё...</span>
      </template>
      <v-layout class="white">
        <v-flex xs12 md-3 v-for="(main, mainIndex) in mainCategories" :key="mainIndex">
          <div>
            <router-link :to="categoryLink(main.title)"
              class="link link_blue body-1 py-2 pr-3"
            >{{ main.title }}</router-link>
          </div>

          <div
            v-for="(child, childIndex) in childCategories(main.id)"
            :key="childIndex"
          >
            <router-link 
              :to="categoryLink(child.title)"
              class="link link_blue body-1 py-2 pr-3"
            >{{ child.title }}</router-link>
          </div>
        </v-flex>
      </v-layout>
    </v-menu>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters(['allCategories', 'mainCategories', 'childCategories']),

    categoryLink() {
      return title => {
        const category = this.allCategories.find(category => category.title == title);
        if (!category) return { path: '/' };

        return {
          path: '/',
          query: {
            by_category_id: category.id
          }
        }
      };
    }
  },
}
</script>
