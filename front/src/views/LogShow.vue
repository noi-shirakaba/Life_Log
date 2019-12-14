<template>
<div>
  <h2>{{ data.situation }}</h2>
  <button><router-link :to="{ name: 'Edit', params: { id: payload }}">編集</router-link></button>
</div>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

const URL_BASE = process.env.VUE_APP_ORIGIN
export default {
	data() {
		return {
			payload: this.$route.params.id,
			data: []
		}
	},
	mounted() {
		const payload = this.payload
		axios.get(URL_BASE + 'api/v1/environments/' + payload + '.json', {
  		headers: {
    		Authorization: `Bearer ${this.getToken}`,
  		}
		})
		.then(response => (this.data = response.data))
	},
	computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
	},
}
</script>

<style scoped>

</style>