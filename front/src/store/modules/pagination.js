import axios from 'axios'
import { mapGetters } from 'vuex'
const URL_BASE = process.env.VUE_APP_ORIGIN;

export default {
  namespaced: true,
  state: {
    environments: []
  },
  mutations: {
    setEnvironments(state, payload){
      state.environments = payload
    }
  },
  action: {
    setEnvironments({commit}, payload){
      // return axios.get(URL_BASE + 'api/v1/environments')
      axios.get(URL_BASE + 'api/v1/environments.json', {
        headers: {
          Authorization: `Bearer ${this.getToken}`,
        }
      })
      .then(response => (this.environments = response.data))
    }
  }
}