<template>
<div id="signup">
  <h1>Sign Up</h1>
  <v-app>
    <v-form @submit.prevent="submitted">
      <div>
        <input type="text" name="name" placeholder="名前">
        <v-alert
          :value="alert_name"
          type="error"
          border="bottom"
          dismissible
          transition="scale-transition"
        >
          <div>{{ name_error }}</div>
        </v-alert>
      </div>
      <div>
        <input type="text" name="email" placeholder="メール">
        <v-alert
          :value="alert_email"
          type="error"
          border="bottom"
          dismissible
          transition="scale-transition"
        >
          <div>{{ email_error }}</div>
        </v-alert>
      </div>
      <div>
        <input type="password" name="password" placeholder="パスワード">
        <v-alert
          :value="alert_password"
          type="error"
          border="bottom"
          dismissible
          transition="scale-transition"
        >
          <div>{{ password_error }}</div>
        </v-alert>
      </div>
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
        <div>予期せぬエラーが発生しました。</div>
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
      alert_name: false,
      alert_email: false,
      alert_password: false,
      errors: {},
      name_error: '',
      email_error: '',
      password_error: '',
    }
  },
  watch: {
    errors() {
      this.name_error = ''
      this.email_error = ''
      this.password_error = ''

      if (this.errors["name"]) {
        this.name_error =  '名前' + this.errors["name"][0]
        this.alert_name = true;
        window.setTimeout(() => {
          this.alert_name = false;
        }, 1800);
      }
      if (this.errors["email"]) {
        this.email_error =  'メール' + this.errors["email"][0]
        this.alert_email = true;
        window.setTimeout(() => {
          this.alert_email = false;
        }, 1800);
      }
      if (this.errors["password"]) {
        this.password_error =  'パスワード' + this.errors["password"][0]
        this.alert_password = true;
        window.setTimeout(() => {
          this.alert_password = false;
        }, 1800);
      }
    },
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
        if (data.status == 200) {
          this.$router.replace('/login/new')
        } else {
          this.errors = data.errors
        }
        
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