import OfferShow from './OfferShow';
import OfferNew from './OfferNew';

import requireAuth from '@frontend/core/services/requireAuth';
import requireOffer from './services/requireOffer';

export const OFFER_SHOW_ROUTER = {
  path: '/offer/:id',
  name: 'offerShow',
  component: OfferShow,
  beforeEnter: requireOffer
};

export const OFFER_NEW_ROUTER = {
  path: '/offer',
  name: 'offerNew',
  component: OfferNew,
  beforeEnter: requireAuth
}
