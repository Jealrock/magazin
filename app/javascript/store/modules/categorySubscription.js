const state = {
  categorySubscriptions: [],
  paginationData: {},
};

const getters = {
  getAllCategoriesSubscriptions(state) {
    return state.categorySubscriptions;
  },

  isSubscribed(state) {
    const ids = state.categorySubscriptions.map((sub) => sub.id);

    return (id) => ids.includes(id);
  },
};

const mutations = {
  setAllCategoriesSubscriptions(state, data) {
    state.categorySubscriptions = data.data.map((category) => category.attributes);
    state.paginationData = data.meta.pagination;
  },

  addCategorySubscription(state, subscription) {
    state.categorySubscriptions = state.categorySubscriptions.concat([subscription]);
  },

  removeCategorySubscription(state, id) {
    const index = state.categorySubscriptions.findIndex((sub) => sub.id === id);

    const subs = state.categorySubscriptions;
    subs.splice(index, 1);
    state.categorySubscriptions = subs;
  },
};

const actions = {
};

export default {
  state,
  getters,
  mutations,
  actions,
};
