import store from '@/store/store';

const requireUnauthorized= async function(to, from, next) {
    if (store.state.users.signedIn) {
      return next('/orders');
    } else {
      return next();
    }
};

export default requireUnauthorized;
