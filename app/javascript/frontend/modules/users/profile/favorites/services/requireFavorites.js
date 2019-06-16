import store from '@/store/store';
import { favoritesService } from './favoritesService';

const requireFavorites = async function(to, from, next) {
  if (store.getters.currentUser.uid) {
    favoritesService.all()
      .then((response) => {
        store.commit('setFavorites', response);
      })
      .catch((error) => {
        throw new Error(error);
      });
  }
  return next();
}

export default requireFavorites;
