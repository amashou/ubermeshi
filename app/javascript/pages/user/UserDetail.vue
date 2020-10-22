<template>
    <div>
        <h2>ユーザー詳細ページ</h2>
        <ul>
            <li>{{userInfo.id}}</li>
            <li>{{userInfo.name}}</li>
            <li>{{userInfo.email}}</li>
            <li>{{userInfo.uberd_count}}</li>
        </ul>
        <router-link :to="{ name: 'UserEdit', params: { id: userInfo.id }}">編集ページへ</router-link>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return{
            userInfo: {}    
        }
    },
    created(){
        axios.get('/api/v1/users/'+ this.$route.params.id,
        {
            // headers: {
            //         "content-type": "multipart/form-data",
            //         "access-token": localStorage.getItem("access-token"),
            //         uid: localStorage.getItem("uid"),
            //         client: localStorage.getItem("client")
            // }
        })
        .then((response) => {
            console.log(response);
            this.userInfo = response.data
        })
        .catch((errors) => {
            console.log(errors);
        });
    }
}
</script>