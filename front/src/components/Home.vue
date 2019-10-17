<template>
<div class="home">
  <h1>Home</h1>
  <button type="submit">確認</button>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  data(){
    return {
      environments: []
    }
  },
  mounted() {
  }
}
</script>

<style scoped>
</style>
