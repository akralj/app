import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

# add your routes here
import home from './pages/home.vue'
import user from './pages/user.vue'


export default new Router({
  routes: [
    {
      path: '/'
      name: 'Home page title'
      component: home
    }
    {
      path: '/user'
      name: 'User page title'
      component: user
    }
  ]
})
