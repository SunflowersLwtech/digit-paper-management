<template>
  <div class="login-wrap">
    <div class="background-overlay"></div>
    <div class="ms-login">
      <div class="login-header">
        <h2>电子试卷管理系统</h2>
      </div>

      <el-form :model="param" :rules="rules" ref="login" label-width="0px" class="ms-content">
        <el-form-item prop="phone">
          <el-input v-model="param.phone" placeholder="账号">
            <i slot="prefix" class="el-input__icon el-icon-user"></i>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="密码"
            v-model="param.password"
            @keyup.enter.native="submitForm()">
            <i slot="prefix" class="el-input__icon el-icon-lock"></i>
          </el-input>
        </el-form-item>
        <el-form-item prop="type">
          <el-select v-model="param.type" placeholder="选择身份" style="width: 100%">
            <el-option label="管理员" value="01"></el-option>
            <el-option label="教师" value="02"></el-option>
            <el-option label="学生" value="03"></el-option>
          </el-select>
        </el-form-item>
        <div class="login-btn">
          <el-button type="primary" round @click="submitForm()">登 录</el-button>
        </div>
      </el-form>
      <div class="register-link" style="text-align: center; margin-top: 10px;">
        <router-link to="/register" style="color: #409EFF; text-decoration: none;">创建账号</router-link>
      </div>
    </div>
  </div>
</template>

<script>
    import SIdentify from '../../common/admin/SIdentify.vue'

    export default {
        data() {
            return {
                activeName: 'first',
                stretch:true,
                validCode: '',
                param: {
                    phone: '',
                    password: '',
                    type:'01',
                },
                rules: {
                    phone: [{required: true, message: '请输入账号', trigger: 'blur'}],
                    password: [{required: true, message: '请输入密码', trigger: 'blur'}],
                    type: [{required: true, message: '请选择人员类型', trigger: 'blur'}],
                },
            }
        },
        components: {SIdentify},
        methods: {
            submitForm() {
                this.$refs.login.validate(valid => {
                    if (valid) {
                        this.$axios.post('/api/login', this.param).then(res => {
                            if (res.data.code === 200) {
                                this.$message.success(res.data.msg);
                                this.common.set('userInfo',JSON.stringify(res.data.data));
                                this.common.set('token',res.data.data.token);
                                this.common.set('type',this.param.type);
                                if(this.param.type=='01'){
                                    this.$router.push('/admin/UserList');
                                }
                                if(this.param.type=='02'){
                                    this.$router.push('/admin/QuestionList');
                                }
                                if(this.param.type=='03'){
                                    this.$router.push('/admin/ExamsList');
                                }
                            } else
                                this.$message.error(res.data.msg);
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
        }
    };
</script>
<style scoped>
.login-wrap {
  position: relative;
  width: 100%;
  height: 100%;
  background-image: url('../../../assets/img/1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
}

.background-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(251, 251, 253, 0.7);
  backdrop-filter: blur(10px);
  z-index: 1;
}

.ms-login {
  position: relative;
  width: 420px;
  padding: 48px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.18);
  transition: transform 0.3s ease;
  z-index: 2;
}

.ms-login:hover {
  transform: translateY(-2px);
}

.login-header {
  text-align: center;
  margin-bottom: 40px;
}

.login-header h2 {
  font-size: 32px;
  color: #1d1d1f;
  margin-bottom: 12px;
  font-weight: 600;
  letter-spacing: -0.5px;
}

.login-header p {
  color: #86868b;
  font-size: 17px;
  font-weight: 400;
}

.ms-content {
  margin: 24px 0;
}

.el-form-item {
  margin-bottom: 24px;
}

.el-input {
  height: 48px;
}

.el-input__inner {
  height: 48px;
  line-height: 48px;
  padding-left: 16px !important;
  background: #f5f5f7;
  border: none;
  border-radius: 12px;
  font-size: 16px;
  transition: all 0.3s ease;
}

.el-input__inner:focus {
  background: #fff;
  box-shadow: 0 0 0 2px #0066cc40;
}

.el-input__icon {
  line-height: 48px;
  color: #86868b;
  font-size: 18px;
}

.login-btn {
  margin-top: 32px;
}

.login-btn button {
  width: 100%;
  height: 48px;
  font-size: 17px;
  font-weight: 500;
  background: #0071e3;
  border: none;
  border-radius: 12px;
  transition: all 0.3s ease;
}

.login-btn button:hover {
  background: #0077ED;
  transform: translateY(-1px);
}

.login-footer {
  display: flex;
  justify-content: center;
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #f5f5f7;
  position: relative;
  z-index: 3;
}

.footer-link {
  color: #0066cc;
  font-size: 15px;
  text-decoration: none;
  transition: color 0.2s;
  position: relative;
  z-index: 3;
}

.footer-link:hover {
  color: #0077ED;
  text-decoration: underline;
}

/* Element UI 样式覆盖 */
::deep(.el-select .el-input__inner) {
  padding-left: 16px !important;
}

:deep(.el-select .el-input.is-focus .el-input__inner) {
  background: #fff;
  box-shadow: 0 0 0 2px #0066cc40;
}

:deep(.el-select-dropdown__item.selected) {
  color: #0066cc;
  font-weight: 500;
}

:deep(.el-select-dropdown__item) {
  padding: 12px 16px;
  font-size: 15px;
}

:deep(.el-select-dropdown) {
  border-radius: 12px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

:deep(.el-form-item.is-error .el-input__inner) {
  box-shadow: 0 0 0 2px rgba(255, 59, 48, 0.2);
}

:deep(.el-button--primary:focus, .el-button--primary:hover) {
  background: #0077ED;
  border-color: #0077ED;
}
</style>