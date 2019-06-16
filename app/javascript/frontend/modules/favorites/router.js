import FavoritesList from './FavoritesList'

import multiguard from 'vue-router-multiguard'

import requireAuth from '@frontend/core/services/requireAuth'
import requireFavorites from './services/requireFavorites'

export const FAVORITES_LIST = {
  path: '/favorites',
  name: 'favoritesList',
  component: FavoritesList,
  beforeEnter: multiguard([requireAuth]),
}
