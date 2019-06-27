import multiguard from 'vue-router-multiguard';

import OfferShow from './OfferShow';
import OfferNew from './OfferNew';
import OfferEdit from './OfferEdit';

import requireAuth from '@frontend/core/services/requireAuth';
import requireOffer from './services/requireOffer';
import requireCategories from '@frontend/core/services/requireCategories';
import requireFavorites from '@frontend/modules/users/profile/favorites/services/requireFavorites';

export const OFFER_SHOW_ROUTER = {
  path: '/offer/:id',
  name: 'offerShow',
  component: OfferShow,
  beforeEnter: multiguard([requireOffer, requireCategories, requireFavorites])
};

export const OFFER_EDIT_ROUTER = {
  path: '/offer/:id/edit',
  name: 'offerEdit',
  component: OfferEdit,
  beforeEnter: multiguard([requireAuth, requireOffer, requireCategories]),
};

export const OFFER_NEW_ROUTER = {
  path: '/offer',
  name: 'offerNew',
  component: OfferNew,
  beforeEnter: multiguard([requireAuth, requireCategories])
};
