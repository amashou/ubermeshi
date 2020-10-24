<template>
  <v-app>

    <v-navigation-drawer max-width="300" v-model="drawer" color="grey lighten-2" temporary app>
      <v-layout column align-center>
        <v-flex class="mt-5">
          <v-avatar size="100">
            <img src="#">
          </v-avatar>
          <p class="subheading mt-1 grey--text">Username</p>
          <p>フォロー：</p>
          <p>フォローワー：</p>
        </v-flex>
        <v-flex class="mt-4 mb-3">
          <Popup />
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
        <v-list>
          <v-list-item v-for="link in links" :key="link.text" route :to="link.route">
            <v-list-item-icon>
              <v-icon>{{ link.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ link.text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
    </v-navigation-drawer>

    <v-app-bar color="secondary" dark app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title class="primary--text text--uppercase pa-0">
        <router-link :to="{ path: '/' }"><span class="app-title">UberMeshi</span></router-link>
      </v-toolbar-title>
      <!-- <router-link :to="{ path: '/' }"><v-btn outlined fab>Topへ</v-btn></router-link> -->
      <!-- <router-link :to="{ path: '/posts/new' }" class="mx-2"><v-chip color="accent" class="pa-4"><v-icon left>mdi-text-box-plus-outline</v-icon><span>投稿する</span></v-chip></router-link> -->
      <!-- <router-link :to="{ path: '/login' }"><v-btn outlined><v-icon left>mdi-login</v-icon><span>ログイン</span></v-btn></router-link> -->
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
        { icon: 'mdi-logout-variant', text: "ログアウト", route: '/'},
        { icon: 'mdi-login-variant', text: "ログイン", route: '/login'},
        { icon: 'mdi-notebook-edit', text: "新規投稿", route: '/posts/new'},
        { icon: 'mdi-heart', text: "フォロー", route: '/'},
      ]
    }
  },
  computed: {
    loginStatus() {
      return this.$store.state.isLoggedIn
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