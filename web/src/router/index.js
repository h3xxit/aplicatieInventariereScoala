import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import NotFound from '../views/NotFound.vue'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/:school/:id',
    name: 'Home',
    component: Home
  },
  {
    path: '/',
    name: 'NotFound',
    component: NotFound
  }
]

const router = new VueRouter({
  routes
})

export default router
