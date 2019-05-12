import Vue from 'vue';
import Router from 'vue-router';
import AppLayout from '@frontend/core/components/AppLayout';
import { SIGN_ROUTER } from '@frontend/modules/sign/router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
     {
       path: '*',
       redirect: '/'
    },
    {
      path: '/',
      component: AppLayout,
      children: [
        SIGN_ROUTER
      ]
    }
  ]
});
