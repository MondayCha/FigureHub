import Vue from 'vue/dist/vue.esm.js'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import './dependences/antdv.js'
import dict from './dependences/dictionary.js'
import global_variable from "@/dependences/global_variable";

Vue.config.productionTip = false
Vue.use(router)
Vue.use(ElementUI)

Vue.prototype.$axios = axios
Vue.prototype.$dict = dict
Vue.prototype.$global = global_variable
axios.defaults.baseURL = 'http://localhost:2333'


new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app')
