<template>
<div class="center">
  <form @submit.prevent="submit">
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
    <button type="submit">submit</button>
  </form>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  name: 'Form',
  data(){
    return {
      situation: ''
    }
  },
  methods: {
    submit(){
      const data = {situation: this.situation};
      axios.post(URL_BASE + 'api/v1/environments', data)
      .then((_response)=>{console.log(_response)})
    }
  }
}
</script>

<style>
.center {
  text-align: center;
}

</style>

