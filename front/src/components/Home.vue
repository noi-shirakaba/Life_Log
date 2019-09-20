<template>
<div class="user">
  <button type="submit">確認</button>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  name: 'Home',
  data(){
    return {
      environments: []
    }
  },
  mounted() {
  }
}
</script>

<style>
.center {
  text-align: center;
}

</style>
