<template>
  <v-app>
    <AppAlert />
    <AppSidebar />
    <AppHeader />
    <AppNotifications />
    <AppLocaleSwitcher />
    <router-view 
      class="full_height" />
    <AppFooter />
  </v-app>
</template>

<script>
import AppHeader from './AppHeader';
import AppFooter from './AppFooter';
import AppSidebar from './AppSidebar';
import AppNotifications from './AppNotifications/AppNotifications';
import AppLocaleSwitcher from './AppLocaleSwitcher';
import AppAlert from './AppAlert';
import subscriptionsManager from  "@frontend/core/services/subscriptionsManager";
import permissionsManager from  "@frontend/core/services/permissionsManager";

import { mapGetters, mapMutations } from 'vuex';

export default {
  components: {
    AppHeader, AppFooter, AppSidebar, AppNotifications, AppAlert, AppLocaleSwitcher,
  },

  computed: {
    ...mapGetters([
      'currentUser',
      'authData',
    ])
  },

  channels: {
    PageNotificationsChannel: {
      received(data) {
        const notification = JSON.parse(data);

        this.addNotification(notification);
      },
    },
  },

  methods: {
    ...mapMutations([
      'addNotification',
    ])
  },

  created() {
    if (!this.currentUser.id) return;

    permissionsManager.requestNotifications().then(isGranted => {
      if (isGranted) subscriptionsManager.createSubscription();
    });
  },

  mounted() {
    if(!this.currentUser.id) return;

    this.$cable.subscribe({
      channel: 'PageNotificationsChannel',
      auth: { ...this.authData, 'access-token': this.authData.accessToken },
    });
  },
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
