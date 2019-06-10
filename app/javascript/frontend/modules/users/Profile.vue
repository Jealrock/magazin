<template>
  <div class="user-profile">
    <v-container class="pa-0 px-3">
      <v-layout row wrap
        class="mt-3">
        <v-flex xs12 sm3>
          <div class="grey lighten-3 px-3 py-2">
            <router-link to="/profile/settings"
              class="link link_green body-1 font-weight-bold">
              Настройки
            </router-link>
          </div>
        </v-flex>
        <v-flex xs12 sm9 class="pl-3">
          <h1 class="font-weight-bold">Ваши объявления</h1>
          <v-divider class="mb-3" />
          <p v-if="!userOffers.length">Пока у вас нет объявлений</p>
          <Gallery v-else
            :items="userOffers" 
            :items-in-row="3"/>
          <v-btn depressed flat
            class="button_green white--text body-1 font-weight-regular text-none px-3 ma-0"
            @click="$router.push('/offer')">
            Подать объявление
          </v-btn>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import Gallery from '@frontend/modules/dashboard/gallery/Gallery';

export default {
  components: {
    Gallery,
  },

  computed: {
    ...mapGetters([
      'userOffers',
    ]),
  },
};
</script>

<style>
.button {
  &_green {
    background: #97cf27;
  }
}
</style>
