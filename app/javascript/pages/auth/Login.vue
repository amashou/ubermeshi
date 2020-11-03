<template>
    <v-container>
        <v-card max-width="500px" class="mx-auto my-16" flat color="primary">
            <v-card-title>ubermeshiへようこそ</v-card-title>
            <v-card-text>ログイン</v-card-text>
            <v-form @submit.prevent="login">
                <v-text-field v-model="userInfo.email" label="Email" :rules="emailRules" color="secondary"></v-text-field>
                <v-text-field v-model="userInfo.password" label="パスワード" :rules="passwordRules" :type="show ? 'text' : 'password'" 
                    @click:append="show = !show" :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'" color="accent">
                </v-text-field>
                <v-col class="d-flex flex-row-reverse">
                    <v-btn type="submit" color="secondary" class="ml-2">ログイン</v-btn>
                    <v-btn type="submit" color="secondary" class="ml-2" route :to="{ name: 'Signup' }">新規登録へ</v-btn>
                    <v-btn type="submit" color="secondary" class="ml-2" route :to="{ name: 'Top' }">Topへ</v-btn>
                </v-col>
            </v-form>
        </v-card>
    </v-container>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return{
           show: false,
           userInfo: {
               email: "",
               password: ""
           },
           errors: {},
           emailRules: [
               v => {
                       const patters = /^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/;
                       return patters.test(v) || '正しい値を入力してください'
                   }
           ],
           passwordRules: [
               v => !!v || 'パスワードを入力してください'
           ]
        }
    },
    methods: {
        login(){
            axios.post('/api/v1/auth/sign_in', this.userInfo)
                .then(res => {
                    console.log('login response is back!');
                    console.log(res);
                    localStorage.setItem("access-token", res.headers["access-token"]);
                    localStorage.setItem("uid", res.headers.uid);
                    localStorage.setItem("client", res.headers.client);
                    localStorage.setItem("expiry", res.headers.expiry);
                    localStorage.setItem("token-type", res.headers["token-type"]);
                    localStorage.setItem("id", res.data.data.id);
                    this.$store.dispatch("isLoggedIn", true);
                    this.$store.dispatch("current_user", res.data.data);
                    this.$router.push({ path: "/" });
                })
                .catch((error) => {
                    console.log(error);
                    this.errors = error;
                })
        }
    }
}
</script>