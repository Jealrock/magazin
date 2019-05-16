import Vue from 'vue';
import Router from 'vue-router';
import { DASHBOARD_ROUTER } from '@frontend/modules/dashboard/router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '*',
      redirect: '/'
    },
    DASHBOARD_ROUTER
  ]

});
