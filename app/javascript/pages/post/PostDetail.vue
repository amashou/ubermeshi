<template>
        <v-container class="pb-12">
            <v-row class="mb-10" height="200px">
                <v-flex md6 xs11 class="mx-auto">
                     <v-list color="primary" class="mt-4">
                        <v-list-item route :to="{ name: 'UserDetail', params: user.id }">
                            <v-list-item-avatar color="grey"><v-img v-if="user.thumbnail" :src="user.thumbnail.url"></v-img></v-list-item-avatar>
                            <v-list-item-content>
                                <v-list-item-title>{{user.name}}</v-list-item-title>
                                <v-list-item-subtitle>{{user.status}}</v-list-item-subtitle>
                            </v-list-item-content>
                        </v-list-item>
                    </v-list>
                    <v-card min-height="200px" class="pb-5" color="primary" outlined>
                        <v-card-title>タイトル{{ post.title }}</v-card-title>
                        <v-card-text>description{{ post.description }}</v-card-text>
                            <v-btn class="ma-2 like-btn" color="secondary" outlined absolute bottom right @click="favorite">
                            <v-icon left>mdi-thumb-up</v-icon>いいね:{{favorites_count}}</v-btn>
                    </v-card>
                </v-flex>
                <v-flex md6 xs11 class="mx-auto mb-3 pt-5" v-if="post.food_picture.url">
                    <v-img :src="post.food_picture.url" aspect-ratio="1.7" min-height="250px" contain max-height="300px"></v-img>
                </v-flex>
            </v-row>
            <v-row>
                <v-flex class="mb-5 mx-auto" md6 xs11>
                    <v-card class="" color="primary" outlined height="300px">
                        <v-card-title class="text-center">お店情報</v-card-title>
                        <v-card-text>名前：{{restaurant.name}}</v-card-text>
                        <v-card-text>住所：{{restaurant.address}}</v-card-text>
                        <v-card-text>営業時間：{{restaurant.opentime}}</v-card-text>
                        <v-card-text>電話番号：{{restaurant.tel}}</v-card-text>
                        <v-card-actions v-if="restaurant.url !== null"><v-btn link :href="restaurant.url" color="secondary" outlined dark absolute right>詳しくはこちら</v-btn></v-card-actions>
                    </v-card>
                </v-flex>
                <v-flex md6 xs11 class="mx-auto">
                    <v-card class="px-10" color="primary" outlined>
                        <v-card-title>コメント</v-card-title>
                        <CommentDialog @reflectComment="comments.unshift($event)"></CommentDialog>
                    <v-list color="grey lighten-2">
                            <v-list-group v-for="(comment, index) in comments" :key="index">
                                <template v-slot:activator>
                                    <v-list-item-content>
                                        <v-list-item-title class="black--text">{{comment.content}}</v-list-item-title>
                                    </v-list-item-content>
                                </template>
                                <v-list-item class="pb-0">
                                    <v-list-item-content>
                                        <v-list-item-title v-for="(reply, index) in comment.replys" :key="index" class="mb-2 pl-3">{{reply.content}}</v-list-item-title>
                                        <template v-if="replyErrors">
                                            <v-alert v-for="error in replyErrors" :key="error" type="error" outlined>{{error}}</v-alert>
                                        </template>
                                        <v-textarea v-model="replyMessage" label="返信メッセージ" outlined clearable auto-grow rows="1" class="mt-3"></v-textarea>
                                        <v-btn @click="sendReply(comment.id, index)" color="secondary" rounded max-width="80px" bottom right>送信</v-btn>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-list-group>
                    </v-list>
                    </v-card>
                </v-flex>
            </v-row>
        </v-container>
</template>

<script>
import axios from '../../axios-auth';
import CommentDialog from '../../components/Comment';
import ReplyDialog from '../../components/Reply';

export default {
    components: { CommentDialog, ReplyDialog },
    data(){
        return{
            replyMessage: '',
            toggleBtn: '',
            post: {},
            restaurant: {},
            user: {},
            favorites_count:'',
            current_user:{},
            comments: [],
            formComment: "",
            errors: "",
            replyErrors: ""
        }
    },
    computed:{
        newreplys(){
            return this.replys;
        }
    },
    created(){
        axios.get('/api/v1/posts/'+ this.$route.params.id)
            .then(res => {
                this.post.id = res.data.id;
                this.post.title = res.data.title;
                this.post.description = res.data.description;
                this.post.food_picture = res.data.food_picture;
                this.restaurant = res.data.restaurantInfo;
                this.user = res.data.userInfo;
                this.favorites_count = res.data.favorites_count;
                this.comments = res.data.comments;
            })
            .catch(erro => {
                console.log(erro);
            });
    },
    methods: {
        favorite(){
            axios.post('/api/v1/posts/' + this.post.id + '/favorites',)
                .then( res => {
                    this.favorites_count = res.data.favorites_count
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
        unfavorite(){
            axios.delete('/api/v1/posts/' + this.post.id + '/favorites')
                .then((response) => {
                    if(response.data.favorites_count){
                        this.favorites_count = response.data.favorites_count;
                    } else {
                        this.errors = response.data.message;
                    }
                })
                .catch((errors) => {
                    console.log(errors);
                });
        },
        sendReply(comment_id, comments_index){
            let formData = new FormData();
            formData.append('reply[content]', this.replyMessage);
            axios.post('/api/v1/posts/' + this.post.id + "/comments/" + comment_id + "/replys", formData)
                .then(res => {
                    if (res.data.error) {
                        this.replyErrors = res.data.error;
                    } else {
                        window.location.reload();
                    }
                    // リダイレクトしなくても返信が反映するようにする
                    // this.comments[comments_index].replys.unshift({contnet: this.replyMessage});
                })
                .catch(erro => {
                    console.log(erro);
                })
        }
    }
};
</script>
<style scoped>
.comment-title:hover{
    cursor: pointer;
    background-color: silver;
}
</style>