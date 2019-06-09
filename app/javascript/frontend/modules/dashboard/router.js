import multiguard from 'vue-router-multiguard';

import Dashboard from './Dashboard'

import requireCategories from '@frontend/core/services/requireCategories';
import requireFavorites from '@frontend/modules/favorites/services/requireFavorites';

export const DASHBOARD_ROUTER = {
  path: '/',
  name: 'dashboard',
  component: Dashboard,
  beforeEnter: multiguard([requireCategories, requireFavorites])
}
