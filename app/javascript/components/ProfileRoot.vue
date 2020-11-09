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
            <v-card tile class="pa-3">
                <template v-if="errors">
                    <v-alert v-for="error in errors" :key="error" type="error" outlined>{{error}}</v-alert>
                </template>
                <v-sheet>
                    <v-avatar v-if="uploadedThumbnail" size="62">
                        <v-img :src="uploadedThumbnail"></v-img>
                    </v-avatar>
                </v-sheet>
                    <v-file-input @change="onFileChange" prepend-icon="mdi-camera" label="アイコン" chips></v-file-input>
                    <v-text-field v-bind:value="current_user.name" @input="postInfo.name = $event" label="名前" outlined clearable></v-text-field>
                    {{current_user.name}}
                    {{postInfo.name}}
                    <v-text-field v-bind:value="current_user.profile_comment" @input="postInfo.profile_comment = $event" label="自己紹介" outlined clearable></v-text-field>
                    <v-text-field v-bind:value="current_user.address" @input="postInfo.address = $event" label="場所" outlined clearable></v-text-field>
                    <v-select :items="items" label="ステータス" v-bind:value="current_user.status" @input="postInfo.status = $event" outlined></v-select>
                    <v-text-field v-bind:value="current_user.ubered_count" @input="postInfo.ubered_count = $event" label="利用回数" :rules="numberRules" outlined></v-text-field>
                    <v-card-text>最終更新：{{current_user.updated_at}}</v-card-text>
                    <v-card-actions class="mb-5">
                        <v-btn absolute right color="secondary" rounded class="updateBtn" @click="update"><v-icon left>mdi-lead-pencil</v-icon>更新</v-btn>
                    </v-card-actions>
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
            errors: {},
            postInfo:{ name: '' },
            uploadedThumbnail: '',
            items: ['ヘビーユーザー', 'ヘビードライバー', 'プライマリー（100回未満程度）'],
            numberRules:[
                v => {
                    const num = /^[0-9]+$/;
                    return num.test(v) || "半角数字で入力してください";
                }
            ]
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    methods: {
        curre(e){
            console.log(e);
        },
        onFileChange(e){
            let selectFile = e;
            let reader = new FileReader();
            reader.onload = e => {
                this.uploadedThumbnail = e.target.result;
            }
            reader.readAsDataURL(selectFile);
            this.postInfo.thumbnail = selectFile;
        },
        update(){
            let formData = new FormData();
            formData.append("user[name]", this.postInfo.name || this.current_user.name);
            formData.append("user[ubered_count]", this.postInfo.ubered_count || this.current_user.ubered_count);
            formData.append("user[profile_comment]", this.postInfo.profile_comment || this.current_user.profile_comment);
            formData.append("user[status]", this.postInfo.status || this.current_user.status);
            formData.append("user[address]", this.postInfo.address || this.current_user.address);
            if (this.uploadedThumbnail){
                formData.append("user[thumbnail]", this.postInfo.thumbnail);
            }
            axios.patch('/api/v1/users/' + this.current_user.id, formData)
                .then(res => {
                    if (res.data.errors){
                        this.errors = res.data.errors
                    } else {
                        console.log(res);
                        this.$store.dispatch("current_user", res.data.data);
                        // this.$router.push({ path: '/' });
                    }
                })
                .catch(erro => {
                    console.log(erro);
                });
        },
    }
}
</script>