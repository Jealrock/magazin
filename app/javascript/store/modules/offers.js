const state = {
  offers: [],
  offer: {}
};

const getters = {
  allOffers(state) {
    return state.offers;
  },

  offerByID(state) {
    return function (id) {
      return state.offers.find(offer => offer.id === id);
    };
  },

  getOffer(state) {
    return state.offer;
  }
};

const mutations = {
  setOffer(state, offer) {
    state.offer = offer;
  }
}

const actions = {
}

export default {
  state,
  getters,
  mutations,
};
