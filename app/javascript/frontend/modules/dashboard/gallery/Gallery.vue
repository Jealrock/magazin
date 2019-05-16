<template>
  <div class="gallery">
    <v-container grid-list-lg pa-0>
      <h2 class="gallery__title">{{ title }}</h2>
      <v-layout row wrap>
        <v-flex v-for="j in 4" :class="'sm' + (12 / itemsInRow)">
          <Item class="gallery__item" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import Item from './GalleryItem'

export default {
  components: {
    Item
  },
  props: {
    title: String,
    itemsInRow: {
      type: Number,
      default: 4
    }
  }
}
</script>
