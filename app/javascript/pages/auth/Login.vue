<template>
    <v-container>
        <v-card max-width="500px" class="mx-auto my-16" flat>
            <h3>ubermeshiへようこそ</h3>
            <p>ログイン</p>
        <v-form @submit.prevent="login">
            <v-text-field v-model="userInfo.email" label="Email" :rules="emailRules"></v-text-field>
            <v-text-field v-model="userInfo.password" label="Password" :rules="passwordRules"></v-text-field>
            <v-btn type="submit">送信</v-btn>
        </v-form>
        </v-card>
    </v-container>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return{
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
                .then((response) => {
                    console.log('This is response');
                    console.log(response);
                    localStorage.setItem("access-token", response.headers["access-token"]);
                    localStorage.setItem("uid", response.headers.uid);
                    localStorage.setItem("client", response.headers.client);
                    localStorage.setItem("expiry", response.headers.expiry);
                    localStorage.setItem("token-type", response.headers["token-type"]);
                    this.$store.dispatch("isLoggedIn", true);
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