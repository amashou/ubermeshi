<template>
    <v-container>
        <v-sheet max-width="600px" class="mx-auto my-12" color="secondary">
        <v-card tile>
            <v-list color="pink" class="white-text">
                <v-list-item>
                    <v-list-item-avatar color="grey"><v-img v-if="userInfo.thumbnail" :src="userInfo.thumbnail.url"></v-img></v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title class="white--text">{{userInfo.name}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-btn absolute right color="secondary" rounded top><v-icon left>mdi-lead-pencil</v-icon>編集する</v-btn>
            </v-list>
            <v-divider></v-divider>
            <v-card-text>プロフィール：{{userInfo.profile_comment}}</v-card-text>
            <v-card-text>ステータス：{{userInfo.status}}</v-card-text>
            <v-card-text>利用回数：{{userInfo.ubered_count}}</v-card-text>
            <v-card-text>最終更新：{{userInfo.updated_at}}</v-card-text>
        </v-card>
        <v-col class="d-flex flex-row-reverse">
            <v-btn route :to="{ path: '/' }" color="pink" dark rounded class="btn">Topへ</v-btn>
        </v-col>
        </v-sheet>
    </v-container>
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
        axios.get('/api/v1/users/'+ this.$route.params.id)
        .then(res => {
            console.log(res);
            this.userInfo = res.data.user;
            this.followings_count = res.data.followings_count;
            this.followers_count = res.data.followers_count;
        })
        .catch((errors) => {
            console.log(errors);
        });
    },
    methods: {
    }
}
</script>