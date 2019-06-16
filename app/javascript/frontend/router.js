import Vue from 'vue';
import Router from 'vue-router';
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';
import {
  SIGN_IN_ROUTER, SIGN_UP_ROUTER, RESET_PASSWORD_ROUTER, EDIT_PASSWORD_ROUTER,
} from '@frontend/modules/auth/router';
import { PROFILE_ROUTER, PROFILE_SETTINGS_ROUTER } from '@frontend/modules/users/router';
import { OFFER_SHOW_ROUTER, OFFER_NEW_ROUTER } from '@frontend/modules/offer/router';
import { FAVORITES_LIST } from '@frontend/modules/favorites/router';
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
    PROFILE_ROUTER,
    PROFILE_SETTINGS_ROUTER,
    FAVORITES_LIST,
    SEARCH_ROUTER,
  ],
});
