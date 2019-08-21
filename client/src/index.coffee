import Vue from 'vue'
import vuetify from './plugins/vuetify' # path to vuetify export
import 'roboto-fontface/css/roboto/roboto-fontface.css'
import '@mdi/font/css/materialdesignicons.css'


Vue.config.productionTip = false

import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)


param = require("jquery-param")
window._ = require('lodash')

import app    from './app.vue'
import router from './router'

new Vue({
  router: router
  vuetify: vuetify
  render: (h) -> h(app)
}).$mount('#app')
