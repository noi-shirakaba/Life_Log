<template>
  <form @submit.prevent="submit">
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
    <button type="submit">submit</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  name: 'From',
  data(){
    return {
      situation: ''
    }
  },
  methods: {
    submit(){
      const data = {situation: this.situation};
      console.log(data)
      axios.post('http://localhost:3000/environments', data)
    }
  }
}
</script>

<style>

</style>

