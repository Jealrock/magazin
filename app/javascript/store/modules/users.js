import { axiosInstance } from '@frontend/core/services/axios';

const state = {
  currentUser: {},
  signedIn: false,
  access_token: null
}

const getters = {
  currentUser (state) {
    return state.currentUser
  }
}

const mutations = {
  setAccessToken (state, token) {
    state.access_token = token;
  },

  setCurrentUser (state, { currentUser }) {
    state.currentUser = currentUser
    state.signedIn = true
  },

  clearCurrentUser (state) {
    state.currentUser = {}
    state.signedIn = false
    state.access_token = null
  }
}

const actions = {
  signin({ dispatch }, { email, password }) {
    return axiosInstance.post('/signin', { email, password })
            .then(response => dispatch('updateCurrentUser', response))
            .catch(error => dispatch('propagateError', error))
  },

  signout({ dispatch, commit }) {
    return axiosInstance.delete('/logout')
      .then(response => {
        commit('clearCurrentUser')
        commit('clearOrdersData')
      })
      .catch(error => dispatch('propagateError', error))
  },

  resetPassword({ dispatch, commit }, { email }) {
    return axiosInstance.post('/password_resets', { email })
      .catch(error => dispatch('propagateError', error))
  },

  editPassword({ dispatch }, { token, password, password_confirmation }) {
    return axiosInstance.patch(
      '/password_resets/' + token,
      { password, password_confirmation })
        .then(response => dispatch('updateCurrentUser', response))
        .catch(error => dispatch('propagateError', error))
  },

  uploadLogo({ dispatch, commit }, { logo }) {
      let formData = new FormData();
      formData.append('logo', logo);
      return axiosInstance.patch(
        '/me',
        formData,
        { headers: { 'Content-Type': 'multipart/form-data' }})
          .then(response => commit('setCurrentUser', { currentUser: response.data }))
          .catch(error => dispatch('propagateError', error))
  },

  async updateCurrentUser({ dispatch, commit }, response) {
    if (!response.data.access) {
      dispatch('propagateError', response)
      return
    }
    commit('setAccessToken', response.data.access)
    await axiosInstance.get('/me')
      .then(meResponse => {
        commit('setCurrentUser', { currentUser: meResponse.data })
      })
      .catch(error => dispatch('propagateError', error))
  },

  propagateError({ commit }, error) {
    throw (error.response && error.response.data && error.response.data.error) || 'Unknown error'
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}

