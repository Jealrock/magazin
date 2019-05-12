<template>
  <div>
    <AppHeader/>
    <router-view></router-view>
  </div>
</template>

<script>
import AppHeader from '@frontend/core/components/AppHeader';
export default {
  components: {
    AppHeader
  }
}
</script>
