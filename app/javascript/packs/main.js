
import Vue from 'vue';
import App from '../app.vue';
import router from '../router';
import vuetify from '../plugins/vuetify';
import store from '../store';
import "vuetify/dist/vuetify.min.css";


document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})


router.beforeEach(( to, from, next ) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
      if (!store.state.isLoggedIn) {
          next({
              path: '/',
              query: {
                  redirect: to.fullPath
              }
          })
      } else {
          next();
      }
  } else {
      next();
  }
});