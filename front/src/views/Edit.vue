<template>
<div>
	<h1>編集</h1>
  <h2>環境：{{ logdata.situation }}</h2>
	<form @submit.prevent="submit">
    <textarea name="edit" v-model="logdata.situation"></textarea>
    <button type="submit">変更する</button>
  </form>
	<button @click="deleteLog">削除する</button>
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
			logdata: []
		}
	},
	mounted() {
		const payload = this.payload
		axios.get(URL_BASE + 'api/v1/environments/' + payload + '.json', {
  		headers: {
    		Authorization: `Bearer ${this.getToken}`,
  		}
		})
		.then(response => (this.logdata = response.data))
	},
	computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
	},
	methods: {
    submit(){
			const payload = this.payload
			const logdata = {situation: this.logdata.situation}
			console.log(logdata)
      axios.put(URL_BASE + 'api/v1/environments/' + payload, logdata)
      .then((_response)=>{console.log(_response)})
		},
		deleteLog(){
			const payload = this.payload
			axios.delete(URL_BASE + 'api/v1/environments/' + payload)
			.then((_response)=>{console.log(_response)})
			this.$router.push({ path: '/index' })
			this.$router.go({ path: '/index' })
		}
  }
}
</script>

<style scoped>

</style>