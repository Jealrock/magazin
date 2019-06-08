<template>
  <div>
    <AppSidebar />
    <AppHeader />
    <router-view />
    <AppFooter />
  </div>
</template>

<script>
import AppHeader from '@frontend/core/components/AppHeader';
import AppFooter from '@frontend/core/components/AppFooter';
import AppSidebar from '@frontend/core/components/AppSidebar';
import subscriptionsManager from  "@frontend/core/services/subscriptionsManager";

import { mapGetters } from 'vuex';

export default {
  components: {
    AppHeader, AppFooter, AppSidebar,
  },

  computed: {
    ...mapGetters(['currentUser'])
  },

  methods: {
    requestNotificationPermitions() {
      if (!('Notification' in window) || !this.currentUser.id) return;

      if (Notification.permission == "granted") {
        subscriptionsManager.createSubscription();
      } else {
        Notification.requestPermission().then((result) => {
          if (result === 'granted' ) {
            subscriptionsManager.createSubscription();
          }
          return;
        });
      }
    },
  },

  created() {
    this.requestNotificationPermitions();
  }
};
</script>

<style>
.theme--light.application {
  background: white;
}

@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
