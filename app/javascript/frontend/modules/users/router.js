import Profile from './Profile.vue'
import Settings from './Settings.vue'
import requireAuth from '@frontend/core/services/requireAuth'
import requireFavorites from '@frontend/modules/favorites/services/requireFavorites'

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
