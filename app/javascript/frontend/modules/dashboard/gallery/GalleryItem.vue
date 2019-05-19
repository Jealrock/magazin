<template>
  <div class="item">
    <a :href="`/offer/${item.id}`">
    <v-card class="elevation-0">
      <v-img :src="item.coverImageUrl"
        aspect-ratio="1.5"></v-img>
      <v-card-title class="px-0">
        <div class="body-2">
          <p class="item__title font-weight-bold primary--text text--accent-4 ma-0">{{ item.title }}</p>
          <p class="item__price ma-0 font-weight-bold">{{ item.price }}</p>
          <p class="item__location ma-0 font-weight-regular black--text">{{ item.location }}</p>
          <p class="item__publication-date ma-0 font-weight-regular grey--text text--lighten-1">{{ item.publicationDate | moment('calendar') }}</p>
        </div>
      </v-card-title>
    </v-card>
    </a>
  </div>
</template>

<style>
.item {
  cursor: pointer;
}
</style>

<script>
export default {
  props: {
    item: Object
  }
}
</script>
