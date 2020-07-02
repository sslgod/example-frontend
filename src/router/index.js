import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin'
import Signup from '@/components/Signup'
import Projects from '@/components/projects/Projects.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/projects',
      name: 'Projects',
      component: Projects
    }
  ]
})
