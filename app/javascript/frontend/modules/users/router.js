import Profile from './Profile.vue'
import Settings from './Settings.vue'
import requireAuth from '@frontend/core/services/requireAuth'

export const PROFILE_ROUTER = {
  path: '/profile',
  component: Profile,
  beforeEnter: requireAuth
};

export const PROFILE_SETTINGS_ROUTER = {
  path: '/profile/settings',
  component: Settings,
  beforeEnter: requireAuth
};
