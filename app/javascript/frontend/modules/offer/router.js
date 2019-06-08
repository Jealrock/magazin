import OfferShow from './OfferShow';
import OfferNew from './OfferNew';

import multiguard from 'vue-router-multiguard';

import requireAuth from '@frontend/core/services/requireAuth';
import requireOffer from './services/requireOffer';
import requireFavorites from '@frontend/modules/favorites/services/requireFavorites';

export const OFFER_SHOW_ROUTER = {
  path: '/offer/:id',
  name: 'offerShow',
  component: OfferShow,
  beforeEnter: multiguard([requireOffer, requireFavorites]),
};

export const OFFER_NEW_ROUTER = {
  path: '/offer',
  name: 'offerNew',
  component: OfferNew,
  beforeEnter: requireAuth,
}
