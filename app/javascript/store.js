import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        isLoggedIn: false,
        current_user: {}
    },
    getters: {
        isLoggedIn: state => state.isLoggedIn,
        current_user: state => state.current_user
    },
    mutations: {
        isLoggedIn(state, status){
            state.isLoggedIn = status;
        },
        current_user(state, status) {
            state.current_user = status;
        }
    },
    actions: {
        isLoggedIn(context, status) {
            context.commit("isLoggedIn", status);
        },
        current_user(context, status) {
            context.commit("current_user", status);
        }
    },
    
    plugins: [createPersistedState()],
})