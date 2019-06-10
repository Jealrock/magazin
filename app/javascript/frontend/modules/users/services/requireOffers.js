import store from '@/store/store';
import usersService from './usersService';

const requireOffers = async function(to, from, next) {
  if (store.getters.currentUser.id) {
    usersService.getOffers()
      .then((response) => {
        const offers = response.map((resp) => resp.attributes);
        store.commit('setUserOffers', offers);
      })
      .catch((error) => {
        throw new Error(error);
      });
  }
  return next();
}

export default requireOffers;
