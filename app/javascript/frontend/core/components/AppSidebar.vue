<template>
  <div>
    <v-navigation-drawer absolute app temporary
      v-model="aside">
      <v-toolbar flat>
        <v-list>
          <v-list-tile>
            <v-list-tile-title class="title">
              Application
            </v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-toolbar>
    </v-navigation-drawer>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

export default {
  computed: {
    ...mapGetters([
      'getAside',
    ]),

    aside: {
      get() {
        return this.getAside;
      },

      set(value) {
        this.setAside(value);
      },
    },
  },

  methods: {
    ...mapMutations([
      'setAside',
    ]),
  },
};
</script>
