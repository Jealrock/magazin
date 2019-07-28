import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import offers from './modules/offers';
import users from './modules/users';
import favorites from './modules/favorites';
import routes from './modules/routes';
import sidebar from './modules/sidebar';
import categories from './modules/categories';
import alert from './modules/alert';
import categorySubscription from './modules/categorySubscription';
import notifications from './modules/notifications';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  modules: {
    offers,
    users,
    favorites,
    routes,
    sidebar,
    categories,
    alert,
    categorySubscription,
    notifications,
  },
  plugins: [createPersistedState({ paths: ['users'] })],
});
