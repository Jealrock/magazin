import Profile from './profile/Profile'
import Settings from './profile/settings/Settings'
import CategorySubscriptionsList from './profile/category-subscriptions/CategorySubscriptionsList'
import FavoritesList from './profile/favorites/FavoritesList'
import Messages from './profile/messages/Messages.vue'
import requireAuth from '@frontend/core/services/requireAuth'
import requireFavorites from './profile/favorites/services/requireFavorites'
import requireCategorySubscriptions from './profile/category-subscriptions/services/requireCategorySubscriptions'
import requireCategories from '@frontend/core/services/requireCategories';

import multiguard from 'vue-router-multiguard'

export const PROFILE_ROUTER = {
  path: '/profile',
  component: Profile,
  beforeEnter: multiguard([requireAuth, requireFavorites]),
};

export const PROFILE_SETTINGS_ROUTER = {
  path: '/profile/settings',
  component: Settings,
  beforeEnter: requireAuth,
};

export const PROFILE_FAVORITES_ROUTER = {
  path: '/profile/favorites',
  name: 'favoritesList',
  component: FavoritesList,
  beforeEnter: requireAuth,
};

export const PROFILE_SUBSCRIPTIONS_ROUTER = {
  path: '/profile/subscriptions',
  name: 'subscriptionsList',
  component: CategorySubscriptionsList,
  beforeEnter: multiguard([requireAuth, requireCategories, requireCategorySubscriptions]),
};

export const PROFILE_MESSAGES_ROUTER = {
  path: '/profile/messages',
  component: Messages,
  beforeEnter: requireAuth
};
