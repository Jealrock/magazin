const state = {
  notifications: [],
};

const getters = {
  allNotifications(state) {
    return state.notifications;
  },
};

const mutations = {
  addNotification(state, value) {
    state.notifications = state.notifications.concat([value]);
  },

  deleteNotification(state, index) {
    const notifications = state.notifications;
    notifications.splice(index, 1);

    state.notifications = notifications;
  },
};

const actions = {
};

export default {
  state,
  getters,
  mutations,
  actions,
}
