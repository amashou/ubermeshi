<template>
    <v-container>
        <v-sheet max-width="600px" class="mx-auto my-12" color="secondary">
            <v-list color="pink" class="white-text">
                <v-list-item>
                    <v-list-item-avatar color="grey" size="62"><v-img v-if="current_user.thumbnail" :src="current_user.thumbnail.url"></v-img></v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title class="white--text">{{current_user.name}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
            <v-card tile>
                <v-list dense class="pa-2">
                    <v-list-item-title>フォロー</v-list-item-title>
                    <p v-if="!followings.length">まだフォローしていません</p>
                    <v-list-item v-for="(following, index) in followings" :key="index" class="list-item py-1">
                        <v-list-item-avatar color="grey" size="32"><v-img v-if="following.thumbnail" :src="following.thumbnail.url"></v-img></v-list-item-avatar>
                        <v-list-item-content>
                            <v-list-item-title>{{following.name}}<span>{{following.status}}</span></v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                    <v-divider class="my-2"></v-divider>
                    <v-list-item-title>フォローワー</v-list-item-title>
                    <p v-if="!followers.length">まだフォローされていません</p>
                    <v-list-item v-for="(follower, index) in followers" :key="index" class="list-item py-1">
                        <v-list-item-avatar color="grey" size="32"><v-img v-if="follower.thumbnail" :src="follower.thumbnail.url"></v-img></v-list-item-avatar>
                        <v-list-item-content>
                            <v-list-item-title>{{follower.name}}<span>{{follower.status}}</span></v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </v-list>
            </v-card>
        </v-sheet>

    </v-container>
</template>

<script>
import axios from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return {
            followings: {},
            followers: {}
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/follows')
        .then( res => {
            this.followers = res.data.followers;
            this.followings = res.data.followings;
        })
        .catch( error => {
            console.log(error);
        });
    }
}
</script>