import Vue from 'vue'
import Vuex from 'vuex'
// Import your vuex modules there
// import accounts from './modules/accounts/store'

Vue.use(Vuex)

export default new Vuex.Store({
  strict: true,
  state: {
    items: [{
      id: 0,
      coverImageUrl: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BBKHUZJ.img?h=416&w=624&m=6&q=60&u=t&o=f&l=f&x=1700&y=1854',
      title: 'Котя',
      price: 1000,
      location: 'Москва',
      publicationDate: new Date()
    }, {
      id: 1,
      coverImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f6/%D0%9A%D1%80%D0%BE%D0%BB%D0%B8%D0%BA_%D0%9F%D0%B0%D1%88%D0%B0_%D0%B2_%D0%B2%D0%BE%D0%B7%D1%80%D0%B0%D1%81%D1%82%D0%B5_1_%D0%BC%D0%B5%D1%81%D1%8F%D1%86%D0%B0.jpg',
      title: 'Кроля',
      price: 1500,
      location: 'Санкт-Петербург',
      publicationDate: new Date()
    }]
  },
  getters: {
    allItems: (state) => state.items,

    itemByID: (state) => (id) =>
      state.items.find(item => item['id'] === id)
  }
})
