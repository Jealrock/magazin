import FavoritesIndex from './FavoritesIndex'

import multiguard from 'vue-router-multiguard'

import requireAuth from '@frontend/core/services/requireAuth'
import requireFavorites from './services/requireFavorites'

export const FAVORITES_OFFER = {
  path: '/favorites',
  name: 'favoritesShow',
  component: FavoritesIndex,
  beforeEnter: multiguard([requireAuth, requireFavorites]),
}
