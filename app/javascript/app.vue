<template>
  <v-app id="inspire">
    <v-navigation-drawer max-width="300" v-model="drawer" color="grey lighten-3" temporary app>

    </v-navigation-drawer>
    <!-- <v-navigation-drawer
      absolute
      permanent
      right
      >
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title>ウーバーイーターランキング</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-navigation-drawer> -->

    <v-app-bar  color="primary" dark app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>
        <h3>ubameshi</h3>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <router-link :to="{ path: '/login' }" v-if="!loginStatus"><v-btn outlined>ログイン</v-btn></router-link>
      <router-link :to="{ path: '/signup' }"><v-btn outlined>新規登録</v-btn></router-link>
      <router-link :to="{ path: '/' }"><v-btn outlined>Topへ</v-btn></router-link>
      <router-link :to="{ path: '/posts/new' }"><v-btn outlined>新規投稿</v-btn></router-link>
    </v-app-bar>

    <v-main>
        <router-view></router-view>
    </v-main>

  </v-app>
</template>

<script>
export default {
  data: function () {
    return {
      drawer: null,
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
</style>
