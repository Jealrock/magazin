import Profile from './Profile.vue'
import Settings from './Settings.vue'
import Messages from './Messages.vue'
import requireAuth from '@frontend/core/services/requireAuth'
import requireOffers from './services/requireOffers'

import multiguard from 'vue-router-multiguard'

export const PROFILE_ROUTER = {
  path: '/profile',
  component: Profile,
  beforeEnter: multiguard([requireAuth, requireOffers]),
};

export const PROFILE_SETTINGS_ROUTER = {
  path: '/profile/settings',
  component: Settings,
  beforeEnter: requireAuth
};

export const PROFILE_MESSAGES_ROUTER = {
  path: '/profile/messages',
  component: Messages,
  beforeEnter: requireAuth
};
