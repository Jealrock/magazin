import categoriesService from '@frontend/core/services/categoriesService';

const state = {
  categories: [],
};

const getters = {
  mainCategories(state) {
    return state.categories.filter(category => category.parent_id == null);
  },

  childCategories(state) {
    return parentId => state.categories.filter(category => category.parent_id == parentId);
  },

  allCategories(state) {
    return state.categories;
  },

  getCategory(state) {
    return categoryId => state.categories.find(category => category.id == categoryId);
  },
};

const mutations = {
  setCategories(state, categories) {
    state.categories = categories;
  },
}

const actions = {
  loadCategories({ commit }) {
    return categoriesService.all()
      .then(resp => {
        commit('setCategories', resp.map(category => category.attributes));
      });
  }
}

export default {
  state,
  getters,
  mutations,
  actions
};
