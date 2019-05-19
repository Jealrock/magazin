import '@babel/polyfill';
import Vue from 'vue';
import App from '@frontend/App.vue';
import router from '@frontend/router';
import VueAxios from 'vue-axios';
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';
import VueMoment from 'vue-moment';
import VueLodash from 'vue-lodash';

import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import VeeValidate from 'vee-validate';
import { axiosInstance } from '@frontend/core/services/axios';

import AppLayout from '@frontend/core/components/AppLayout';
import store from '../store/store';

Vue.component('app-layout', AppLayout);

const moment = require('moment')
require('moment/locale/ru')

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('app'));

  Vue.use(VueAxios, axiosInstance);
  Vue.use(Loading);
  Vue.use(VueMoment);
  Vue.use(VueLodash);
  Vue.use(Vuetify);
  Vue.use(VeeValidate);
  Vue.use(VueMoment, {
    moment
  })

  new Vue({ // eslint-disable-line no-new
    el,
    router,
    axiosInstance,
    store,
    render: h => h(App),
  });
});

// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks';
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
