import Vue from 'vue';
import Router from 'vue-router';
import Dashboard from '@frontend/modules/dashboard/Dashboard'
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';
import {
  SIGN_IN_ROUTER, SIGN_UP_ROUTER, RESET_PASSWORD_ROUTER, EDIT_PASSWORD_ROUTER,
} from '@frontend/modules/auth/router';
import { OFFER_SHOW_ROUTER, OFFER_NEW_ROUTER } from '@frontend/modules/offer/router';

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
  ]
});
