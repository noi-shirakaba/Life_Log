<template>
  <form @submit.prevent="submitted">
    <input type="text" name="email" placeholder="メール">
    <input type="password" name="password" placeholder="パスワード">
    <button type="submit">ログイン</button>
  </form>
</template>

<script>
import axios from "axios";

const URL_BASE = process.env.VUE_APP_ORIGIN;

export default {
  name: 'Login',
  methods: {
    submitted(e) {
      // 送信するデータを作る
      const data = new FormData(e.target);
      const obj = {
        user: {
          email: data.get("email"),
          password: data.get("password"),
        }
      };
      //API option
      const config = {
        withCredentials: true,
      };

      // 送信する
      axios.post(URL_BASE + '/api/v1/users/login', obj, config).then(response => {
        // ログインに成功した
        const data = response.data;
        // 画面移動
        this.$router.replace(this.$route.query.redirect || '/home')
        // LocalStorage に トークンを保存する
        localStorage.token = data.token;
      }, error => {
        // ログインに失敗した
        const data = error.response.data;
        // 失敗した理由を alert で表示する
        alert(data.errors[0]);
      });
    },
  },
}
</script>

<style scoped>
</style>