import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        logged_in: false,
        user: {
            nickname: "",
            type: 1,
            avatar: "",
            userID: "", // username
        },
    },
    mutations: {
        login(state, data) {
            state.logged_in = true;
            state.user.nickname = data.nickname;
            state.user.type = data.type;
            state.user.avatar = data.avatar;
        },
        logout(state) {
            state.logged_in = false;
            state.user.type = 1;
        }
    },
    actions: {},
    modules: {}
})
