import Vue from 'vue';
import Router from 'vue-router';
import Dashboard from '@frontend/modules/dashboard/Dashboard'
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';
import { ITEM_VIEW_ROUTER } from '@frontend/modules/item-view/router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '*',
      redirect: '/'
    },
    DASHBOARD_ROUTER,
    ITEM_VIEW_ROUTER
  ]

});
