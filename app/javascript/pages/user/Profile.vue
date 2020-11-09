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
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    }
}
</script>
<style scoped>
.updateBtn{
    bottom: 20px;
}
</style>