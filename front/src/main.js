import Vue from 'vue'
import App from './App.vue'
import store from './store'
import vuetify from './plugins/vuetify'
import router from './router.js'
import 'material-icons/iconfont/material-icons.css'
import dotenv from 'dotenv';

Vue.config.productionTip = false
dotenv.config()


new Vue({
  store,
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
