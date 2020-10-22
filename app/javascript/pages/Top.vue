<template>
    <v-container>
        <v-row>
          <v-col cols="10">
            <v-sheet>
                <h3>新着投稿しました<small>~new posts~</small></h3>
                <p>ログイン状態：{{ isLoggedIn }}</p>
                <v-row>
                    <v-col v-for="(post,index) in posts" :key="index" cols="4">
                        <v-card class="mx-4 mb-4">
                            <router-link :to="{ name: 'PostDetail', params: { id: post.id }}">
                            <v-img height="200px"></v-img>
                            <v-divider></v-divider>
                            <v-card-title>{{post.title}}</v-card-title>
                            <v-card-subtitle>{{post.restaurant_name}}</v-card-subtitle>
                            <v-divider></v-divider>
                            <v-card-text>{{post.description}}</v-card-text>
                            <v-card-actions>
                                <v-btn><v-icon>mdi-heart</v-icon></v-btn>
                            </v-card-actions>
                            </router-link>
                        </v-card>
                    </v-col>
                </v-row>
            </v-sheet>
          </v-col>
          <v-col cols="2">
            <v-sheet rounded="lg">
              <v-card>
                  <v-list>
                      <v-subheader>イーターランキング</v-subheader>
                      <v-list-item-group v-model="item" color="primary">
                        <v-list-item v-for="(item, index) in items" :key="index">
                            <v-list-item-content>
                                <v-list-item-title>No.{{index}}: {{item}}</v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                      </v-list-item-group>
                  </v-list>
              </v-card>
            </v-sheet>
              <v-card class="my-5">
                  <v-list>
                      <v-subheader>ドライバーランキング</v-subheader>
                      <v-list-item-group v-model="item" color="primary">
                        <v-list-item v-for="(item, index) in items" :key="index">
                            <v-list-item-content>
                                <v-list-item-title>No.{{index}}: {{item}}</v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                      </v-list-item-group>
                  </v-list>
              </v-card>
          </v-col>
        </v-row>
    </v-container>
</template>

<script>
import axios from '../axios-auth.js';

export default {
    data(){
        return{
            item: 1,
            posts: [],
            items:['一位の投稿',　'二位の投稿', '三位の投稿']
        }
    },
    computed: {
        isLoggedIn() {
            return this.$store.state.isLoggedIn;
        }
    },
    created(){
        console.log(process.env.RESTAURANT_URL);
        // axios.interceptors.request.eject(0);
        axios.get('posts')
        .then((response) => {
            console.log('This is top view without access-token');
            console.log(response);
            this.posts = response.data
        })
        .catch((errors) => {
            console.log(errors);
        });
    }
}
</script>