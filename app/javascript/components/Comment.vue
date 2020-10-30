<template>
    <v-row>
        <v-dialog v-model="commentDialog" persistent max-width="550px" class="pa-5">
            <template v-slot:activator="{ on, attrs }">
                <v-btn absolute right outlined top color="secondary" v-bind="attrs" v-on="on">
                    <v-icon>mdi-plus</v-icon>
                    コメント
                </v-btn>
            </template>
            <v-card class="pa-5">
                <v-textarea label="コメント" auto-grow outlined rows="1" row-height="15" id="comment-area" v-model="content"></v-textarea>
                <v-card-actions>
                    <v-btn color="blue darken-1" text @click="closeDialog">閉じる</v-btn>
                    <v-btn color="blue darken-1" text @click="postComment">コメント</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
import axios from '../axios-auth';

export default {
    data() {
        return {
            commentDialog: false,
            content: ''
        }
    },
    methods: {
       postComment() {
            const formData = new FormData();
            formData.append("content",this.content);
            console.log(formData);
            axios.post('/api/v1/posts/' + this.$route.params.id + '/comments', formData)
                .then(res => {
                    console.log(res);
                    let content = document.querySelector('#comment-area');
                    content.value = '';
                    this.$emit('reflectComment', {content: this.content});
                    this.commentDialog = false;
                })
                .catch((error) => {
                    console.log(error);
                })
        },
        closeDialog() {
            let content = document.querySelector('#comment-area');
            content.value = '';
            this.content = '';
            console.log(this.content);
            this.commentDialog = false;
        }
    }
}
</script>