import { favoritesService } from '@frontend/modules/users/profile/favorites/services/favoritesService';

const state = {
  favorites: [],
  paginationData: {},
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
  },

  favoritesPaginationData(state) {
    return state.paginationData;
  },
};

const mutations = {
  setFavorites(state, data) {
    state.favorites = data.data.map(offer => offer.attributes);
    state.paginationData = data.meta.pagination;
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
