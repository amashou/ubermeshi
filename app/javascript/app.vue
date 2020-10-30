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
          <v-list-item v-for="link in links" :key="link.text" route :to="{ name: 'Profile'}">
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
  data() {
    return {
      isAuthenticated: false,
      drawer: null,
      links: [
        { icon: 'mdi-account-circle', text: "プロフィール", route: '/profile'},
        { icon: 'mdi-heart', text: "通知", route: '/'},
      ]
    }
  },
  watch: {
    $route(to, from){
      if(from.name == 'Login' && localStorage.getItem("access-token") !== null && localStorage.getItem("access-token") !== ''){
        this.isAuthenticated = true;
      }
    }
  },
  created() {
    if(localStorage.getItem("access-token") !== null && localStorage.getItem("access-token") !== ''){
      this.isAuthenticated = true;
    }
  },
  methods: {
    logout(){
      localStorage.setItem("access-token", '');
      localStorage.setItem("uid", '');
      localStorage.setItem("client", '');
      localStorage.setItem("expiry", '');
      localStorage.setItem("token-type", '');
      window.location.reload();
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