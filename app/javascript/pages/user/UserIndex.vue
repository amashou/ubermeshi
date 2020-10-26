<template>
    <div>
        <h2>ユーザー一覧ページ</h2>
        <ul v-for="(user, index) in users" :key="index">
            <li><router-link :to="{ path: '/users/' + user.id, params: { id: user.id }}">{{user.id}}</router-link></li>
            <li>{{user.name}}</li>
            <li>{{user.ubered_count}}</li>
            <li>{{user.comment}}</li>
        </ul>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data(){
        return{
            users: []
        }
    },
    created(){
        axios.get('/api/v1/posts',
        {
            headers: {
                    "content-type": "multipart/form-data",
                    "access-token": localStorage.getItem("access-token"),
                    uid: localStorage.getItem("uid"),
                    client: localStorage.getItem("client")
            }
        })
        .then((response) => {
            console.log(response);
            this.users = response.data
        })
        .catch((errors) => {
            console.log(errors);
        });
    }
}
</script>
