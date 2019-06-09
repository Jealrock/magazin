import { favoritesService } from '@frontend/modules/favorites/services/favoritesService';

const state = {
  favorites: [],
};

const getters = {
  allFavorites(state) {
    return state.favorites;
  },

  isFavorite(state) {
    const ids = state.favorites.map((fav) => fav.id);

    return function(id) {
      return ids.includes(id);
    }
  }
};

const mutations = {
  setFavorites(state, favoriteOffers) {
    state.favorites = favoriteOffers
  },

  addToFavorites(state, offer) {
    state.favorites = state.favorites.concat([offer]);
  },

  removeFromFavorites(state, id) {
    const index = state.favorites.findIndex((fav) => fav.id === id);
    const favs = state.favorites;
    favs.splice(index, 1);
    state.favorites = favs;
  },
};

const actions = {
  async toggleFavorite(context, offer_id) {
    if(context.getters.isFavorite(offer_id)) {
      return favoritesService.delete(offer_id)
        .then((response) => {
          context.commit('removeFromFavorites', response.data.data.attributes.id);
        });
    } else {
      return favoritesService.create({ offer_id: offer_id })
        .then((response) => {
          context.commit('addToFavorites', response.data.data.attributes);
        });
    }
  },
};

export default {
  state,
  getters,
  mutations,
  actions,
};
