<template>
<div class="center">
  <ul v-for="env in environments" :key="env.id">
    <li><router-link :to="{ name: 'Show', params: { id: env.id }}">{{env.situation}}</router-link></li>
  </ul>
</div>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  data(){
    return {
      environments: []
    }
  },
  computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
  },
  mounted() {
    axios.get(URL_BASE + 'api/v1/environments.json', {
  		headers: {
    		Authorization: `Bearer ${this.getToken}`,
  		}
		})
    .then(response => (this.environments = response.data))
  },
}
</script>

<style>
.center {
  text-align: center;
}

</style>

