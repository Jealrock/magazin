const state = {
  currentUser: {},
  signedIn: false,
  authData: {}
}

const getters = {
  currentUser (state) {
    return state.currentUser
  }
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
  }
}

export default {
  state,
  getters,
  mutations
}

