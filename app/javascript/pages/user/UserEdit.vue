<template>
    <div>
        <h2>ユーザー情報編集ページ</h2>
        <v-form @submit.prevent="update">　
                <v-avatar>
                    <!-- <img v-if="user.image !== null" :src="user.thumbnail.url"> -->
                    <img v-if="user.image !== null" :src="user.thumbnail">
                    <v-icon v-else size="100" color="#90A4AE" dark>mdi-account-circle</v-icon>
                </v-avatar>
                <v-file-input @change="selectedFile" prepend-icon="mdi-camera" label="アイコン"></v-file-input>
                <v-text-field v-model="user.name" label="名前"></v-text-field>
                <v-text-field v-model="user.email" label="Email"></v-text-field>
                <v-text-field v-model="user.profile_comment" label="コメント"></v-text-field>
                <v-select v-model="user.ubered_count" :items="items" label="ウーバー回数"></v-select>
                <v-select v-model="user.status" :status="status" label="ステータス"></v-select>
                <v-btn type="submit">更新</v-btn>
        </v-form>
    </div>
</template>

<script>
import axios from 'axios';

const maxAge = 130;
const uber_count = [1,5,10,20,30,40,50,60,70,80,90,100,200,300,400,500,1000,2000]

export default {
    data(){
        return{
            items: uber_count,
            status: ['HeavyUser','User', 'Driver'],
            user:[],
            isAddedfile: false,
            preview: false
        }
    },
    created(){
        axios.get('/api/v1/users/'+ this.$route.params.id)
            .then((response) => {
                console.log(response);
                this.user = response.data;
            })
            .catch((errors) => {
                console.log(errors);
            });
    },
    methods: {
        selectedFile(e){
            if(!e) {
                this.preview = null;
                this.isAddedfile = false;
            }else{
                console.log(e);
                this.user.thumbnail = e;
                this.preview = window.URL.createObjectURL(e);
                this.isAddedfile = true;
            }
        },
        update(){
            let formData = new FormData();
            formData.append("user[name]", this.user.name);
            formData.append("user[email]", this.user.email);
            formData.append("user[ubered_count]", this.user.ubered_count);
            formData.append("user[comment]", this.user.comment);
            formData.append("user[status]", this.user.status);
            if (this.user.image) {
                formData.append("user[image]", this.user.image);
            }
            console.log(formData);
            axios.patch('/api/v1/users/'+ this.user.id, formData)
                .then((response) => {
                    console.log(response);
                    this.user = response.data;
                    this.$router.push({ path: '/users'});
                })
                .catch((errors) => {
                    console.log(errors);
                });
        }
    }
}
</script>