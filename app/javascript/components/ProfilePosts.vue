<template>
    <v-container>
        <h2>UserPosts</h2>
        <p>{{posts}}</p>
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
            console.log(res);
            this.posts = res.data.posts;
        })
        .catch( error => {
            console.log(error);
        });
    }
}
</script>