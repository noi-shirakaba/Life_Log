import Vue from 'vue'
import Router from 'vue-router'
import Top from '@/components/Top.vue'
import Home from '@/components/Home.vue'
import Login from '@/components/Login.vue'
import Form  from '@/views/LogForm.vue'
import Index from '@/views/LogIndex.vue'
import Show from '@/views/LogShow.vue'
import Edit from '@/views/Edit.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'Top',
      component: Top
    },
    {
      path: '/form',
      name: 'Form',
      component: Form
    },
    {
      path: '/index',
      name: 'Index',
      component: Index
    },
    {
      path:'/home',
      name: 'Home',
      component: Home
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/show/:id',
      name: 'Show',
      component: Show
    },
    {
      path: '/edit/:id',
      name: 'Edit',
      component: Edit
    }
  ]
})