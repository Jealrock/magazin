import Vue from 'vue';
import Router from 'vue-router';
import Dashboard from '@frontend/modules/dashboard/Dashboard'
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';
import { OFFER_VIEW_ROUTER } from '@frontend/modules/offer-view/router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '*',
      redirect: '/'
    },
    DASHBOARD_ROUTER,
    OFFER_VIEW_ROUTER
  ]

});
