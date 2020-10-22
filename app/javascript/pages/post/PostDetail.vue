<template>
    <v-main>
        <v-container>
            <v-card-title>詳細ページ</v-card-title>
            <v-row>
                <v-col cols="4" v-for="n in 3" :key="n">
                    <v-card>
                        <v-img height="200px" tile></v-img>
                    </v-card>
                </v-col>
            </v-row>
            <v-row>
                <v-col cols="4">
                     <v-img height="200" label="サムネイル" rounded><p>サムネイルが入る</p></v-img>
                </v-col>
                <v-col cols="8">
                    <v-card-title>{{post.restaurant_name}}</v-card-title>
                    <v-card-subtitle>{{post.title}}</v-card-subtitle>
                    <v-card-text>{{post.description}}</v-card-text>
                    <v-card-text>いいね数：{{post.favorited_user}}</v-card-text>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <v-card-actions>
                    <v-spacer></v-spacer>
                        <v-btn class="ma-2" text icon color="blue lighten-2"><v-icon>mdi-thumb-up</v-icon></v-btn>
                        <v-btn class="ma-2" text icon color="red lighten-2"><v-icon>mdi-thumb-down</v-icon></v-btn>
                        <v-btn><v-icon text color="blue darken-2">mdi-message-text</v-icon></v-btn>
                    </v-card-actions>
                </v-col>
            </v-row>
            <v-row>
          <v-col
            v-for="card in cards"
            :key="card"
            cols="12"
          >
            <v-card>
              <v-subheader>{{ card }}</v-subheader>

              <v-list two-line>
                <template v-for="n in 6">
                  <v-list-item

                    :key="n"
                  >
                    <v-list-item-avatar color="grey darken-1">
                    </v-list-item-avatar>

                    <v-list-item-content>
                      <v-list-item-title>Message {{ n }}</v-list-item-title>

                      <v-list-item-subtitle>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil repellendus distinctio similique
                      </v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>

                  <v-divider
                    v-if="n !== 6"
                    :key="`divider-${n}`"
                    inset
                  ></v-divider>
                </template>
              </v-list>
            </v-card>
          </v-col>
            </v-row>
        </v-container>
    </v-main>
    <!-- <div>
        <h2>投稿詳細ページ</h2>
        <ul>
            <li>タイトル{{post.title}}</li>
            <li>ウバポイント：{{post.description}}</li>
            <li>利用回数{{post.times}}</li>
            <li>お店の名前：{{post.restaurant_name}}</li>
            <li>住所：{{restaurant.address}}</li>
        </ul>
        <h3>ユーザー情報</h3>
        <ul>
            <li>ユーザー：{{user.name}}</li>
            <li>ステータス：{{user.status}}</li>
            <li>ユーザーID{{user.id}}</li>
            <li>ログインユーザーID：{{current_user.id}}</li>
        </ul>
        <v-btn @click="like">いいね</v-btn>
        <v-btn @click="unlike">いいね削除</v-btn>
    </div> -->
</template>

<script>
import axios from '../../axios-auth';

export default {
    data(){
        return{
        cards: ['Today', 'Yesterday'],
          post: {},
          restaurant: {},
          user: {},
          favorited_user:{},
          current_user:{}
        }
    },
    created(){
        axios.get('/posts/'+ this.$route.params.id)
            .then((response) => {
                console.log('this is detail view without token request');
                console.log(response);
                this.post = response.data.post;
                this.restaurant = response.data.restaurant;
                this.user = response.data.user;
                this.favorited_users = response.data.favorited_users;
                this.current_user = response.data.current_user;
            })
            .catch((errors) => {
                console.log(errors);
            });
    },
    methods: {
        like(){
            axios.post('/posts/' + this.post.id + '/favorites',)
                .then((response) => {
                    console.log(response);
                    this.favorited_user = response.data
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
        unlike(){
            axios.delete('/posts/' + this.post.id + '/favorites', { params: this.post.id })
                .then((response) => {
                    console.log(response);
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
    }
};
</script>