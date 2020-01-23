<template>
<div id="login">
  <h1>Login</h1>
  <v-app>
    <v-form @submit.prevent="submitted">
      <input type="text" name="email" v-model="email" placeholder="メール">
      <input type="password" name="password" v-model="password" placeholder="パスワード">
      <v-btn
        outlined
        rounded
        @click="onLogin"
      >
        ログイン
      </v-btn>
      <v-alert
        :value="info"
        type="info"
        border="bottom"
        dismissible
        transition="scale-transition"
      >
        {{ message }}
      </v-alert>
      <v-alert
        :value="alert"
        type="error"
        border="bottom"
        dismissible
        transition="scale-transition"
      >
        ログイン出来ませんでした
      </v-alert>
    </v-form>
    <div id="nav">
      | <router-link to="/signup">新規登録の方はこちら</router-link> |
    </div>
  </v-app>
</div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  props: {
    param: String,
  },
  data() {
    return {
      alert: false,
      info: false,
      email: '',
      password: '',
      message: '',
    }
  },
  mounted() {
    if (this.param === 'new') {
      this.message = "ユーザーを作成しました。ログインしてください。"
      this.info = true;
      window.setTimeout(() => {
        this.info = false;
      }, 1800);
    } else if (this.param === 'out') {
      this.message = "ログアウトしました。"
      this.info = true;
      window.setTimeout(() => {
        this.info = false;
      }, 1800);
    }
  },
  methods: {
    ...mapActions('auth', [
      'login'
    ]),

    onLogin() {
      this.login({
        email: this.email,
        password: this.password,
        router: this.$router
      })
      .catch(error => {
        this.alert = true;
        window.setTimeout(() => {
          this.alert = false;
        }, 1800);
      })
    }
  }
}
</script>