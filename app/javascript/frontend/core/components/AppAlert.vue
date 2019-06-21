<template>
  <div>
    <v-snackbar
      v-model="snackbar"
      :color="getAlertType"
      :top="true">
      {{ getAlertText }}
      <v-btn
        flat
        icon
        color="white"
        @click="setAlertVisibility(false)">
        <v-icon>cancel</v-icon>
      </v-btn>
    </v-snackbar>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

export default {
  computed: {
    ...mapGetters([
      'getAlertVisibility',
      'getAlertType',
      'getAlertText',
    ]),

    snackbar: {
      get() {
        return this.getAlertVisibility;
      },

      set(value) {
        this.setAlertVisibility(value);
      },
    },
  },

  methods: {
    ...mapMutations([
      'setAlertVisibility',
    ]),

    ...mapActions([
      'showAlert',
    ]),
  },
};
</script>
