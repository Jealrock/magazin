<template>
  <header class="header">
    <div class="wrapper">
      <div class="header__content">
        <router-link class="header__box header__box--logo" as="div" :to="{ path: '/' }">
          <svg class="header__logo" xmlns="http://www.w3.org/2000/svg" width="122" height="39">
            <g fill-rule="evenodd">
              <path d="M36.687 0H2.314A2.313 2.313 0 0 0 0 2.313v34.374A2.313 2.313 0 0 0 2.314 39h34.373A2.312 2.312 0 0 0 39 36.687V2.313A2.312 2.312 0 0 0 36.687 0zM2.314 36.687V2.314h34.373v34.373H2.314zm12.591-10.204c-.024 1.165-1.13 2.039-2.41 2.029-1.282-.011-2.334-.892-2.376-2.065-.04-1.159-.022-2.323-.004-3.482.013-.862.52-1.51 1.304-1.905 1.076-.542 2.214-.98 3.5-1.537 0 2.438.032 4.7-.014 6.96zm3.072-13.686c-.016-2.152-1.346-3.84-3.406-4.486-2.297-.718-4.853-.167-6.315 1.376-1.16 1.225-1.245 2.645-1.216 4.113h3.063c-.003-.355-.002-.697.008-1.04.038-1.302 1.053-2.217 2.418-2.21 1.365.008 2.363.924 2.39 2.23.021 1.074-.03 2.15.021 3.225.025.524-.19.784-.7.982-1.346.523-2.702 1.034-4.006 1.64-2.102.977-2.94 2.088-3.122 3.897a19.889 19.889 0 0 0 .006 4.265c.334 2.884 2.532 4.366 5.993 4.198 2.84-.136 4.845-2.055 4.866-4.759.033-4.475.028-8.953 0-13.431zm5.265 9.603c.117-.876.313-1.305 1.13-1.796 1.22-.733 3.27-1.328 4.445-2.125 1.351-.915 2.016-2.273 2.15-3.831.072-.846.031-1.863-.18-2.968-.447-2.361-2.813-3.846-5.575-3.665-3.293.217-4.99 1.755-5.191 4.739a13.76 13.76 0 0 0-.02 1.024h3.004c.03-.539.065-1.07.158-1.59.169-.932 1.027-1.545 2.083-1.655.917-.095 1.884.365 2.327 1.106 1.038 1.732.693 4.32-1.237 5.21-1.426.657-2.71 1.112-3.865 1.67-2.085 1.009-2.432 2.356-2.419 4.226.002.398 0 7.854-.001 8.255h10.864v-2.723H23.09c.042-2.4.107-5.547.152-5.877z"/>
              <text font-family="Roboto-Bold, Roboto" font-size="18" font-weight="bold">
                <tspan x="51" y="26">Terminal</tspan>
              </text>
            </g>
          </svg>
        </router-link>
        <template v-if="loggedIn">
          <div class="header__box header__box--data">
            <div class="header__item">
              <div class="header__item-box header__item-box--profile">
                <Profile :name="currentUser.full_name"/>
              </div>
              <div class="header__item-box">
                <button class="header-logout" type="button">
                  <svg class="header-logout__icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 18 18">
                    <path fill-rule="nonzero" d="M7.09 12.59L8.5 14l5-5-5-5-1.41 1.41L9.67 8H0v2h9.67l-2.58 2.59zM16 0H2a2 2 0 0 0-2 2v4h2V2h14v14H2v-4H0v4a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V2c0-1.1-.9-2-2-2z"/>
                  </svg>
                  <div class="header-logout__text"
                    @click="logout"
                  >Log out</div>
                </button>
              </div>
            </div>
          </div>
        </template>
      </div>
    </div>
  </header>
</template>

<script>
import Profile from '@frontend/core/components/header/Profile';
import userAuthService from '@frontend/core/services/userAuthService';
import { mapGetters } from 'vuex'

export default {
  components: {
    Profile
  },

  computed: {
    loggedIn: function() {
      return (this.$route.path != "/sign");
    },
    currentUser: function() {
      return userAuthService.currentUser;
    }
  },

  methods: {
    logout: function() {
      userAuthService.logout();
      this.$router.push("/sign");
    }
  }
};
</script>

<style scoped>
  .header {
    display: block;
    background-color: #092843;
    box-shadow: 0 1px 2px 0 rgba(0,0,0,0.15);
  }

  .header__content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 13px 0;
    height: 66px;
    box-sizing: border-box;
  }

  .header__box--data {
    flex: 1;
    display: flex;
    justify-content: space-between;
    padding-left: 36px;
  }

  .header__logo {
    display: block;
    width: 122px;
    height: 39px;
    fill: #fff;
    @media (--phone-viewport) {
      width: 39px;
      text {
        display: none;
      }
    }
  }

  .header__item {
    display: flex;
    margin: 0 -16px;
  }

  .header__item-box {
    padding: 0 16px;
  }

  .header__item-box--profile {
    @media (--tablet-viewport) {
      display: none;
    }
  }

  .header-logout {
    position: relative;
    display: block;
    padding-right: 32px;
    opacity: .6;
    transition: opacity .3s ease;
    cursor: pointer;
    user-select: none;
    &:hover {
      opacity: 1;
    }
  }

  .header-logout__text {
    font-size: 14px;
    color: #fff;
    @media (--tablet-viewport) {
      display: none;
    }
  }

  .header-logout__icon {
    position: absolute;
    top: 0;
    right: 0;
    width: 18px;
    height: 18px;
    fill: #fff;
  }
</style>
