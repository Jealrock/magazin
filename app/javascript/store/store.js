import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import offers from './modules/offers';
import users from './modules/users';
import favorites from './modules/favorites';
import routes from './modules/routes';
import sidebar from './modules/sidebar';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  modules: { offers, users, favorites, routes, sidebar },
  plugins: [createPersistedState({ paths: ['users'] })],
});
