<template>
  <v-app>
    <component :is="layout">
      <router-view />
    </component>
  </v-app>
</template>

<script>
const DEFAULT_LAYOUT = 'app';

export default {
  computed: {
    layout() {
      return `${(this.$route.meta.layout || DEFAULT_LAYOUT)}-layout`;
    },
  },
};
</script>
