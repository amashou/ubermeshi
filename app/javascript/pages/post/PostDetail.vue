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
                    <v-card-text>いいね数：{{favorites_count}}</v-card-text>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <v-card-actions>
                    <v-spacer></v-spacer>
                        <v-btn class="ma-2" text icon color="blue lighten-2" @click="favorite"><v-icon>mdi-thumb-up</v-icon></v-btn>
                        <v-btn class="ma-2" text icon color="red lighten-2" @click="unfavorite"><v-icon>mdi-thumb-down</v-icon></v-btn>
                        <v-btn><v-icon text color="blue darken-2">mdi-message-text</v-icon></v-btn>
                        <p v-if="errors">{{errors}}</p>
                    </v-card-actions>
                </v-col>
            </v-row>
            <!-- <v-row>
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
            </v-row> -->
            <v-form @submit.prevent="comment">
                <v-text-field label="コメント" v-model="formComment"></v-text-field>
                <v-btn type="submit">コメントする</v-btn>
            </v-form>
            <ul v-if="comments">
                <li v-for="(comment, index) in comments" :key="index">コメント：{{comment.comment}}</li>
            </ul>
        </v-container>
    </v-main>
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
          favorites_count:'',
          current_user:{},
          comments: [],
          formComment: "",
          errors: ""
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
                this.favorites_count = response.data.favorites_count;
                this.current_user = response.data.current_user;
                this.comments = response.data.comments;
            })
            .catch((errors) => {
                console.log(errors);
            });
    },
    methods: {
        favorite(){
            axios.post('/posts/' + this.post.id + '/favorites',)
                .then((response) => {
                    console.log(response);
                    if(response.data.favorites_count){
                        this.favorites_count = response.data.favorites_count;
                    } else {
                        this.errors = response.data.message;
                    }
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
        unfavorite(){
            axios.delete('/posts/' + this.post.id + '/favorites')
                .then((response) => {
                    console.log(response.data.favorites_count);
                    if(response.data.favorites_count){
                        this.favorites_count = response.data.favorites_count;
                    } else {
                        this.errors = response.data.message;
                    }
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
        comment() {
            const formData = new FormData();
            formData.append('comment', this.formComment);
            console.log(formData);
            axios.post('/posts/' + this.post.id + '/comments', formData)
                .then((response) => {
                    console.log(response);
                    this.comments = response.data.comments;
                })
                .catch((error) => {
                    console.log(error);
                })
        }
    }
};
</script>