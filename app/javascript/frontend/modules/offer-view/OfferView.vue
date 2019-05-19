<template>
  <div class="item-view">
    <v-container class="pa-0 px-3">
      <v-layout row wrap>
        <v-flex xs12>
          {{ item.title }}
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters([
      'itemByID'
    ]),
    item() {
      const itemID = Number(this.$route.params.id)

      return this.itemByID(itemID)
    }
  },
}
</script>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
