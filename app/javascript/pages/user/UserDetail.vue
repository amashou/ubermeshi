<template>
    <div>
        <h2>ユーザー詳細ページ</h2>
        <ul>
            <li>{{userInfo.id}}</li>
            <li>{{userInfo.name}}</li>
            <li>{{userInfo.email}}</li>
            <li>{{userInfo.uberd_count}}</li>
            <v-btn @click="follow">フォロー</v-btn>
            <v-btn @click="unfollow">フォローを外す</v-btn>
            <li>フォロー：{{followings_count}}</li>
            <li>フォローワー：{{followers_count}}</li>
        </ul>
        <router-link :to="{ name: 'UserEdit', params: { id: userInfo.id }}">編集ページへ</router-link>
    </div>
</template>

<script>
import axios from '../../axios-auth';

export default {
    data(){
        return{
            userInfo: {},   
            followers_count: '',
            followings_count: ''
        }
    },
    created(){
        axios.get('/users/'+ this.$route.params.id)
        .then((response) => {
            console.log(response);
            this.userInfo = response.data.user
            this.followings_count = response.data.followings_count
            this.followers_count = response.data.followers_count
        })
        .catch((errors) => {
            console.log(errors);
        });
    },
    methods: {
        follow(){
            axios.post('/users/' + this.userInfo.id + '/relationships')
                .then((response) => {
                    console.log(response);
                    if(response.data.message == "followed") {
                        this.followers_count = response.data.followers_count
                        this.followings_count = response.data.followings_count
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        unfollow(){
            axios.delete('/users/' + this.userInfo.id + '/relationships')
                .then((response) => {
                    if(response.data.message == "unfollowed") {
                        this.followers_count = response.data.followers_count
                        this.followings_count = response.data.followings_count
                    }
                    console.log(response);
                })
                .catch((error) => {
                    console.log(error);
                });
        }
    }
}
</script>