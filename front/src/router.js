import Vue from 'vue'
import Router from 'vue-router'
import EnvForm  from './views/EnvForm.vue'
import Index from './views/EnvironmentIndex.vue'
import Show from './views/EnvShow.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'EnvForm',
      component: EnvForm
    },
    {
      path: '/index',
      name: 'Index',
      component: Index
    },
    {
      path: '/show/:id',
      name: 'Show',
      component: Show
    }
  ]
})