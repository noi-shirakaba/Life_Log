<template>
<div id="signup">
  <h1>Sign Up</h1>
  <v-app>
    <v-form @submit.prevent="submitted">
      <input type="text" name="name" placeholder="名前">
      <input type="text" name="email" placeholder="メール">
      <input type="password" name="password" placeholder="パスワード">
      <v-btn
        type="submit"
        outlline rounded
      >
        登録
      </v-btn>
      <v-alert
        :value="alert"        
        type="error"
        border="bottom"
        dismissible
        transition="scale-transition"
      >
        登録出来ませんでした
      </v-alert>
    </v-form>
    <div id="nav">
      | <router-link to="/login">既に登録済の方はこちら</router-link> |
    </div>
  </v-app>
</div>
</template>

<script>
import axios from "axios";

const URL_BASE = process.env.VUE_APP_ORIGIN;
export default {
  data () {
    return {
      alert: false,
    }
  },
  methods: {
    submitted(e) {
      // 送信するデータを作る
      const data = new FormData(e.target)
      const obj = {
        user: {
          name: data.get("name"),
          email: data.get("email"),
          password: data.get("password")
        }
      }
      const config = {
        withCredentials: true,
      };
      axios.post(URL_BASE + '/api/v1/users', obj, config)
      .then(response => {
        const data = response.data;
        this.$router.replace('/login')
      })
      .catch(error => {
        this.alert = true;
        window.setTimeout(() => {
          this.alert = false;
        }, 1800);
      })
    },
  },
}
</script>