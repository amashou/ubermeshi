<template>
    <v-dialog max-width="600px" v-model="dialog">
        <template v-slot:activator="{ on, attrs }">
                <v-btn outlined absolute right v-bind="attrs" v-on="on">
                    <v-icon>mdi-chevron-down</v-icon>
                </v-btn>
        </template>

        <v-card>
            <v-card-title>コメント</v-card-title>
            <v-card-text>{{comment}}</v-card-text>
            <v-card-action>
                <v-btn outlined color="primary" @click="dialog = false">返信</v-btn>
            </v-card-action>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    data() {
        return {
            // props:['comment'],
            dialog: false
        }
    },
    methods: {
        sendReply(){
            console.log('送信');
            this.dialog = false
        }
    }
}
</script>