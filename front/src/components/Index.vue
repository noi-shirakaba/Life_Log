<template>
<div class="center">
  <p v-for="env in environments" :key="env.id">{{env.situation}}</p>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  name: 'Index',
  data(){
    return {
      environments: []
    }
  },
  mounted() {
    axios.get(URL_BASE + 'api/v1/environments.json')
    .then(response => (this.environments = response.data))
  }
}
</script>

<style>
.center {
  text-align: center;
}

</style>

