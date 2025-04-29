<template>
    <div class="sidebar">
        <el-menu
            class="sidebar-el-menu"
            :default-active="onRoutes"
            :collapse="collapse"
            background-color="#409eff"
            text-color="#bfcbd9"
            active-text-color="#20a0ff"
            unique-opened
            router
        >
            <template v-for="item in items">
                <template v-if="item.role==type">
                    <template v-if="item.subs">
                        <el-submenu :index="item.index" :key="item.index">
                            <template slot="title">
                                <i :class="item.icon"></i>
                                <span slot="title">{{ item.title }}</span>
                            </template>
                            <template v-for="subItem in item.subs">
                                <el-submenu
                                        v-if="subItem.subs"
                                        :index="subItem.index"
                                        :key="subItem.index"
                                >
                                    <template slot="title">{{ subItem.title }}</template>
                                    <el-menu-item
                                            v-for="(threeItem,i) in subItem.subs"
                                            :key="i"
                                            :index="threeItem.index"
                                    >{{ threeItem.title }}</el-menu-item>
                                </el-submenu>
                                <el-menu-item
                                        v-else
                                        :index="subItem.index"
                                        :key="subItem.index"
                                >{{ subItem.title }}</el-menu-item>
                            </template>
                        </el-submenu>
                    </template>
                    <template v-else>
                        <el-menu-item :index="item.index" :key="item.index">
                            <i :class="item.icon"></i>
                            <span slot="title">{{ item.title }}</span>
                        </el-menu-item>
                    </template>
                </template>
            </template>
        </el-menu>
    </div>
</template>
<script>
import bus from './bus';
import common from "../../../utils/common";
export default {
    data() {
        return {
            collapse: false,
            type:'',
            items: [
                {
                    icon: 'el-icon-user',
                    index: 'UserList',
                    title: '用户管理',
                    role:'01'
                },
                {
                    icon: 'el-icon-s-order',
                    index: 'ClassesList',
                    title: '班级管理',
                    role:'01'
                },
                {
                    icon: 'el-icon-s-flag',
                    index: 'MajorList',
                    title: '专业管理',
                    role:'01'
                },
               
                {
                    icon: 'el-icon-date',
                    index: 'CourseList',
                    title: '课程管理',
                    role:'01'
                },
                {
                    icon: 'el-icon-document-copy',
                    index: 'QuestionList',
                    title: '题库管理',
                    role:'01'
                },
                {
                    icon: 'el-icon-reading',
                    index: 'ExamsList',
                    title: '试卷管理',
                    role:'01'
                },
                {
                    icon: 'el-icon-chat-square',
                    index: 'NoticeList',
                    title: '公告管理',
                    role:'01'
                },

                {
                    icon: 'el-icon-document-copy',
                    index: 'QuestionList',
                    title: '题库管理',
                    role:'02'
                },
                {
                    icon: 'el-icon-reading',
                    index: 'ExamsList',
                    title: '试卷管理',
                    role:'02'
                },
                {
                    icon: 'el-icon-chat-square',
                    index: 'NoticeList',
                    title: '公告管理',
                    role:'02'
                },

                {
                    icon: 'el-icon-reading',
                    index: 'ExamsList',
                    title: '试卷管理',
                    role:'03'
                },
                {
                    icon: 'el-icon-chat-square',
                    index: 'NoticeList',
                    title: '公告管理',
                    role:'03'
                },
            ]
        };
    },
    computed: {
        onRoutes() {
            return this.$route.path.replace('/', '');
        }
    },
    created() {
        // 通过 Event Bus 进行组件间通信，来折叠侧边栏
        bus.$on('collapse', msg => {
            this.collapse = msg;
            bus.$emit('collapse-content', msg);
        });
        this.getInfo();
    },
    methods: {
        getInfo(){
            this.type = this.common.get("type");
        }
    }
};
</script>
<style scoped>
.sidebar {
    display: block;
    position: absolute;
    left: 0;
    top: 45px;
    bottom: 0;
    overflow-y: scroll;
}
.sidebar::-webkit-scrollbar {
    width: 0;
}
.sidebar-el-menu:not(.el-menu--collapse) {
    width: 250px;
}
.sidebar > ul {
    height: 100%;
}
.el-menu-item{
    color: rgb(251, 251, 251) !important;
    background-color: aqua;
}
.el-menu-item i {
    color: #fdfdfd !important;
}
</style>
