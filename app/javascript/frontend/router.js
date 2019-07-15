import Vue from 'vue';
import Router from 'vue-router';
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';
import {
  SIGN_IN_ROUTER, SIGN_UP_ROUTER, RESET_PASSWORD_ROUTER, EDIT_PASSWORD_ROUTER,
} from '@frontend/modules/auth/router';
import {
  PROFILE_ROUTER, PROFILE_SETTINGS_ROUTER, PROFILE_FAVORITES_ROUTER,
  PROFILE_SUBSCRIPTIONS_ROUTER, PROFILE_MESSAGES_ROUTER,
} from '@frontend/modules/users/router';
import {
  OFFER_SHOW_ROUTER, OFFER_EDIT_ROUTER, OFFER_NEW_ROUTER
} from '@frontend/modules/offer/router';
import { SEARCH_ROUTER } from '@frontend/modules/search/router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '*',
      redirect: '/',
    },
    DASHBOARD_ROUTER,
    SIGN_IN_ROUTER,
    SIGN_UP_ROUTER,
    RESET_PASSWORD_ROUTER,
    EDIT_PASSWORD_ROUTER,
    OFFER_NEW_ROUTER,
    OFFER_SHOW_ROUTER,
    OFFER_EDIT_ROUTER,
    PROFILE_ROUTER,
    PROFILE_SETTINGS_ROUTER,
    PROFILE_MESSAGES_ROUTER,
    PROFILE_FAVORITES_ROUTER,
    PROFILE_SUBSCRIPTIONS_ROUTER,
    SEARCH_ROUTER,
  ],
});
