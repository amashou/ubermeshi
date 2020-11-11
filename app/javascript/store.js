import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        isLoggedIn: false,
        current_user: {},
        postsInfo: {},
        postInfo: {}
    },
    getters: {
        isLoggedIn: state => state.isLoggedIn,
        current_user: state => state.current_user,
        postsInfo: state => state.postsInfo,
        postInfo: state => state.postInfo,
    },
    mutations: {
        isLoggedIn(state, status){
            state.isLoggedIn = status;
        },
        current_user(state, status) {
            state.current_user = status;
        },
        postsInfo(state,status) {
            state.postsInfo = status;
        },
        postInfo(state, status){
            state.postInfo = status;
        }
    },
    actions: {
        isLoggedIn(context, status) {
            context.commit("isLoggedIn", status);
        },
        current_user(context, status) {
            context.commit("current_user", status);
        },
        postsInfo(context, status) {
            context.commit("postsInfo", status);
        },
        postInfo(context, status) {
            context.commit("postInfo", status);
        }
    },
    
    plugins: [createPersistedState()],
})