<template>
  <div class="gallery">
    <v-container grid-list-lg pa-0>
      <h2 class="gallery__title">{{ title }}</h2>
      <v-layout row wrap>
        <v-flex :class="'xs12 sm' + (12 / itemsInRow)" v-for="item in items">
          <GalleryItem :item="item" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import GalleryItem from './GalleryItem'

export default {
  components: {
    GalleryItem
  },
  props: {
    title: String,
    items: Array,
    itemsInRow: {
      type: Number,
      default: 4
    }
  }
}
</script>
