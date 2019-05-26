import OfferShow from './OfferShow';
import OfferNew from './OfferNew';

import requireAuth from '@frontend/core/services/requireAuth';

export const OFFER_SHOW_ROUTER = {
  path: '/offer/:id',
  name: 'offerShow',
  component: OfferShow,
};

export const OFFER_NEW_ROUTER = {
  path: '/offer/new',
  name: 'offerNew',
  component: OfferNew,
  beforeEnter: requireAuth
}
