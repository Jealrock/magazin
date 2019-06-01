<template>
  <div class="gallery">
    <h2 class="gallery__title">
      {{ title }}
    </h2>
    <v-container v-if="items.length" 
      grid-list-md class="pa-0">
      <v-layout row wrap>
        <v-flex v-for="item in items" :key="item.id"
          :class="`xs12 sm${columnPart}`">
          <GalleryItem :item="item" />
        </v-flex>
      </v-layout>
    </v-container>
    <v-layout v-else row wrap justify-center align-content-center class="gallery__items-placeholder">
      <p class="text-xs-center ma-0 headline grey--text">
        Здесь пока что пусто =(<br>
        <router-link to="/offer">
          Добавьте
        </router-link>
        объявление и станьте первым!
      </p>
    </v-layout>
  </div>
</template>

<script>
import GalleryItem from './GalleryItem';

const VUETIFY_GRID_COLUMNS = 12;

export default {
  components: {
    GalleryItem,
  },
  props: {
    title: {
      type: String,
      default: '',
    },
    items: {
      type: Array,
      default: () => [],
    },
    itemsInRow: {
      type: Number,
      default: 4,
    },
  },
  computed: {
    columnPart() {
      return VUETIFY_GRID_COLUMNS / this.itemsInRow;
    },
  },
};
</script>

<style scoped>
.gallery__items-placeholder {
  height: 300px;
}
</style>
