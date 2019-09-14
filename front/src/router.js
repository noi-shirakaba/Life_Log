import Vue from 'vue'
import Router from 'vue-router'
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