import Vue from 'vue'
import Router from 'vue-router'
import Top from '@/views/Top.vue'
import Login from '@/views/Login.vue'
import Logout from '@/views/Logout.vue'
import SignUp from '@/views/SignUp.vue'
import Home from '@/views/Home.vue'
import Form  from '@/views/LogForm.vue'
import Index from '@/views/LogIndex.vue'
import Show from '@/views/LogShow.vue'
import Edit from '@/views/Edit.vue'
import Store from '@/store/index.js'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'Top',
      component: Top,
      meta: {
        isPublic: true
      }
    },
    {
      path: '/signup',
      name: 'SignUp',
      component: SignUp,
      meta: {
        isPublic: true
      }
    },
    { 
      path: '/login/:param?',
      name: 'Login',
      component: Login,
      props: true,
      meta: {
        isPublic: true
      }
    },
    { 
      path: '/logout',
      name: 'Logout',
      component: Logout,
      meta: {
        isPublic: false
      }
    },
    {
      path:'/home',
      name: 'Home',
      component: Home,
      meta: {
        isPublic: false
      }
    },
    {
      path: '/form',
      name: 'Form',
      component: Form,
      meta: {
        isPublic: false
      }
    },
    {
      path: '/index',
      name: 'Index',
      component: Index,
      meta: {
        isPublic: false
      }
    },
    {
      path: '/show/:id',
      name: 'Show',
      component: Show,
      meta: {
        isPublic: false
      }
    },
    {
      path: '/edit/:id',
      name: 'Edit',
      component: Edit,
      meta: {
        isPublic: false
      }
    },
  ]
})
router.beforeEach((to, from, next) => {
  if(to.matched.some(page => page.meta.isPublic) && !Store.state.auth.loggedIn) {
    // 未ログイン
    next()
  } else {
    if(to.matched.some(page => !page.meta.isPublic) && Store.state.auth.loggedIn) {
      // ログイン
      next()
    } else {
      if (Store.state.auth.loggedIn) {
        next('/home')
      } else {
        next('/')
      }
    }
  }
})

export default router