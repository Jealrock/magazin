const state = {
  currentUser: {},
  signedIn: false,
  authData: {},
  userOffers: [],
}

const getters = {
  currentUser (state) {
    return state.currentUser;
  },

  authData (state) {
    return state.authData;
  },

  userOffers (state) {
    return state.userOffers;
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

  setUserOffers (state, offers) {
    state.userOffers = offers;
  },
}

export default {
  state,
  getters,
  mutations
}

