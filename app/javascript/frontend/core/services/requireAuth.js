import store from '@/store/store';

const requireAuth = async function(to, from, next) {
  console.log(store.state.users)
  if (!store.state.users.signedIn) {
    store.commit('clearUsersState');
    store.commit('setBeforeAuthRoute', to.fullPath);
    return next('/sign_in');
  } else {
    return next();
  }
};

export default requireAuth;
