import Vue from 'vue'
import App from './App.vue'
import store from './store'
import vuetify from './plugins/vuetify'
import router from './router.js'
import paginate from 'vuejs-paginate'
import dotenv from 'dotenv';

Vue.config.productionTip = false
Vue.component('paginate', paginate)
dotenv.config()

new Vue({
  store,
  vuetify,
  router,
  paginate,
  render: h => h(App)
}).$mount('#app')
