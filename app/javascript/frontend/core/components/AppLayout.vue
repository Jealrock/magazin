<template>
  <v-app>
    <AppAlert />
    <AppSidebar />
    <AppHeader />
    <router-view />
  </v-app>
</template>

<script>
import AppHeader from './AppHeader';
import AppFooter from './AppFooter';
import AppSidebar from './AppSidebar';
import AppAlert from './AppAlert';
import subscriptionsManager from  "@frontend/core/services/subscriptionsManager";
import permissionsManager from  "@frontend/core/services/permissionsManager";

import { mapGetters } from 'vuex';

export default {
  components: {
    AppHeader, AppFooter, AppSidebar, AppAlert,
  },

  computed: {
    ...mapGetters(['currentUser'])
  },

  created() {
    if (!this.currentUser.id) return;

    permissionsManager.requestNotifications().then(isGranted => {
      if (isGranted) subscriptionsManager.createSubscription();
    });
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
