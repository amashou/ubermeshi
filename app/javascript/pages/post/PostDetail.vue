<template>
        <v-container class="pb-12">
            <v-row class="mb-10" height="200px">
                <v-flex md6 xs11 class="mx-auto">
                     <v-list color="primary" class="mt-4">
                        <v-list-item route :to="{ name: 'UserDetail', params: user.id }">
                            <v-list-item-avatar color="grey"></v-list-item-avatar>
                            <v-list-item-content>
                                <v-list-item-title>{{user.name}}</v-list-item-title>
                                <v-list-item-subtitle>{{user.status}}</v-list-item-subtitle>
                            </v-list-item-content>
                        </v-list-item>
                    </v-list>
                    <v-card min-height="200px" class="pb-5" color="primary" outlined>
                        <v-card-title>タイトル{{ post.title }}</v-card-title>
                        <v-card-text>description{{ post.description }}</v-card-text>
                            <v-btn class="ma-2 like-btn" color="secondary" outlined absolute bottom right @click="favorite">
                            <v-icon left>mdi-thumb-up</v-icon>いいね:{{favorites_count}}</v-btn>
                    </v-card>
                </v-flex>
                <v-flex md6 xs11 class="mx-auto mb-3 pt-5" v-if="post.food_picture.url">
                    <v-img :src="post.food_picture.url" aspect-ratio="1.7" min-height="250px" contain max-height="300px"></v-img>
                </v-flex>
            </v-row>
            <v-row>
                <v-flex class="mb-5 mx-auto" md6 xs11>
                    <v-card class="" color="primary" outlined height="300px">
                        <v-card-title class="text-center">お店情報</v-card-title>
                        <v-card-text>名前：{{restaurant.name}}</v-card-text>
                        <v-card-text>住所：{{restaurant.address}}</v-card-text>
                        <v-card-text>営業時間：{{restaurant.opentime}}</v-card-text>
                        <v-card-text>電話番号：{{restaurant.tel}}</v-card-text>
                        <v-card-actions v-if="restaurant.url !== null"><v-btn link :href="restaurant.url" color="secondary" outlined dark absolute right>詳しくはこちら</v-btn></v-card-actions>
                    </v-card>
                </v-flex>
                <v-flex md6 xs11 class="mx-auto">
                    <v-card class="px-10" color="primary" outlined>
                        <v-card-title>コメント</v-card-title>
                        <CommentDialog @reflectComment="comments.unshift($event)"></CommentDialog>
                    <v-list color="grey lighten-2">
                        <v-list-item-group>
                        <template v-for="(comment,index) in comments">
                            <v-list-item :key="index">
                                <v-list-item-content>
                                    <v-list-item-title>{{comment.content}}</v-list-item-title>
                                </v-list-item-content>
                            </v-list-item>
                            <v-divider v-if="index < comments.length -1" :key="index"></v-divider>
                        </template>
                        </v-list-item-group>
                    </v-list>
                    </v-card>
                </v-flex>
            </v-row>
        </v-container>
</template>

<script>
import axios from '../../axios-auth';
import CommentDialog from '../../components/Comment';

export default {
    components: { CommentDialog },
    data(){
        return{
            toggleBtn: '',
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
        axios.get('/api/v1/posts/'+ this.$route.params.id)
        // axios.get('/api/v1/posts/')
            .then(res => {
                console.log('res data is ...',res);
                this.post = res.data.post;
                this.restaurant = res.data.restaurant;
                this.user = res.data.user;
                this.favorites_count = res.data.favorites_count;
                this.current_user = res.data.current_user;
                this.comments = res.data.comments;
            })
            .catch(erro => {
                console.log(erro);
            });
    },
    methods: {
        favorite(){
            axios.post('/api/v1/posts/' + this.post.id + '/favorites',)
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
            axios.delete('/api/v1/posts/' + this.post.id + '/favorites')
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
        }
    }
};
</script>
<style scoped>
/* .like-btn {
    right: 30px;
} */
/* .favorited {
    background-color: black;
    color: black;
} */
</style>