<template>
  <form @submit.prevent="submit">
    <textarea name="environment"></textarea>
    <button type="submit">submit</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  name: 'From',
  methods: {
    submit(e){
    // 本来はajax通信をする
    console.log('exec')
    console.log(e)
    axios.post('http://localhost:3000/')
  }
}
}
</script>

<style>

</style>

