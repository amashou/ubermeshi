<template>
    <v-container>
        <v-layout row class="mb-3 px-4">
            <v-chip color="pink" link outlined　class="mr-2">新着順</v-chip>
            <v-chip color="pink" link outlined　class="mr-2">人気順</v-chip>
            <v-chip color="pink" link outlined　class="mr-2">ドライバー</v-chip>
            <v-chip color="pink" link outlined　class="mr-2">イーター</v-chip>
            <v-chip color="pink" link outlined　class="mr-2">新メニュー</v-chip>
        </v-layout>
        <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in posts" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                    <v-card-title>タイトル:{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3">店名ー{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="pt-0">住所-{{post.restaurant_address}}</v-card-subtitle>
                    <v-divider></v-divider>
                    <v-card-text>おすすめポイントおすすめポイントおすすめポイントおすすめポイントおすすめポイントおすすめポイント</v-card-text>
                    <v-chip color="accent" right class="ma-3" outlined route :to="{ name: 'PostDetail', params: {id: post.id} }">more info</v-chip>
                </v-card>
            </v-flex>
            <Popup />
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
        .then((response) => {
            let responsePostInfo = response.data
            const MAX_TITLE_LEN = 20;
            const MAX_ADDRESS_LEN = 30;
            const MAX_RESTNAME_LEN = 30;
            let ommitedString = this.ommitedString;
            responsePostInfo.forEach(function(post, index) {
                console.log(post.restaurant_address);
                responsePostInfo[index].title = ommitedString(post.title, MAX_TITLE_LEN, 0);
                responsePostInfo[index].restaurant_address = ommitedString(post.restaurant_address, MAX_ADDRESS_LEN, 0);
                responsePostInfo[index].restaurant_name = ommitedString(post.restaurant_name, MAX_RESTNAME_LEN, 0);
            });
            this.posts = responsePostInfo;
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

</style>
