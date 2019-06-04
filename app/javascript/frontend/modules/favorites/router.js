import FavoritesIndex from './FavoritesIndex'

import requireFavorites from './services/requireFavorites'

export const FAVORITES_OFFER = {
  path: '/favorites',
  name: 'favoritesShow',
  component: FavoritesIndex,
  beforeEnter: requireFavorites,
}
