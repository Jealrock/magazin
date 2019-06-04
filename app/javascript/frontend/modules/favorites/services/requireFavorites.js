import store from '@/store/store';
import { favoritesService } from './favoritesService';

const requireFavorites = async function(to, from, next) {
  favoritesService.get()
    .then((response) => {
      const offers = response.data.data.map((offer) => offer.attributes);
      store.commit('setFavorites', offers);
    })
    .catch((error) => {
      throw new Error(error);
    });
  return next();
}

export default requireFavorites;
