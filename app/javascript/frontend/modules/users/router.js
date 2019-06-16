import Profile from './profile/Profile'
import Settings from './profile/settings/Settings'
import FavoritesList from './profile/favorites/FavoritesList'
import requireAuth from '@frontend/core/services/requireAuth'
import requireFavorites from './profile/favorites/services/requireFavorites'

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
