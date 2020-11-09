<template>
    <v-container>
        <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in postsInfo" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                    <v-card-title class="post-title pt-3">{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3 restaurant-name">店名-{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="py-0 restaurant_address">住所-{{post.restaurant_address}}</v-card-subtitle>
                    <v-divider></v-divider>
                    <v-card-text class="post-description">{{post.description}}</v-card-text>
                    <v-btn color="accent" dark outlined class="ml-3 mb-3" route :to="{ name: 'PostDetail', params: {id: post.id} }">もっと見る</v-btn>
                </v-card>
                <Popup />
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import axios from '../axios-auth.js';
import Popup from '../components/PostPopup';
import { mapGetters } from 'vuex';

export default {
    components: { Popup },
    data(){
        return{
            item: 1,
            dialog: false,
        }
    },
    computed:{
        ...mapGetters(['postsInfo'])
    }
}
</script>

<style scoped>
.post-description {
    height: 110px;
}
.post-title{
    height: 90px;
}
.restaurant-name{
    height: 60px;
}
.restaurant_address {
    height: 50px;
}
</style>
