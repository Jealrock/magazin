<template>
  <div class="locale-switcher elevation-2"
    :class="{
      'd-none' : $vuetify.breakpoint.xsOnly
    }">
    <div class="locale-switcher__icon pa-2 cursor_pointer"
      @click="switchLocale('en')">
      <v-img :src="enFlag"
        :width="'14px'" />
    </div>
    <div class="locale-switcher__icon pa-2 cursor_pointer"
      @click="resetLocale">
      <v-img :src="ruFlag"
        :width="'14px'" />
    </div>
  </div>
</template>

<script>
import translateService from '@frontend/core/services/translationService';

export default {
  data: () => ({
    ruFlag: require('@frontend/assets/ru-flag.svg'),
    enFlag: require('@frontend/assets/en-flag.svg')
  }),

  created() {
  },

  methods: {
    switchLocale(lang) {
      translateService.translate(lang);
    },

    resetLocale() {
      translateService.reset();
    },
  },
};
</script>

<style>
.locale-switcher {
  position: absolute;
  top: 70px;
}
</style>
