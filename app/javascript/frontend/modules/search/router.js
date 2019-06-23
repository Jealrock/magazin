import Search from './Search'

import multiguard from 'vue-router-multiguard'

import requireCategories from '@frontend/core/services/requireCategories'
import requireFavorites from '@frontend/modules/users/profile/favorites/services/requireFavorites'
import requireCategorySubscriptions from '@frontend/modules/users/profile/category-subscriptions/services/requireCategorySubscriptions'

export const SEARCH_ROUTER = {
  path: '/search',
  name: 'search',
  component: Search,
  beforeEnter: multiguard([requireCategories, requireFavorites, requireCategorySubscriptions]),
}
