<template>
  <div class="notifications">
    <div v-if="allNotifications.length"
      :class="{
        'pa-3' : $vuetify.breakpoint.smAndUp,
      }">
      <AppNotification v-for="(item, index) in allNotifications"
        :key="index"
        :notification-item="item"
        :notification-index="index" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import AppNotification from './AppNotification';

export default {
  components: {
    AppNotification,
  },

  computed: {
    ...mapGetters([
      'allNotifications',
    ]),
  },
};
</script>

<style>

.notifications {
  position: fixed;
  right: 0px;
  bottom: 0px;
  max-width: 500px;
  width: 100%;
  z-index: 100
}
</style>
