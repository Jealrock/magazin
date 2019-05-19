import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import users from './modules/users';
import routes from './modules/routes';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  modules: { users, routes },
  plugins: [createPersistedState({ paths: ['users'] })],
});
