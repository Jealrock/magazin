const state = {
  isOpen: false,
  type: null,
  text: null,
};

const getters = {
  getAlertVisibility(state) {
    return state.isOpen;
  },

  getAlertType(state) {
    return state.type;
  },

  getAlertText(state) {
    return state.text;
  },
};

const mutations = {
  setAlertVisibility(state, value) {
    state.isOpen = value;
  },

  setAlertType(state, value) {
    state.type = value;
  },

  setAlertText(state, value) {
    state.text = value;
  },
};

const actions = {
  showAlert({commit}, {type, text}) {
    commit('setAlertVisibility', true);
    commit('setAlertType', type);
    commit('setAlertText', text);
  }
};

export default {
  state,
  getters,
  mutations,
  actions,
}
