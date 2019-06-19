<template>
  <component :is="layout">
    <router-view />
  </component>
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
