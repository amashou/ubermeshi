<template>
        <v-container class="pb-12">
            <v-list color="primary">
                <v-list-item>
                    <v-list-item-avatar color="grey"></v-list-item-avatar>
                    <v-list-content>
                        <v-list-item-title>ユーザーネーム{{user.name}}</v-list-item-title>
                        <v-list-item-subtitle>ユーザーステータス{{user.status}}</v-list-item-subtitle>
                    </v-list-content>
                </v-list-item>
            </v-list>
            <v-row class="mb-10">
                <v-flex md6 xs12>
                    <v-img></v-img>
                </v-flex>
                <v-flex md6 xs11 class="mx-auto pr-5">
                    <v-card height="400px" class="pa-5">
                        <v-card-title>タイトル{{ post.title }}</v-card-title>
                        <v-card-text>description{{ post.description }}</v-card-text>
                        <v-btn class="ma-2 like-btn" dark color="secondary" @click="favorite" absolute bottom><v-icon>mdi-thumb-up</v-icon>いいね:</v-btn>
                    </v-card>
                </v-flex>
            </v-row>
            <v-row>
                <v-flex md6 xs11 class="mx-auto">
                    <v-card class="px-10">
                        <v-card-title>コメント</v-card-title>
                    <v-list>
                        <template v-for="n in 6">
                            <v-list-item :key="n">
                                <v-list-item-avatar color="grey darken-1"></v-list-item-avatar>
                                <v-list-item-content>
                                    <v-list-item-title>Message {{ n }}</v-list-item-title>
                                    <v-list-item-subtitle>メッセージ一覧</v-list-item-subtitle>
                                </v-list-item-content>
                            </v-list-item>
                            <v-divider v-if="n !== 6" :key="`divider-${n}`" inset></v-divider>
                        </template>
                    </v-list>
                    </v-card>
                </v-flex>
                <v-flex>
                    <v-card class="px-5" color="primary" outlined>
                        <v-card-title class="text-center">お店情報</v-card-title>
                        <v-card-text>名前：</v-card-text>
                        <v-card-text>住所：</v-card-text>
                        <v-card-text>営業時間：</v-card-text>
                        <v-card-text>電話番号：</v-card-text>
                        <v-card-actions><v-chips>詳しくはこちら</v-chips></v-card-actions>
                    </v-card>
                </v-flex>
            </v-row>
            
            <!-- <v-form @submit.prevent="comment">
                <v-text-field label="コメント" v-model="formComment"></v-text-field>
                <v-btn type="submit">コメントする</v-btn>
            </v-form> -->
        </v-container>
</template>

<script>
import axios from '../../axios-auth';

export default {
    data(){
        return{
        cards: ['Today'],
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
<style scoped>
.like-btn {
    right: 30px;
}
</style>