import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        logged_in: !!localStorage.getItem('nickname'),
        search_item: '',
        wiki_name: '',
        user: {
            nickname: localStorage.getItem('nickname') ?? "",
            type: localStorage.getItem('usertype') ?? 1,
            avatar: localStorage.getItem('avatar') ?? "",
            userID: localStorage.getItem('userID') ?? "", // username
        },
        sale: {
            'title': String,
            'owner': String,
            'picture_address': String,
            'owner_url': String,
            'price': -1,
            'sale_id': -1,
            'figure_id': -1,
            'owner_id': String,
            'merchandise_id': -1,
            'merchandise_kind': 0,
            'merchandise_status': 0,
        },
    },
    mutations: {
        login(state, data) {
            localStorage.setItem('nickname', data.nickname)
            localStorage.setItem('usertype', data.type)
            localStorage.setItem('avatar', data.avatar)
            localStorage.setItem('userID', data.username)
            state.logged_in = true;
            state.user.nickname = data.nickname;
            state.user.type = data.type;
            state.user.avatar = data.avatar;
            state.user.userID = data.username;
        },
        logout(state) {
            localStorage.removeItem('nickname')
            localStorage.removeItem('usertype')
            localStorage.removeItem('avatar')
            localStorage.removeItem('userID')
            localStorage.removeItem('token')
            state.logged_in = false;
            state.user.type = 1;
        },
        routeToSale(state, data) {
            state.sale = data;
        },
        commitSearch(state, data) {
            state.search_item = data;
        },
        wikiName(state, data) {
            console.log("wiki name is ", data)
            state.wiki_name = data;
        }
    },
    actions: {},
    modules: {}
})
