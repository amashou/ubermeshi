<template>
    <v-container>
        <h2>UserComments</h2>
        <p>{{comments}}</p>
        <p>{{replys}}</p>
    </v-container>
</template>

<script>
import axios from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return {
            comments: {},
            replys: {}
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/comments')
        .then( res => {
            console.log(res);
            this.comments = res.data.comments;
            this.replys = res.data.replys;
        })
        .catch( error => {
            console.log(error);
        });
    }
}
</script>