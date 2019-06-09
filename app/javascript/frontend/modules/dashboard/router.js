import Dashboard from './Dashboard'
import requireFavorites from '@frontend/modules/favorites/services/requireFavorites';

export const DASHBOARD_ROUTER = {
  path: '/',
  name: 'dashboard',
  component: Dashboard,
  beforeEnter: requireFavorites
}
