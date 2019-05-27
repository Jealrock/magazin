import store from '@/store/store';
import { offersService } from './offersService';

const requireOffer = async function(to, from, next) {
  const offer_id = to.params.id;
  if (store.state.offers.offer.id === undefined)
    offersService.getOffer(offer_id)
      .then((response) => {
        store.commit('setOffer', response.data.data.attributes)
      })
      .catch((error) => {
        return next('/');
      });
  return next();
}

export default requireOffer;
