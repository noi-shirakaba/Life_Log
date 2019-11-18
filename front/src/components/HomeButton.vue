<template>
  <v-container fill-height>
    <v-layout column wrap text-center>
      <v-flex class="btn"><v-btn to="/form" rounded x-large>ログ入力</v-btn></v-flex>
      <v-flex><v-btn to="#" rounded x-large>ログ閲覧</v-btn></v-flex>
      <v-flex><v-btn to="/index" rounded x-large>ログ管理</v-btn></v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
 
}
</script>

<style scoped>
a {
  text-decoration: none;
}
a:link {
  color: var(--maincolor);
}
a:visited {
  color: var(--maincolor);
}
.btn{
  margin-top: 100px;
}
</style>
