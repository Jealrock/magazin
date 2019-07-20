<template>
  <div class="notifications"
    :class="{
      'pa-3' : $vuetify.breakpoint.smAndUp,
    }">
    <AppNotification v-for="(item, index) in allNotifications"
      :key="index"
      :notification-item="item"
      :notification-index="index" />
  </div>
</template>

<script>
import AppNotification from './AppNotification';
import { mapGetters, mapMutations } from 'vuex';

export default {
  components: {
    AppNotification,
  },

  computed: {
    ...mapGetters([
      'allNotifications',
    ]),
  },

  methods: {
    ...mapMutations([
      'addNotification',
    ]),
  },
};
</script>

<style>

.notifications {
  position: fixed;
  right: 0px;
  bottom: 0px;
  max-width: 400px;
  width: 100%;
  z-index: 100
}
</style>
