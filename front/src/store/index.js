import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import auth from '@/store/modules/auth'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth
  },
  strict: true,
  plugins: [createPersistedState({
    key: 'LifeLogin',
    paths: [
      'auth.loggedIn',
      'auth.token',
      'auth.name',
    ],
    storage: sessionStorage
  })]
})