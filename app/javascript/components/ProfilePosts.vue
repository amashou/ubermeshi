<template>
    <v-container>
        <p v-if="!posts.length">まだ投稿はありません</p>
         <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in posts" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                     <v-card-title class="post-title pt-3">{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3 restaurant-name">店名-{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="py-0 restaurant_address">住所-{{post.restaurant_address}}</v-card-subtitle>
                    <v-divider></v-divider>
                    <v-card-text class="post-description">{{post.description}}</v-card-text>
                    <v-chip color="accent" right class="ma-3" outlined route :to="{ name: 'PostDetail', params: {id: post.id} }">もっと見る</v-chip>
                    <v-btn outlined fab @click="destroy(post)" small color="pink"><v-icon>mdi-trash-can-outline</v-icon></v-btn>
                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import axios from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return {
            posts: {}
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/posts')
        .then( res => {
            this.posts = res.data.posts;
        })
        .catch( error => {
            console.log(error);
        });
    },
    methods:{
        destroy(post){
            axios.delete('/api/v1/posts/' + post.id)
                .then( res => {
                    this.posts = res.data.posts;
                })
                .catch( error => {
                    console.log(error);
                });
        }
    }
}
</script>

<style scoped>
.post-title{
    height: 90px;
}
.restaurant-name{
    height: 60px;
}
.restaurant_address {
    height: 50px;
}
.post-description{
    height: 130px;
}
</style>