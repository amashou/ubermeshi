<template>
    <v-container>
        <v-layout row wrap class="px-2 grey--text">
            <v-flex v-for="(post,index) in postsInfo" :key="index" md4 sm6 xs11 mx-auto>
                <v-card class="mx-4 mb-4" color="#EEE" raised>
                    <v-img :src="post.food_picture.url" height="200px" cover></v-img>
                    <v-divider></v-divider>
                    <v-card-title>{{post.title}}</v-card-title>
                    <v-card-subtitle class="py-3">店名-{{post.restaurant_name}}</v-card-subtitle>
                    <v-card-subtitle class="pt-0">住所-{{post.restaurant_address}}</v-card-subtitle>
                    <v-divider></v-divider>
                    <v-card-text>{{post.description}}</v-card-text>
                    <v-chip color="accent" right class="ma-3" outlined route :to="{ name: 'PostDetail', params: {id: post.id} }">more info</v-chip>
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

</style>
