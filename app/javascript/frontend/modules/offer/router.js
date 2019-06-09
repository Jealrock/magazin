import multiguard from 'vue-router-multiguard';

import OfferShow from './OfferShow';
import OfferNew from './OfferNew';

import requireAuth from '@frontend/core/services/requireAuth';
import requireOffer from './services/requireOffer';
import requireCategories from '@frontend/core/services/requireCategories';

export const OFFER_SHOW_ROUTER = {
  path: '/offer/:id',
  name: 'offerShow',
  component: OfferShow,
  beforeEnter: multiguard([requireOffer, requireCategories])
};

export const OFFER_NEW_ROUTER = {
  path: '/offer',
  name: 'offerNew',
  component: OfferNew,
  beforeEnter: multiguard([requireAuth, requireCategories])
}
