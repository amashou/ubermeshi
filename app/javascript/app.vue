<template>
  <v-app>
    <v-navigation-drawer max-width="300" v-model="drawer" color="grey lighten-2" temporary app>
      <v-layout column align-center>
        <v-flex class="mt-5">
          <v-avatar size="100" v-if="current_user.thumbnail">
            <img :src="current_user.thumbnail.url">
          </v-avatar>
          <v-avatar size="100" v-else color="grey">
          </v-avatar>
          <p class="subheading mt-1 grey--text text-center">{{current_user.name}}</p>
        </v-flex>
        <v-flex class="mt-4 mb-3">
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
        <v-list v-if="isLoggedIn">
          <v-list-item v-for="link in links" :key="link.text" route :to="{ name: 'ProfileRoot'}">
            <v-list-item-icon>
              <v-icon>{{ link.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ link.text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <v-list>
           <v-list-item v-if="isLoggedIn" @click="logout">
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
import axios from './axios-auth';
import { mapGetters } from 'vuex';

export default {
  components: { Popup },
  data() {
    return {
      isAuthenticated: false,
      drawer: null,
      links: [
        { icon: 'mdi-account-circle', text: "プロフィール", route: '/profile'}
      ]
    }
  },
  computed:{
    ...mapGetters(["isLoggedIn", "current_user"])
  },
    created(){
        axios.get('/api/v1/posts')
        .then( response => {
            console.log(response);
            let postsInfo = response.data.posts;
            const MAX_TITLE_LEN = 20;
            const MAX_ADDRESS_LEN = 30;
            const MAX_RESTNAME_LEN = 30;
            const MAX_DESCRIPTION_LEN = 60;
            let ommitedString = this.ommitedString;
            postsInfo.forEach(function(post, index) {
                postsInfo[index].title = ommitedString(post.title, MAX_TITLE_LEN, 0);
                postsInfo[index].restaurant_address = ommitedString(post.restaurant_address, MAX_ADDRESS_LEN, 0);
                postsInfo[index].restaurant_name = ommitedString(post.restaurant_name, MAX_RESTNAME_LEN, 0);
                postsInfo[index].description = ommitedString(post.description, MAX_DESCRIPTION_LEN, 0);
            });
            if(response.data.user) {
                this.$store.dispatch("current_user", response.data.user);
                this.$store.dispatch("isLoggedIn", true);
            }
            this.$store.dispatch("postsInfo", postsInfo);
        })
        .catch( error => {
            console.log(error);
        });
    },
  methods: {
    logout(){
      localStorage.setItem("access-token", '');
      localStorage.setItem("uid", '');
      localStorage.setItem("client", '');
      localStorage.setItem("expiry", '');
      localStorage.setItem("token-type", '');
      localStorage.setItem("id", '');
      this.$store.dispatch("current_user", {});
      this.$store.dispatch("isLoggedIn", false);
      this.$router.push({path: '/'});
      window.location.reload();
    },
    ommitedString(string='', maxInt, startInt=0) {
      let stringLength = string === undefined ? 0 : string.length;
      if(stringLength > maxInt) {
          return string.substr(startInt, maxInt) + "...";
      }
      return string;
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