import axios from 'axios'
const URL_BASE = process.env.VUE_APP_ORIGIN;

export default {
  namespaced: true,
  state: {
    loggedIn: false,
    token: '',
    name: '',
  },

  getters: {
    getToken(state) {
      return state.token
    },
    getName(state) {
      return state.name
    }
  },

  mutations: {
    login(state) {
      state.loggedIn = true
    },
    logout(state) {
      state.loggedIn = false
    },
    setToken(state, payload) {
      state.token = payload.token
    },
    setName(state, payload) {
      state.name = payload.name
    }
  },

  actions: {
    login({ commit }, payload) {
      return axios.post(URL_BASE + 'api/v1/users/login', {
        user: {
          email: payload.email,
          password: payload.password
        }
      }).then((response) => {
        commit('login')
        commit('setToken', response.data)
        commit('setName', response.data)
        payload.router.push('/home')
      })
    }
  }
}