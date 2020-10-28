<template>
  <v-app>

    <v-navigation-drawer max-width="300" v-model="drawer" color="grey lighten-2" temporary app>
      <v-layout column align-center>
        <v-flex class="mt-5">
          <v-avatar size="100">
            <img src="#">
          </v-avatar>
          <p class="subheading mt-1 grey--text">Username</p>
        </v-flex>
        <v-flex class="mt-4 mb-3">
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
        <v-list v-if="isAuthenticated">
          <v-list-item v-for="link in links" :key="link.text" route :to="link.route">
            <v-list-item-icon>
              <v-icon>{{ link.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ link.text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <v-list>
           <v-list-item v-if="isAuthenticated" @click="logout">
            <v-list-item-icon><v-icon>mdi-logout</v-icon></v-list-item-icon>
            <v-list-item-content><v-list-item-title>ログアウト</v-list-item-title></v-list-item-content>
           </v-list-item>
           <v-list-item v-else route :to="{ name: 'Login'}">
            <v-list-item-icon><v-icon>mdi-login</v-icon></v-list-item-icon>
            <v-list-item-content><v-list-item-title>ログイン</v-list-item-title></v-list-item-content>
          </v-list-item>
        </v-list>
    </v-navigation-drawer>

    <v-app-bar color="secondary" dark app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title class="primary--text text--uppercase pa-0">
        <router-link :to="{ path: '/' }"><span class="app-title">UberMeshi</span></router-link>
      </v-toolbar-title>
    </v-app-bar>
    <v-main>
        <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
import Popup from './components/PostPopup';

export default {
  components: { Popup },
  data: function () {
    return {
      drawer: null,
      links: [
        { icon: 'mdi-notebook-edit', text: "新規投稿", route: '/posts/new'},
        { icon: 'mdi-heart', text: "フォロー", route: '/'},
        { icon: 'mdi-heart', text: "フォローワー", route: '/'},
        { icon: 'mdi-heart', text: "いいね", route: '/'},
        { icon: 'mdi-heart', text: "通知", route: '/'},
      ]
    }
  },
  computed: {
      isAuthenticated() {
          return (localStorage.getItem("access-token") !== null && localStorage.getItem("access-token") !== '');
      }
  },
  created() {
    console.log(localStorage.getItem("access-token") !== null);
    console.log(localStorage.getItem("access-token") !== '')
    console.log(localStorage.getItem("access-token") !== null && localStorage.getItem("access-token") !== '');
  },
  methods: {
    logout(){
      console.log('logout');
      localStorage.setItem("access-token", '');
      localStorage.setItem("uid", '');
      localStorage.setItem("client", '');
      localStorage.setItem("expiry", '');
      localStorage.setItem("token-type", '');
    }
  }
}
</script>

<style scoped>
a{
  text-decoration: none;
}
.v-application {
  font-family: 'PT Serif', serif;
}
.v-main {
  background-color: 
  #A5D6A7;
}
.app-title{
  font-family: 'PT Sans', sans-serif;
  font-size: 30px
}
</style>