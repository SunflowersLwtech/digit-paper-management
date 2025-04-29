import Vue from 'vue';
import Router from 'vue-router';
Vue.use(Router);
export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/login'
        },
        {
            path: '/admin/',
            component: () => import('../components/common/admin/Home.vue'),
            meta: {title: '管理员首页'},
            children: [
                {
                    path: '/admin/AdminList',
                    component: () => import('../components/page/admin/AdminList.vue'),
                    meta: {title: '管理员管理'}
                },
                {
                    path: '/admin/CourseList',
                    component: () => import('../components/page/admin/CourseList.vue'),
                    meta: {title: '课程管理'}
                },
                {
                    path: '/admin/ExamsList',
                    component: () => import('../components/page/admin/ExamsList.vue'),
                    meta: {title: '试卷管理'}
                },
                {
                    path: '/admin/MajorList',
                    component: () => import('../components/page/admin/MajorList.vue'),
                    meta: {title: '专业管理'}
                },
                {
                    path: '/admin/NoticeList',
                    component: () => import('../components/page/admin/NoticeList.vue'),
                    meta: {title: '公告管理'}
                },
                {
                    path: '/admin/QuestionList',
                    component: () => import('../components/page/admin/QuestionList.vue'),
                    meta: {title: '题库管理'}
                },
                {
                    path: '/admin/UserList',
                    component: () => import('../components/page/admin/UserList.vue'),
                    meta: {title: '用户管理'}
                },
                {
                    path: '/admin/ClassesList',
                    component: () => import('../components/page/admin/ClassesList.vue'),
                    meta: {title: '班级管理'}
                },
                {
                    path: '/admin/*',
                    redirect: '/404'
                }
            ]
        }, 
        {
            path: '/login',
            component: () => import('../components/page/admin/login.vue'),
            meta: {title: '登陆'}
        },{
            path: '/register',
            component: () => import('../components/page/admin/register.vue'),
            meta: {title: '注册'}
        },
        {
            path: '*',
            redirect: '/user/404'
        }
    ]
});
