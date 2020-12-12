import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/User/login/index'
import Register from '../views/User/register/index'
import User from '../views/User/User'

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Home',
        component: () => import(/* webpackChunkName: "about" */ '../views/HomePage/homePage')
    },
    {
        path: '/upload',
        name: 'Upload',
        component: () => import(/* webpackChunkName: "about" */ '../views/HomePage/homePage')
    },
    {
        path: '/aboutus',
        name: 'About',
        component: () => import(/* webpackChunkName: "about" */ '../views/About'),
    },
    {
        path: '/wiki',
        name: 'Wiki',
        component: () => import(/* webpackChunkName: "about" */ '../views/Wiki/wiki'),
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/register',
        name: 'Register',
        component: Register
    },
    {
        path: '/manage',
        name: 'Manage',
        redirect: '/manage/manufacturer',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/Manage.vue'),
        children: [
            {
                path: 'manufacturer',
                name: 'Manufacturer',
                component: () => import(/* webpackChunkName: "about" */ '../views/manage/Manufacturer.vue'),
            },
            {
                path: 'role',
                name: 'Role',
                component: () => import('../views/manage/Role.vue'),
                meta: {title: 'Role'}
            },
            {
                path: 'figure',
                name: 'Figure',
                component: () => import('../views/manage/Figure.vue'),
                meta: {title: 'Figure'}
            },
            {
                path: 'figure2role',
                name: 'Figure2Role',
                component: () => import('../views/manage/Figure2Role.vue'),
                meta: {title: 'Figure2Role'}
            },
        ]
    },
    {
        path: '/market',
        name: 'Market',
        component: () => import(/* webpackChunkName: "about" */ '../views/Shop/Market.vue')
    },
    {
        path: '/market/create',
        name: 'saleGood',
        component: () => import('../views/Shop/CreateGood')
    },
    {
        path: '/User/:id',
        name: 'User',
        component: User
    },
    {
        path: '/search/:value',
        name: 'Search',
        component: () => import('../views/HomePage/searchPage')
    },
    {
        path: '/home',
        name: 'Home',
        redirect: '/',
    },
    // {
    //   path: '/manage/role',
    //   name: 'Role',
    //   component: () => import('@/views/manage/Role.vue'),
    // },
]

const router = new VueRouter({
    routes
})

export default router
