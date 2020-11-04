<template>
    <v-container>
        <v-chip color="pink" outlined route :to="{ path: '/profile/posts'}">投稿一覧</v-chip>
        <v-chip color="pink" outlined route :to="{ path: '/profile/comments'}">コメント・返信一覧</v-chip>
        <v-chip color="pink" outlined route :to="{ path: '/profile/follows'}">フォロー一覧</v-chip>
        <v-chip color="pink" outlined route :to="{ name: 'ProfileRoot'}">プロフィール</v-chip>
        <v-btn color="secondary" route :to="{ path: '/'}" absolute right>TOPへ戻る</v-btn>
        <!-- <v-sheet max-width="600px" class="mx-auto my-12" color="secondary">
            <v-list color="pink" class="white-text">
                <v-list-item>
                    <v-list-item-avatar color="grey" size="62"><v-img v-if="userInfo.thumbnail" :src="userInfo.thumbnail.url"></v-img></v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title class="white--text">{{userInfo.name}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
            <v-card tile class="pa-3">
                <v-sheet>
                    <v-avatar v-if="uploadedThumbnail" size="62">
                        <v-img :src="uploadedThumbnail"></v-img>
                    </v-avatar>
                </v-sheet>
                    <v-file-input @change="onFileChange" prepend-icon="mdi-camera" label="アイコン" chips></v-file-input>
                    <v-text-field v-model="userInfo.name" label="名前" outlined clearable></v-text-field>
                    <v-text-field v-model="userInfo.profile_comment" label="自己紹介" outlined clearable></v-text-field>
                    <v-text-field v-model="userInfo.address" label="場所" outlined clearable></v-text-field>
                    <v-select :items="items" label="ステータス" v-model="userInfo.status" outlined></v-select>
                    <v-text-field v-model="userInfo.ubered_count" label="利用回数" :rules="numberRules" outlined></v-text-field>
                    <v-card-text>最終更新：{{userInfo.updated_at}}</v-card-text>
                    <v-card-actions>
                        <v-btn absolute right color="secondary" rounded class="updateBtn" @click="update"><v-icon left>mdi-lead-pencil</v-icon>更新</v-btn>
                    </v-card-actions>
            </v-card>
            <v-col class="d-flex flex-row-reverse">
                <v-btn route :to="{ path: '/' }" color="pink" dark rounded class="btn">Topへ</v-btn>
            </v-col>
        </v-sheet> -->
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
            console.log(res);
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