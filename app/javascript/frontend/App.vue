<template>
  <v-app>
    <component :is="layout">
      <router-view />
    </component>
  </v-app>
</template>

<script>
const defaultLayout = 'app'

export default {
  computed: {
    layout() {
      return `${(this.$route.meta.layout || defaultLayout)}-layout`
    },
  },
};
</script>

<style scoped>
.theme--light.application {
  background: white;
}
</style>
