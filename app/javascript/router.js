import Vue from 'vue';
import Router from 'vue-router';

import Top from './pages/Top.vue';
import Login from './pages/auth/Login.vue';
import Signup from './pages/auth/Signup.vue';

import UserIndex from './pages/user/UserIndex.vue';
import UserDetail from './pages/user/UserDetail.vue';
import UserEdit from './pages/user/UserEdit.vue';
import Profile from './pages/user/Profile.vue'
import PostCreate from './pages/post/PostCreate.vue';
import PostDetail from './pages/post/PostDetail.vue';
import ProfilePosts from './components/ProfilePosts.vue';
import ProfileComments from './components/ProfileComments.vue';
import ProfileFollows from './components/ProfileFollows.vue';
import ProfileRoot from './components/ProfileRoot.vue';

import store from './store';


Vue.use(Router);

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            name: "Top",
            component: Top
        },
        {
            path: '/login',
            name: 'Login',
            component: Login
        },
        {
            path: '/signup',
            name: 'Signup',
            component: Signup
        },
        {
            path: '/users',
            name: 'UserIndex',
            component: UserIndex
        },
        {
            path: '/users/:id',
            name: 'UserDetail',
            component: UserDetail
        },
        {
            path: '/users/:id/edit',
            name: 'UserEdit',
            component: UserEdit
        },
        {
            path: '/posts/new',
            name: 'PostCreate',
            component: PostCreate,
            meta: { requiresAuth: true }
        },
        {
            path: '/posts/:id',
            name: 'PostDetail',
            component: PostDetail
        },
        {
            path: '/profile',
            name: 'Profile',
            component: Profile,
            children: [
                { path: '', component: ProfileRoot },
                { path: 'posts', component: ProfilePosts },
                { path: 'comments', component: ProfileComments },
                { path: 'follows', component: ProfileFollows }
            ]
        }
    ]
});