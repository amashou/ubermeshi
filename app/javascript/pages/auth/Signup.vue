<template>
    <v-container>
        <v-card max-width="500px" class="mx-auto my-16" flat>
            <h3>ubermeshoへようこそ</h3>
            <p>新規登録</p>
            <v-form @submit.prevent="signUp">
            <v-text-field v-model="userInfo.email" label="Email" :rules="emailRules"></v-text-field>
            <v-text-field v-model="userInfo.password" label="Password" :rules="passwordRules"></v-text-field>
            <v-text-field v-model="userInfo.password_confirmation" label="Password_confirmation" :rules="passwordConfirmationRules"></v-text-field>
            <v-btn type="submit">登録</v-btn>
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
               password: "",
               password_confirmation: "",
           },
           emailRules: [
                   v => !!v || 'Emailは必ず入力してください',
                   v => {
                       const patters = /^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/;
                       return patters.test(v) || '正しい値を入力してください'
                   }
               ],
            passwordRules: [
                v => !!v || 'passwordは必ず入力してください',
                v => v.length >= 6 || '6文字以上で設定してください',
                v => v.length <= 15 || '15文字以内で設定してください'
            ],
            passwordConfirmationRules: [ v => v == this.userInfo.password || 'passwordの値が一致しません' ],
        }
    },
    methods: {
        signUp(){
            axios.post('/api/v1/auth/', this.userInfo)
                .then((response) => {
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
                })
        }
    }
}
</script>