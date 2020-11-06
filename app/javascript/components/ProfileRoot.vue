<template>
    <v-container>
            <v-sheet max-width="600px" class="mx-auto my-12" color="secondary">
            <v-list color="pink" class="white-text">
                <v-list-item>
                    <v-list-item-avatar color="grey" size="62"><v-img v-if="userInfo.thumbnail" :src="userInfo.thumbnail.url"></v-img></v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title class="white--text">{{userInfo.name}}</v-list-item-title>
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
            userInfo: {},
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
    created(){
        axios.get('/api/v1/users/' + this.current_user.id)
        .then( res => {
            console.log(res.data.user);
            this.userInfo = res.data.user;
        })
        .catch( error => {
            console.log(error);
        });
    },
    methods: {
        onFileChange(e){
            let selectFile = e;
            let reader = new FileReader();
            reader.onload = e => {
                this.uploadedThumbnail = e.target.result;
            }
            reader.readAsDataURL(selectFile);
            this.userInfo.thumbnail = selectFile;
        },
        update(){
            let formData = new FormData();
            formData.append("user[name]", this.userInfo.name);
            formData.append("user[ubered_count]", this.userInfo.ubered_count);
            formData.append("user[profile_comment]", this.userInfo.profile_comment);
            formData.append("user[status]", this.userInfo.status);
            formData.append("user[address]", this.userInfo.address);
            formData.append("user[thumbnail]", this.userInfo.thumbnail);
            axios.patch('/api/v1/users/' + this.current_user.id, formData)
                .then(res => {
                    if (res.data.errors){
                        this.errors = res.data.errors
                    } else {
                        console.log(res);
                        this.$router.push({ path: '/' });
                    }
                })
                .catch(erro => {
                    console.log(erro);
                });
        },
    }
}
</script>