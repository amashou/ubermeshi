import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        isLoggedIn: false
    },
    getters: {
        inLoggedIn: state => state.isLoggedIn
    },
    mutations: {
        isLoggedIn(state, status){
            state.isLoggedIn = status;
        }
    },
    actions: {
        isLoggedIn(context, status) {
            context.commit("isLoggedIn", status);
        }
    }

})