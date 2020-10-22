<template>
    <div>
        <v-card max-width="500px" class="mx-auto my-16" flat>
        <h2>新規投稿ページ</h2>
        <v-form @submit.prevent="createPost">
            <v-text-field v-model="post.title" label="タイトル"></v-text-field>
            <v-text-field v-model="post.description" label="ウバポイント"></v-text-field>
            <v-text-field v-model="post.times" label="利用回数"></v-text-field>
            <v-text-field v-model="restaurant_name" @change="searchReastaurant" label="店舗名"></v-text-field>
            <v-btn type="submit">投稿</v-btn>
        </v-form>
        <p>候補から選択してください</p>
        <ul v-for="(res, index) in restaurants" :key="index">
            <v-btn @click="selectedRestaurant" :value="index">
                    <li :value="index">店名:{{res.name}}</li>
                    <li :value="index">住所：{{res.address}}</li>
                    <li :value="index"><img :src="res.image_url.shop_image1" size="300x300"></li>
                    <li class="restaurant-info" style="display:none;">{{res}}</li>
            </v-btn>
        </ul>
        </v-card>
    </div>
</template>

<script>
import axios from 'axios';
import axiosAuth from '../../axios-auth';
// import axiosRestau from '../../axios-restau';

export default {
    data(){
        return{
           post: {
               title: "",
               description: "",
               times: "",
               images: "",
               restaurant_id: ""
           },
           restaurants:[],
           restaurant_name: "",
           restaurantInfo:[]
        }
    },
    methods: {
        // selectedFile(e) {
        //     if (!e) {
        //         this.image = null;
        //         this.isAddedFile = false;
        //     } else {
        //         this.restaurantInfo.restaurant_image = e;
        //         this.preview = window.URL.createObjectURL(e);
        //         this.isAddedFile = true;
        //     }
        // },
        selectedRestaurant(e,value) {
            this.post.restaurant_name = this.restaurant_name = this.restaurants[e.target.value].name;
            this.restaurantInfo = this.restaurants[e.target.value];
        },
        searchReastaurant(){
            const url = process.env.RESTAURANT_URL;
            const api_key = process.env.RESTAURANT_API;
            let params = '&name=' + this.restaurant_name;

            axios.get(url + api_key + params)
                .then((response) => {
                    console.log(response.data.rest);
                    this.restaurants = response.data.rest;
                })
                .catch((errors) => {
                    console.log(errors);
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
            console.log(formData);
            axiosAuth.post('/restaurants', formData)
                .then((response) => {
                    console.log('this is response from restaurantCreate');
                    console.log(response);
                    this.post.restaurant_id = response.data.data.id
                    this.post.images = response.data.data.restrant_image
                    console.log(this.post);
                    axiosAuth.post('/posts', this.post)
                        .then((response) => {
                            console.log('this is response from postCreate');
                            console.log(response);
                            this.$router.push({ name: 'Top' });
                        })
                        .catch((errors) => {
                            console.log(errors);
                        })
                })
                .catch((errors) => {
                    console.log(errors);
                });
        }
    }
}
</script>
<style scoped>
</style>