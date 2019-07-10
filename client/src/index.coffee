import Vue from 'vue'
import Vuetify from 'vuetify'
Vue.use(Vuetify)
import 'vuetify/dist/vuetify.min.css'

import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)


param = require("jquery-param")
window._ = require('lodash')

import app    from './app.vue'
import router from './router'

new Vue({
  el: '#app',
  router: router,
  render: (h) -> h(app)
})

