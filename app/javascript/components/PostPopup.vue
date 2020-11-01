
<template>
  <v-layout row justify="center">
    <v-dialog
      v-model="dialog"
      persistent
      max-width="600px"
    >
      <template v-slot:activator="{ on, attrs }">
            <v-btn fab x-large color="pink" dark class="mr-3 float-btn" v-bind="attrs" v-on="on">
                <v-icon>mdi-plus</v-icon>
            </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline"></span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <!-- <v-text-field v-model="saerch_name" @change="searchReastaurant" label="店舗名" clearable> -->
                <v-text-field v-model="saerch_name" label="店舗名" clear-icon="mdi-close-circle"
                clearable　append-outer-icon="mdi-magnify" @click:append-outer="searchReastaurant" required>
                </v-text-field>
              </v-col>
              <template v-if="searching">
              <v-col md="6" sm="12" v-for="(restaurant, index) in restaurants" :key="restaurant.index">
                <v-card @click="selectRestaurant(index)">
                  <v-card-title>{{restaurant.name}}</v-card-title>
                  <v-card-text>{{restaurant.address}}</v-card-text>
                </v-card>
              </v-col>
              </template>
              <v-col cols="12">
                <v-text-field v-model="postInfo.title" label="タイトル" required></v-text-field>
              </v-col>
              <v-col cols="12" pb0>
                <v-textarea label="おすすめポイント" auto-grow rows="1"></v-textarea>
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
          <v-btn
            color="blue darken-1"
            text
            @click="dialog = false"
          >
            閉じる
          </v-btn>
          <v-btn
            color="blue darken-1"
            text
            @click="createPost"
          >
            投稿
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import axios from 'axios';
import axiosAuth from '../axios-auth';

export default {
    data() {
        return {
            searching: true,
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
    methods: {
        fileDown(){
          let img = document.querySelector('upload-file');
          img.remove();
          this.postInfo.food_picture = null;
          this.uploadFile = null;
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
                .catch(erro => {
                    console.log(erro);
                })
        },
        onFileChange(e){
          console.log('target is ...', e.target.files);
          let selectFile = e.target.files;
          let reader = new FileReader();
          reader.onload = (e) => {
            console.log(e);
            this.uploadFile = e.target.result
          }
          reader.readAsDataURL(selectFile[0]);
          this.imageBtnToggle = !this.imageBtnToggle;
          this.postInfo.food_picture = selectFile[0];
        },
        selectRestaurant(index) {
            this.saerch_name = this.restaurants[index].name;
            this.restaurantInfo = this.restaurants[index];
            this.searching = false;
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
                    console.log('this is response');
                    console.log(res);
                    this.restaurantInfo = {};
                    this.postInfo = {};
                    this.saerch_name = '';
                    this.dialog =　false;
                })
                .catch(erro => {
                    console.log(erro);
                });
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