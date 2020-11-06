
<template>
  <v-layout row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
            <v-btn fab x-large color="pink" dark class="mr-3 float-btn" v-bind="attrs" v-on="on">
                <v-icon>mdi-plus</v-icon>
            </v-btn>
      </template>
      <v-card v-if="isLoggedIn">
        <v-card-text>
          <v-container>
            <v-row v-if="errors">
              <v-col cols="12" class="pb-0">
                <v-alert v-for="error in errors" :key="error" type="error" outlined class="pa-2">{{error}}</v-alert>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field v-model="saerch_name" label="店舗名" clear-icon="mdi-close-circle" clearable required>
                </v-text-field>
                <v-btn @click="searchReastaurant" color="pink" dark class="mx-auto my-2" block><v-icon left>mdi-magnify</v-icon>お店を検索</v-btn>
              </v-col>
              <template v-if="searching">
                <v-col>
                   <v-card class="mb-2">
                    <v-list class="py-0">
                      <v-list-item @click="selectRestaurant()">
                        <v-list-item-content>
                          <v-list-item-title>候補がありません。このまま選択する</v-list-item-title>
                        </v-list-item-content>
                      </v-list-item>
                    </v-list>
                  </v-card>
                  <v-card v-for="(restaurant, index) in restaurants" :key="index" class="mb-2">
                    <v-list class="py-0">
                      <v-list-item @click="selectRestaurant(restaurant)">
                        <v-list-item-content>
                          <v-list-item-title>{{restaurant.name}}</v-list-item-title>
                          <v-list-item-subtitle>{{restaurant.address}}</v-list-item-subtitle>
                        </v-list-item-content>
                      </v-list-item>
                    </v-list>
                  </v-card>
                </v-col>
              </template>
              <v-col cols="12">
                <v-textarea v-model="postInfo.title" label="タイトル" rows="1" row-height="20" counter="30" outlined :disabled="isDisabled"></v-textarea>
              </v-col>
              <v-col cols="12" pb0>
                <v-textarea label="オススメポイント" v-model="postInfo.description" auto-grow outlined rows="1" row-height="20" counter="140" :disabled="isDisabled"></v-textarea>
              </v-col>
              <v-col cols="5" class="uploader">
                <v-sheet class="preview">
                  <v-icon x-large class="file-up btn" v-show="imageBtnToggle" @click="$refs.fileInput.click()">mdi-image-plus</v-icon>
                  <v-icon x-large class="file-down btn" v-show="!imageBtnToggle" @click="fileDown">mdi-close-circle-outline</v-icon>
                  <v-img :src="uploadFile" class="upload-file" max-height="300" max-width="350" contain>
                  </v-img>
                <input type="file" @change="onFileChange" ref="fileInput" style="display:none;">
                </v-sheet>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" outlined text @click="dialogClose">閉じる</v-btn>
          <v-btn color="blue darken-1" outlined text @click="createPost" class="ml-3" v-bind:disabled="isDisabled">投稿</v-btn>
        </v-card-actions>
      </v-card>
      <v-card v-else class="pa-5">
        <v-card-title class="text-center"><h4 class="mx-auto">新規投稿にはアカウントが必要です</h4></v-card-title>
        <v-card-actions class="d-flex justify-center">
          <v-btn type="submit" color="secondary" class="mx-1" @click="testLogin()">テストログイン</v-btn>
          <v-btn type="submit" color="secondary" class="mx-1" route :to="{ name: 'Login' }">ログイン</v-btn>
          <v-btn type="submit" color="secondary" class="mx-1" route :to="{ name: 'Signup' }">新規登録</v-btn>
          <v-btn type="submit" color="secondary" class="mx-1" @click="dialog = false">閉じる</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import axios from 'axios';
import axiosAuth from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data() {
        return {
            isDisabled: true,
            errors: {},
            searching: false,
            testUser: {
                email: "test@example.com",
                password: "password"
            },
            dialog: false,
            saerch_name: '',
            restaurants: [],
            restaurantInfo: {},
            postInfo: {
                title: "",
                description: "",
                food_picture: ""
            },
            isSelectedFile: false,
            uploadFile: '',
            imageBtnToggle: true,
        }
    },
    computed: {
      // ...mapGetters(['isLoggedIn', 'current_user'])
      isLoggedIn(){
        return this.$store.getters.isLoggedIn;
      }
    },
    methods: {
        LoggedinUser(){
          console.log('check loggedin') ;
          this.dialog = false;
        },
        fileDown(){
          let img = document.querySelector('upload-file');
          this.postInfo.food_picture =this.uploadFile = '';
          this.imageBtnToggle = !this.imageBtnToggle;
        },
        searchReastaurant(){
            const url = process.env.RESTAURANT_URL;
            const api = process.env.RESTAURANT_API;
            let params = '&name=' + this.saerch_name;
            axios.get(url + api + params)
                .then(res =>{
                    console.log(res);
                    this.restaurants = res.data.rest;
                    this.searching = true;
                })
                .catch( error => {
                    console.log(error)
                    this.errors = error.response
                })
        },
        onFileChange(e){
          console.log('target is ...', e.target.files);
          let reader = new FileReader();
          reader.onload = (e) => {
            console.log(e);
            this.uploadFile = e.target.result
          }
          reader.readAsDataURL(e.target.files[0]);
          this.imageBtnToggle = !this.imageBtnToggle;
          this.postInfo.food_picture = e.target.files[0];
        },
        selectRestaurant(obj = '') {
            this.saerch_name = obj.name || this.saerch_name ;
            this.restaurantInfo = obj;
            this.searching = false;
            this.isDisabled = false;
        },
        testLogin(){
            axios.post('/api/v1/auth/sign_in', this.testUser)
                .then(res => {
                    localStorage.setItem("access-token", res.headers["access-token"]);
                    localStorage.setItem("uid", res.headers.uid);
                    localStorage.setItem("client", res.headers.client);
                    localStorage.setItem("expiry", res.headers.expiry);
                    localStorage.setItem("token-type", res.headers["token-type"]);
                    localStorage.setItem("id", res.data.data.id);
                    this.$store.dispatch("isLoggedIn", true);
                    this.$store.dispatch("current_user", res.data.data);
                    // window.location.reload();
                })
                .catch( error => {
                    this.errors = error.response.data.errors;
                });
        },
        createPost(){
            const formData = new FormData();
            formData.append('restaurantInfo[name]', this.restaurantInfo.name)
            formData.append('restaurantInfo[address]', this.restaurantInfo.address)
            formData.append('restaurantInfo[url]', this.restaurantInfo.url)
            formData.append('restaurantInfo[restrant_image]', this.restaurantInfo.restrant_image)
            formData.append('restaurantInfo[tel]', this.restaurantInfo.tel)
            formData.append('restaurantInfo[opentime]', this.restaurantInfo.opentime)
            formData.append('restaurantInfo[latitude]', this.restaurantInfo.latitude)
            formData.append('restaurantInfo[longitude]', this.restaurantInfo.longitude)
            formData.append('restaurantInfo[id]]', this.restaurantInfo.id)
            formData.append('postInfo[title]', this.postInfo.title)
            formData.append('postInfo[description]', this.postInfo.description)
            formData.append('postInfo[food_picture]', this.postInfo.food_picture)
            formData.append('postInfo[restaurant_name]', this.restaurantInfo.name)
            formData.append('postInfo[restaurant_address]', this.restaurantInfo.address)
            console.log(formData);
            axiosAuth.post('/api/v1/posts', formData)
                .then(res => {
                    console.log(res);
                    if (res.data.errors) {
                      this.errors = res.data.errors
                    } else {
                      this.restaurantInfo = this.postInfo = this.saerch_name = this.uploadFile =  '';
                      this.imageBtnToggle = !this.imageBtnToggle;
                      this.isSelectedFile = this.dialog =　false;
                    }
                })
                .catch(erro => {
                    console.log(erro);
                });
        },
        dialogClose(){
          this.restaurantInfo = this.postInfo = this.saerch_name = this.uploadFile =  '';
          this.imageBtnToggle = true;
          this.dialog = this.isSelectedFile = false;
        }
    }
}
</script>

<style scoped>
.float-btn {
  position: fixed;
	bottom: 50px;
  right: 30px;
}
.uploader {
  position: relative;
}
.btn {
  position: absolute;
  top: -20px;
}
.file-down {
  position: absolute;
  top: -10px;
  z-index: inherit;
}
.btn:hover {
  cursor: pointer;
}
</style>