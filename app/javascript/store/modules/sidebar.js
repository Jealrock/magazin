const state = {
  aside: false,
};

const getters = {
  isAsideOpen(state) {
    return state.aside;
  },
};

const mutations = {
  setAside(state, value) {
    state.aside = value;
  }
};

export default {
  state,
  getters,
  mutations,
}
