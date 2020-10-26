<template>
    <v-container>
        <v-card max-width="400px" class="mx-auto my-16" flat color="primary">
            <v-card-title>ubermeshiへようこそ</v-card-title>
            <v-card-text>新規登録</v-card-text>
            <v-form @submit.prevent="signUp">
                <v-text-field v-model="userInfo.email" label="Email" :rules="emailRules" color="secondary"></v-text-field>
                <v-text-field v-model="userInfo.password" label="Password" :rules="passwordRules" :type="show ? 'text' : 'password'" 
                    @click:append="show = !show" :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'" color="secondary">
                </v-text-field>
                <v-text-field v-model="userInfo.password_confirmation" label="Password_confirmation" :rules="passwordConfirmationRules" :type="show ? 'text' : 'password'" 
                    @click:append="show = !show" :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'" color="secondary">
                </v-text-field>
                <v-col class="d-flex flex-row-reverse">
                    <v-btn type="submit" color="secondary" class="ml-2">登録</v-btn>
                    <v-btn type="submit" color="secondary" class="ml-2" route :to="{ name: 'Login' }">ログインへ</v-btn>
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