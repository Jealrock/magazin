import store from '@/store/store';
import { categorySubscriptionsService } from './categorySubscriptionsService';

const requireCategorySubscriptions = async function(to, from, next) {
  if (store.getters.currentUser.uid) {
    categorySubscriptionsService.all()
      .then((response) => {
        store.commit('setAllCategoriesSubscriptions', response);
      })
      .catch((error) => {
        throw new Error(error);
      });
  }
  return next();
}

export default requireCategorySubscriptions;
