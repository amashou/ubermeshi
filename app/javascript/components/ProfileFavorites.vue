<template>
    <v-container>
        <p v-if="!favorite_posts.length">まだいいねした投稿がありません</p>
         <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in favorite_posts" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                    <v-card-title class="post-title">{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3 restaurant-name">店名-{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="pt-0 restaurant-address">住所-{{post.restaurant_address}}</v-card-subtitle>
                    <v-divider></v-divider>
                    <v-card-text class="post-description">{{post.description}}</v-card-text>
                    <v-chip color="accent" right class="ma-3" outlined route :to="{ name: 'PostDetail', params: {id: post.id} }">もっとみる</v-chip>
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
            favorite_posts: {}
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/favorite_posts')
        .then( res => {
            this.favorite_posts = res.data.favorite_posts;
        })
        .catch( error => {
            console.log(error);
        });
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