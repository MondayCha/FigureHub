import Vue from 'vue/dist/vue.esm.js'

import Antd from 'ant-design-vue';
// import Button from 'ant-design-vue/lib/button'
// import Textarea from 'ant-design-vue/lib/input/TextArea'
// import Datepicker from 'ant-design-vue/lib/date-picker'
// import Menu from 'ant-design-vue/lib/menu'
// import Space from 'ant-design-vue/lib/space'
// import Icon from 'ant-design-vue/lib/icon'
// import Layout from 'ant-design-vue/lib/layout'
// import Table from 'ant-design-vue/lib/table'
// import Popconfirm from 'ant-design-vue/lib/popconfirm'

import {
    message
} from 'ant-design-vue'

import 'ant-design-vue/dist/antd.less'

Vue.use(Antd);
// Vue.use(Button)
// Vue.use(Textarea)
// Vue.use(Datepicker)
// Vue.use(Menu)
// Vue.use(Space)
// Vue.use(Icon)
// Vue.use(Layout)
// Vue.use(Table)
// Vue.use(Popconfirm)

Vue.prototype.$message = message

message.config({
    duration: 1, // 持续时间
    top: '100px', // 到页面顶部距离
    maxCount: 3 // 最大显示数, 超过限制时，最早的消息会被自动关闭
})