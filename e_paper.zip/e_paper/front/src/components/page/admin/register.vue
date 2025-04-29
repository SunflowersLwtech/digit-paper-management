<template>
  <div class="login-wrap">
    <div class="background-overlay"></div>
    <div class="ms-login">
      <div class="login-header">
        <h2>电子试卷管理系统</h2>
        <p>创建您的账号</p>
      </div>

      <el-form :model="param" :rules="rules" ref="login" class="ms-content" label-width="0">
        <el-form-item prop="phone">
          <el-input v-model="param.phone" placeholder="请输入手机号">
            <i slot="prefix" class="el-input__icon el-icon-mobile-phone"></i>
          </el-input>
        </el-form-item>
          <el-form-item prop="sno" v-if="param.type=='02'">
              <el-input v-model="param.sno" placeholder="请输入学号">
                  <i slot="prefix" class="el-input__icon el-icon-s-custom"></i>
              </el-input>
          </el-form-item>
          <el-form-item prop="cid" v-if="param.type=='02'">
              <el-select v-model="param.cid" clearable placeholder="请选择班级">
                  <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                <i slot="prefix" class="el-input__icon el-icon-s-operation"></i>
              </el-select>
          </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="请输入密码"
            v-model="param.password">
            <i slot="prefix" class="el-input__icon el-icon-lock"></i>
          </el-input>
        </el-form-item>
        <el-form-item prop="repassword">
          <el-input
            type="password"
            placeholder="请确认密码"
            v-model="param.repassword">
            <i slot="prefix" class="el-input__icon el-icon-key"></i>
          </el-input>
        </el-form-item>
          <el-form-item prop="type">
              <el-select v-model="param.type" placeholder="选择身份" style="width: 100%">
                  <el-option label="教师" value="01"></el-option>
                  <el-option label="学生" value="02"></el-option>
              </el-select>
          </el-form-item>
        <div class="login-btn">
          <el-button type="primary" round @click="submitForm()">注 册</el-button>
        </div>
      </el-form>

      <div class="login-footer">
        <router-link to="/login" class="footer-link">返回登录</router-link>
      </div>
    </div>
  </div>
</template>

<script>
    export default {
        data() {
            var validatePhone = (rule, value, callback) => {
                if (value && value != "") {
                    if (
                        !/^1[0-9]{10}$/.test(
                            value
                        )
                    ) {
                        callback(new Error("请输入正确的手机号码"));
                    } else {
                        callback();
                    }
                } else {
                    callback();
                }
            };
            return {
                param: {
                    phone: '',
                    password: '',
                    repassword: '',
                    type:'01',
                    cid:null,
                    sno:''
                },
                imageUrl:'',
                imageUrl2:'',
                imageUrl3:'',
                rules: {
                    phone: [
                        { required: true, message: '请输入手机号', trigger: 'blur' },
                        { validator: validatePhone, trigger: 'change'}
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'blur' },
                        { min: 6, max: 20, message: '密码长度必须介于6和20之间', trigger: 'blur' }
                    ],
                    repassword: [
                        { required: true, message: '请输入确认密码', trigger: 'blur' },
                        { min: 6, max: 20, message: '密码长度必须介于6和20之间', trigger: 'blur' }
                    ],
                    cid: [
                        { required: true, message: '请选择班级', trigger: 'change' },
                    ],
                    sno: [
                        { required: true, message: '请输入学号', trigger: 'blur' },
                    ],
                },
                classList:[],
            }
        },
        created() {
            this.queryClass();
        },
        methods: {
            queryClass(){
                this.classList = [];
                this.$axios.post('/api/classes/frontAll',{}).then(res => {
                    for(var i in res.data.data){
                        this.classList.push({id:res.data.data[i].id+'',name:res.data.data[i].name});
                    }
                });
            },
            submitForm() {
                this.$refs.login.validate(valid => {
                    if (valid) {
                        this.param.cid = Number(this.param.cid)
                        this.$axios.post('/api/register', this.param).then(res => {
                            if (res.data.code === 200) {
                                this.$message.success('注册成功');
                                this.$router.push('/login');
                            } else
                                this.$message.error(res.data.msg);
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            handleExceed(files, fileList) {
                this.$message.warning(`当前限制1个文件`);
            },
        }
    };
</script>

<style scoped>
.login-wrap {
  position: relative;
  width: 100%;
  height: 100%;
  background-image: url('https://images.unsplash.com/photo-1606166325683-e6deb697d301?ixlib=rb-1.2.1&auto=format&fit=crop&w=2000&q=80');
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
:deep(.el-select .el-input__inner) {
  padding-left: 16px !important;
}

:deep(.el-select .el-input.is-focus .el-input__inner) {
  background: #fff;
  box-shadow: 0 0 0 2px #0066cc40;
}

:deep(.el-form-item.is-error .el-input__inner) {
  box-shadow: 0 0 0 2px rgba(255, 59, 48, 0.2);
}

:deep(.el-button--primary:focus, .el-button--primary:hover) {
  background: #0077ED;
  border-color: #0077ED;
}

/* 错误提示样式优化 */
:deep(.el-form-item__error) {
  padding-left: 15px;
  font-size: 13px;
  color: #ff3b30;
}

/* 输入框聚焦效果 */
:deep(.el-input__inner:focus) {
  border-color: #0071e3;
  background: #fff;
}
</style>