<template>
    <v-container>
        <v-chip color="pink mb-2" outlined route :to="{ path: '/profile/posts'}">投稿一覧</v-chip>
        <v-chip color="pink mb-2" outlined route :to="{ path: '/profile/comments'}">コメント・返信一覧</v-chip>
        <v-chip color="pink mb-2" outlined route :to="{ path: '/profile/follows'}">フォロー一覧</v-chip>
        <v-chip color="pink mb-2" outlined route :to="{ path: '/profile/favorites'}">いいね一覧</v-chip>
        <v-chip color="pink mb-2" outlined route :to="{ name: 'ProfileRoot'}">プロフィール</v-chip>
        <router-view></router-view>
    </v-container>
</template>

<script>
import axios from '../../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return{
            userInfo: {},   
            followers_count: '',
            followings_count: '',
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id)
        .then(res => {
            this.userInfo = res.data.user;
            this.followings_count = res.data.followings_count;
            this.followers_count = res.data.followers_count;
        })
        .catch((errors) => {
            console.log(errors);
        });
    }
}
</script>
<style scoped>
.updateBtn{
    bottom: 20px;
}
</style>