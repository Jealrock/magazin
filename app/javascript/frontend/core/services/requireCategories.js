import store from '@/store/store';

const requireCategories = async function(to, from, next) {
    if (store.state.categories.categories.length == 0) {
      store.dispatch('loadCategories');
      return next();
    } else {
      return next();
    }
};

export default requireCategories;
