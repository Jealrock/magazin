const state = {
  currentUser: {},
  signedIn: false,
  authData: {},
  userOffers: [],
  paginationData: {},
}

const getters = {
  currentUser (state) {
    return state.currentUser
  },

  userOffers (state) {
    return state.userOffers;
  },

  userOffersPaginationData (state) {
    return state.paginationData;
  },
}

const mutations = {
  setAuthData (state, headers) {
    state.authData = {
      accessToken: headers['access-token'],
      client: headers['client'],
      expiry: headers['expiry'],
      uid: headers['uid']
    }
  },

  setCurrentUser (state, currentUser) {
    state.currentUser = currentUser
    state.signedIn = true
  },

  clearUsersState (state) {
    state.currentUser = {}
    state.signedIn = false
    state.authData = {}
  },

  setUserOffers (state, data) {
    state.userOffers = data.data.map(offer => offer.attributes);
    state.paginationData = data.meta.pagination;
  },
}

export default {
  state,
  getters,
  mutations
}

