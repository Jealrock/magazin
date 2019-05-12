<template>
  <div class="profile">
    <svg class="profile__img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path fill-rule="nonzero" d="M10 0C4.48 0 0 4.48 0 10s4.48 10 10 10 10-4.48 10-10S15.52 0 10 0zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2a7.2 7.2 0 0 1-6-3.22c.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08a7.2 7.2 0 0 1-6 3.22z"/>
    </svg>
    <div class="profile__name">Hi, {{ name }}</div>
  </div>
</template>

<script>
export default {
  props: ['name']
};
</script>

<style scoped>
  .profile {
    position: relative;
    padding-left: 32px;
  }

  .profile__img {
    position: absolute;
    top: 50%;
    left: 0;
    transform: translateY(-50%);
    width: 20px;
    height: 20px;
    fill: #fff;
  }

  .profile__name {
    font-size: 14px;
    color: #fff;
  }
</style>
