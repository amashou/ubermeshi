<template>
    <v-container>
        <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in posts" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                    <v-card-title>{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3 post-title">店名-{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="pt-0 post-title">住所-{{post.restaurant_address}}</v-card-subtitle>
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

export default {
    components: { Popup },
    data(){
        return{
            item: 1,
            posts: [],
            dialog: false,
        }
    },
    created(){
        axios.get('/api/v1/posts')
        .then( res => {
            console.log(res);
            let responsePostInfo = res.data.posts;
            const MAX_TITLE_LEN = 20;
            const MAX_ADDRESS_LEN = 35;
            const MAX_RESTNAME_LEN = 35;
            const MAX_DESCRIPTION_LEN = 60;
            let ommitedString = this.ommitedString;
            responsePostInfo.forEach(function(post, index) {
                responsePostInfo[index].title = ommitedString(post.title, MAX_TITLE_LEN, 0);
                responsePostInfo[index].restaurant_address = ommitedString(post.restaurant_address, MAX_ADDRESS_LEN, 0);
                responsePostInfo[index].restaurant_name = ommitedString(post.restaurant_name, MAX_RESTNAME_LEN, 0);
                responsePostInfo[index].description = ommitedString(post.description, MAX_DESCRIPTION_LEN, 0);
            });
            this.posts = responsePostInfo;
            if(res.data.user !== null) {
                this.$store.dispatch("current_user", res.data.user);
                this.$store.dispatch("isLoggedIn", true);
            }
        })
        .catch((errors) => {
            console.log(errors);
        });
    },
    methods: {
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
.post-description {
    height: 110px;
}
.post-title{
    height: 60px;
}
</style>
