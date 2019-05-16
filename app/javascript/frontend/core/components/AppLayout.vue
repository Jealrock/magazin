<template>
  <div>
    <AppHeader/>
    <router-view></router-view>
    <AppFooter/>
  </div>
</template>

<script>
import AppHeader from '@frontend/core/components/AppHeader';
import AppFooter from '@frontend/core/components/AppFooter';

export default {
  components: {
    AppHeader, AppFooter
  }
}
</script>
