<template>
    <v-container>
        <h2>UserFollows</h2>
        <p>{{followers}}</p>
        <p>{{followings}}</p>
    </v-container>
</template>

<script>
import axios from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return {
            followers: {},
            followings: {}
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/follows')
        .then( res => {
            console.log(res);
            this.followers = res.data.followers;
            this.followings = res.data.followings;
        })
        .catch( error => {
            console.log(error);
        });
    }
}
</script>