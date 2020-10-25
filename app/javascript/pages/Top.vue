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
                    <v-card-title>タイトルがはいる{{post.title}}</v-card-title>
                    <v-card-subtitle>お店の情報がはいる--{{post.name}}</v-card-subtitle>
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
            items:['一位の投稿',　'二位の投稿', '三位の投稿'],
            dialog: false,
        }
    },
    computed: {
        isLoggedIn() {
            return this.$store.state.isLoggedIn;
        }
    },
    created(){
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

<style scoped>

</style>