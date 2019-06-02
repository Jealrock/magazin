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

export default {
  components: {
    AppHeader, AppFooter, AppSidebar,
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
