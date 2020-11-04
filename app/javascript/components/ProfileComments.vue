<template>
    <v-container>
        <p v-if="!comments.length"></p>
        <v-sheet v-else max-width="600px" class="mx-auto my-12" color="secondary">
            <v-list color="pink" class="white-text">
                <v-list-item>
                    <v-list-item-avatar color="grey" size="62"><v-img v-if="current_user.thumbnail" :src="current_user.thumbnail.url"></v-img></v-list-item-avatar>
                    <v-list-item-content>
                        <v-list-item-title class="white--text">{{current_user.name}}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
            <v-card tile>
                <v-list dense class="pa-2">
                    <v-list-item-title>コメント</v-list-item-title>
                    <v-list-item v-for="(comment, index) in comments" :key="index" class="list-item py-1">
                        <v-list-item-content>
                            <v-list-item-title>{{comment.content}}<span>{{comment.updated_at}}</span></v-list-item-title>
                        </v-list-item-content>
                        <v-spacer></v-spacer>
                        <v-btn outlined fab @click="destroy(comment, 'comments')">
                            <v-icon>mdi-trash-can-outline</v-icon>
                        </v-btn>
                        <v-btn outlined fab class="ml-1" @click="popup(comment, 'comments')">
                            <v-icon>mdi-pencil-plus-outline</v-icon>
                        </v-btn>
                    </v-list-item>
                    <v-divider class="my-2"></v-divider>
                    <v-list-item-title>送信</v-list-item-title>
                    <v-list-item v-for="(reply, index) in replys" :key="index" class="list-item py-1">
                        <v-list-item-content>
                            <v-list-item-title>{{reply.content}}<span>{{reply.updated_at}}</span></v-list-item-title>
                        </v-list-item-content>
                        <v-spacer></v-spacer>
                            <v-btn outlined fab @click="destroy(reply, 'replys')">
                                <v-icon>mdi-trash-can-outline</v-icon>
                            </v-btn>
                            <v-btn @click="popup(reply, 'replys')" outlined fab class="ml-1">
                                <v-icon>mdi-pencil-plus-outline</v-icon>
                            </v-btn>
                    </v-list-item>
                </v-list>
            </v-card>
            <v-col class="d-flex flex-row-reverse">
                <v-btn route :to="{ path: '/' }" color="pink" dark rounded class="btn">Topへ</v-btn>
            </v-col>
        </v-sheet>
        <v-dialog  v-model="dialogs" max-width="700" class="pa-3">
            <v-card class="pa-3">
                <v-textarea v-model="update_obj.content" label="コメント" auto-grow rows="1" row-height="20" outlined class="pa-2"></v-textarea>
                <v-card-actions>
                    <v-btn @click="updateComment()" color="blue darken-1" text>更新</v-btn>
                    <v-btn @click="closeDialog()" color="blue darken-1" text>閉じる</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script>
import axios from '../axios-auth';
import { mapGetters } from 'vuex';

export default {
    data(){
        return {
            dialogs: false,
            comments: {},
            replys: {},
            update_obj: {},
            obj_name: '',
            url: '',
        }
    },
    computed: {
        ...mapGetters(["isLoggedIn", "current_user"])
    },
    created(){
        axios.get('/api/v1/users/' + this.current_user.id + '/comments')
        .then( res => {
            console.log(res);
            this.comments = res.data.comments;
            this.replys = res.data.replys;
        })
        .catch( error => {
            console.log(error);
        });
    },
    methods: {
        closeDialog(){
            this.dialogs = false;
            this.updateContent = '';
        },
        popup(update_obj, obj_name){
            this.update_obj = update_obj;
            this.obj_name = obj_name
            this.dialogs = true;
        },
        updateComment(){
            axios.patch('/api/v1/'+ this.obj_name + '/' + this.update_obj.id, this.update_obj)
                .then( res => {
                    this.dialogs = false;
                    this.obj_name = this.update_obj = this.url = '',
                    console.log(res);
                })
                .catch( error => {
                    console.log(error);
                    // this.errors = error.response.errors.full_message
                })
        },
        destroy(obj, obj_name){
            axios.delete('/api/v1/'+ obj_name + '/' + obj.id)
            console.log('削除しました');
            window.location.reload();
        }
    }
}
</script>

<style scoped>
/* .list-item:hover {
    cursor: pointer;
    background-color: #BDBDBD;
} */
</style>