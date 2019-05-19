const state = {
  beforeAuthRoute: null
}

const mutations = {
  setBeforeAuthRoute(state, route) {
    state.beforeAuthRoute = route
  }
}

export default {
  state,
  mutations
}

