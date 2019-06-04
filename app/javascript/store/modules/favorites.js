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
    state.favorites = state.favorites.concat([{id: offer}]);
  },

  removeFromFavorites(state, id) {
    const index = state.favorites.findIndex((fav) => fav.id === id);
    const favs = state.favorites;
    favs.splice(index, 1);
    state.favorites = favs;
  },
};

const actions = {
};

export default {
  state,
  getters,
  mutations,
  actions,
};
