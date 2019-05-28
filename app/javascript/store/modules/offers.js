const state = {
  offers: [],
  offer: {},
  paginationData: {},
  isOfferLoaded: false
};

const getters = {
  allOffers(state) {
    return state.offers;
  },

  getOffer(state) {
    return state.offer;
  },

  offersPaginationData(state) {
    return state.paginationData;
  },

  isOfferLoaded(state) {
    return state.isOfferLoaded;
  }
};

const mutations = {
  setOffer(state, offer) {
    state.offer = offer;
    state.isOfferLoaded = true;
  },

  setAllOffers(state, data) {
    state.offers = data.data.map(offer => offer.attributes);
    state.paginationData = data.meta.pagination;
  }
}

const actions = {
}

export default {
  state,
  getters,
  mutations,
};
