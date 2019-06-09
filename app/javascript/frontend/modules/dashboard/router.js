import Dashboard from './Dashboard'
import requireCategories from '@frontend/core/services/requireCategories';

export const DASHBOARD_ROUTER = {
  path: '/',
  name: 'dashboard',
  component: Dashboard,
  beforeEnter: requireCategories
}
