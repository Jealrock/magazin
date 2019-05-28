const state = {
  offers: [],
  offer: {
    id: null,
  },
  isOfferLoaded: false,
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
  },

  isOfferLoaded(state) {
    return state.isOfferLoaded;
  }
};

const mutations = {
  setOffer(state, offer) {
    state.offer = offer;
    state.isOfferLoaded = true;
  }
}

const actions = {
}

export default {
  state,
  getters,
  mutations,
};
