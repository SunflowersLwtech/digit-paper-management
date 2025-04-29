<template>
  <div>
    <div class="container">
      <!-- 搜索区域 -->
      <div class="handle-box">
        <el-select v-model="query.majorId" placeholder="选择专业" clearable class="handle-input mr10">
          <el-option v-for="item in majorList" :key="item.id" :label="item.name" :value="item.id"></el-option>
        </el-select>
        <el-select v-model="query.cid" placeholder="选择课程" clearable class="handle-input mr10">
          <el-option v-for="item in courseList" :key="item.id" :label="item.name" :value="item.id"></el-option>
        </el-select>
          <el-select v-model="query.ccid" placeholder="选择班级" clearable class="handle-input mr10" v-if="type!='03'">
              <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        <el-input v-model="query.title" placeholder="试卷标题" class="handle-input mr10"></el-input>
        <el-button type="primary" icon="el-icon-search" @click="getData">搜索</el-button>
        <el-button type="primary" icon="el-icon-plus" @click="handleAutoGenerate" v-if="type!=='03'">自动组卷</el-button>
        <el-button type="primary" icon="el-icon-upload" @click="handleUpload" v-if="type!=='03'">上传试卷</el-button>
      </div>

      <!-- 试卷列表 -->
      <el-table :data="tableData" border class="table">
        <el-table-column prop="title" label="试卷标题" align="center"></el-table-column>
        <el-table-column prop="courseName" label="课程名称" align="center"></el-table-column>
          <el-table-column prop="cname" label="班级名称" align="center"></el-table-column>
        <el-table-column prop="type" label="试卷类型" align="center">
            <template slot-scope="scope">
                <el-button  type="primary" size="mini" v-if="scope.row.type == '01'">自动生成</el-button>
                <el-button  type="warning" size="mini" v-if="scope.row.type == '02'">手动上传</el-button>
            </template>
        </el-table-column>
        <el-table-column prop="filePath" label="试卷预览/下载" align="center">
          <template slot-scope="scope">
            <el-button type="text" @click="previewExam(scope.row)">预览</el-button>
            <el-button type="text" @click="downloadExam(scope.row)">下载</el-button>
          </template>
        </el-table-column>
        <el-table-column prop="fileType" label="文件类型" align="center"></el-table-column>
        <el-table-column prop="status" label="状态" align="center">
            <template slot-scope="scope">
                <el-button  type="success" size="mini" v-if="scope.row.status == '01'">启用</el-button>
                <el-button  type="danger" size="mini" v-if="scope.row.status == '02'">禁用</el-button>
            </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" align="center" width="180"></el-table-column>
        <el-table-column label="操作" align="center" width="220" v-if="type!=='03'">
          <template slot-scope="scope">
            <el-button  type="primary" icon="el-icon-edit" size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div align="center">
        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[10, 20, 30, 40]"
            :page-size="pagesize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="totalCount">
        </el-pagination>
      </div>
      <!-- 分页器保持不变 -->

      <!-- 自动组卷对话框 -->
      <el-dialog title="自动组卷" :visible.sync="autoGenerateVisible" width="50%">
        <el-form :model="generateForm" :rules="generateRules" ref="generateForm" label-width="100px">
          <el-form-item label="试卷标题" prop="title">
            <el-input v-model="generateForm.title"></el-input>
          </el-form-item>
          <el-form-item label="所属课程" prop="cid">
            <el-select v-model="generateForm.cid" style="width: 100%">
              <el-option v-for="item in courseList" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
          </el-form-item>
            <el-form-item label="所属班级" prop="ccid">
                <el-select v-model="generateForm.ccid" multiple style="width: 100%">
                    <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                </el-select>
            </el-form-item>
          <el-form-item label="题目配置" prop="questionConfig">
            <div class="question-config">
              <div class="config-item">
                <span>选择题：</span>
                <el-input-number v-model="generateForm.choiceCount" :min="0" :max="20"></el-input-number>
                <span class="score-input">
                  分值：<el-input-number v-model="generateForm.choiceScore" :min="1" :max="100"></el-input-number>
                </span>
              </div>
              <div class="config-item">
                <span>填空题：</span>
                <el-input-number v-model="generateForm.fillCount" :min="0" :max="20"></el-input-number>
                <span class="score-input">
                  分值：<el-input-number v-model="generateForm.fillScore" :min="1" :max="100"></el-input-number>
                </span>
              </div>
              <div class="config-item">
                <span>简答题：</span>
                <el-input-number v-model="generateForm.essayCount" :min="0" :max="20"></el-input-number>
                <span class="score-input">
                  分值：<el-input-number v-model="generateForm.essayScore" :min="1" :max="100"></el-input-number>
                </span>
              </div>
            </div>
          </el-form-item>
        </el-form>
        <div slot="footer">
          <el-button @click="autoGenerateVisible = false">取 消</el-button>
          <el-button type="primary" @click="generateExam">生成试卷</el-button>
        </div>
      </el-dialog>

      <!-- 上传试卷对话框 -->
      <el-dialog title="上传试卷" :visible.sync="uploadVisible" width="40%">
        <el-form :model="uploadForm" :rules="uploadRules" ref="uploadForm" label-width="100px">
          <el-form-item label="试卷标题" prop="title">
            <el-input v-model="uploadForm.title"></el-input>
          </el-form-item>
          <el-form-item label="所属课程" prop="cid">
            <el-select v-model="uploadForm.cid" style="width: 100%">
              <el-option v-for="item in courseList" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
          </el-form-item>
            <el-form-item label="所属班级" prop="ccid">
                <el-select v-model="uploadForm.ccid" multiple style="width: 100%">
                    <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                </el-select>
            </el-form-item>
          <el-form-item label="试卷文件" prop="file">
            <el-upload
              class="upload-demo"
              :action="uploadUrl"
              :before-upload="beforeUpload"
              :on-success="handleUploadSuccess"
              :on-error="handleUploadError"
              :file-list="fileList">
              <el-button size="small" type="primary">点击上传</el-button>
              <div slot="tip" class="el-upload__tip">只能上传 pdf/jpg/png 文件</div>
            </el-upload>
          </el-form-item>
        </el-form>
        <div slot="footer">
          <el-button @click="uploadVisible = false">取 消</el-button>
          <el-button type="primary" @click="submitUpload">确 定</el-button>
        </div>
      </el-dialog>

      <!-- 预览对话框 -->
      <el-dialog 
        title="试卷预览" 
        :visible.sync="previewVisible" 
        width="90%" 
        :fullscreen="true"
        :before-close="handlePreviewClose">
        <div class="preview-container">
          <embed
            v-if="previewUrl"
            :src="previewUrl"
            type="application/pdf"
            class="preview-embed"
          />
        </div>
      </el-dialog>

      <!-- 编辑对话框 -->
      <el-dialog :title="dialogName" :visible.sync="dialogVisible" width="40%">
        <el-form :model="form" :rules="rules" ref="ruleForm" label-width="100px">
          <el-form-item label="试卷标题" prop="title">
            <el-input v-model="form.title"></el-input>
          </el-form-item>
          <el-form-item label="所属课程" prop="cid">
            <el-select v-model="form.cid" style="width: 100%">
              <el-option v-for="item in courseList" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
          </el-form-item>
            <el-form-item label="所属班级" prop="ccid">
                <el-select v-model="form.ccid" multiple style="width: 100%">
                    <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                </el-select>
            </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" style="width: 100%">
              <el-option label="启用" value="01"></el-option>
              <el-option label="禁用" value="02"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="save('ruleForm')">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
export default {
  name: "Exams",
  data() {
    return {
        query: {
            majorId: '',
            cid: '',
            title: ''
        },
        dialogName: '', 
        tableData: [],    // 所有的数据
        currentPage: 1,   // 当前的页码
        pagesize: 10,     // 每页显示的个数
        totalCount: 0,    // 总条数
        imageUrl: null,
        fileUrl: null,
        dialogVisible: false,
        form: {},
        rules: {
          title: [
              { required: true, message: '请输入试卷标题', trigger: 'blur' },
          ],
          cid: [
              { required: true, message: '请选择所属课程', trigger: 'blur' },
          ],
            ccid: [
                { required: true, message: '请选择所属班级', trigger: 'change' },
            ],
          type: [
              { required: true, message: '请输入试卷类型', trigger: 'blur' },
          ],
          filePath: [
              { required: true, message: '请输入文件路径', trigger: 'blur' },
          ],
          fileType: [
              { required: true, message: '请输入文件类型', trigger: 'blur' },
          ],
          status: [
              { required: true, message: '请输入状态', trigger: 'blur' },
          ],
        },
        courseList:[],
        classList:[],
        type:'',
        userInfo:{},
        majorList: [],
        autoGenerateVisible: false,
        uploadVisible: false,
        previewVisible: false,
        previewLoading: false,
        previewUrl: '',
        generateForm: {
            title: '',
            majorId: '',
            cid: '',
            choiceCount: 0,
            fillCount: 0,
            essayCount: 0,
            choiceScore: 5,
            fillScore: 10,
            essayScore: 15
        },
        uploadForm: {
            title: '',
            majorId: '',
            cid: '',
            filePath: ''
        },
        fileList: [],
        uploadUrl: '/api/file/imgUpload',
        generateRules: {
            title: [{ required: true, message: '请输入试卷标题', trigger: 'blur' }],
            majorId: [{ required: true, message: '请选择专业', trigger: 'change' }],
            cid: [{ required: true, message: '请选择课程', trigger: 'change' }],
            ccid: [{ required: true, message: '请选择班级', trigger: 'blur' }]
        },
        uploadRules: {
            title: [{ required: true, message: '请输入试卷标题', trigger: 'blur' }],
            majorId: [{ required: true, message: '请选择专业', trigger: 'change' }],
            cid: [{ required: true, message: '请选择课程', trigger: 'change' }],
            ccid: [{ required: true, message: '请选择班级', trigger: 'blur' }]
        },
        baseUrl: ''
    };
  },
  created() {
      this.type = this.common.get('type');
      this.userInfo = this.common.getUserInfo('userInfo');
      if(this.userInfo===null){
         this.$router.push('/');
      }
      this.getMajorList();
      this.querycourse();
      this.queryClass();
      this.getData();
      this.baseUrl = window.location.origin;
  },
  methods: {
      queryClass(){
          this.classList = [];
          this.$axios.post('/api/classes/queryAll',{}).then(res => {
              for(var i in res.data.data){
                  this.classList.push({id:res.data.data[i].id+'',name:res.data.data[i].name});
              }
          });
      },
    querycourse(){
        this.courseList = [];
        this.$axios.post('/api/course/queryAll',{}).then(res => {
            for(var i in res.data.data){
               this.courseList.push({id:res.data.data[i].id+'',name:res.data.data[i].majorName+"--"+res.data.data[i].name});
            }
         });
     },
    //实现文件上传功能
    httpFileRequest(item) {
        let App = this;
        let mf = new FormData();
        mf.append('file', item.file);
        this.$axios.post('/api/file/imgUpload',mf).then(res => {
              if (res.data.code == 200) {
                  this.$message.success({
                      title: '温馨提示：',
                      message: res.data.msg,
                  });
                  //将临时文件路径赋值给显示图片路径（前端显示的图片）
                  App.fileUrl ='https://sourl.cn/FNCQvL';
                  //将后台传来的数据库图片路径赋值给对象的图片路径
                  App.form.filePath = res.data.data;
              } else {
                  this.$message.error({title: '温馨提示：',message: res.data.msg});
              }
          });
     },
    //每页显示数据量变更
    handleSizeChange: function(val) {
        this.pagesize = val;
        this.getData();
    },
    //页码变更
    handleCurrentChange: function(val) {
        this.currentPage = val;
        this.getData();
    },
    //数据来源
    getData() {
        var param = {
            title: this.query.title, 
            pagesize: this.pagesize,  //每页显示的记录数
            majorId: this.query.majorId,
            cid: this.query.cid,
            ccid: this.type!='03'?this.query.ccid:this.userInfo.cid,
            status: this.type=='03'?'01':null,
            currentPage: this.currentPage, //页码
        };
        this.$axios.post('/api/exams/selectPage',param).then(res => {
            if(res.data.code == 200){
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.total;
            } else {
                this.$message.warning(res.data.msg);
            }
        });
    },
    // 编辑操作
    handleEdit(index, row) {
        this.form = JSON.parse(JSON.stringify(row));
        this.fileUrl = "https://sourl.cn/FNCQvL";
        this.querycourse();
        this.queryClass();
        this.form.cid = this.form.cid+'';
        //将2,3,6 转为 select多选的选中状态
        this.form.ccid = this.form.ccid.split(',');
        this.dialogVisible = true;   // 打开弹窗
        this.dialogName = "试卷编辑";
        // 确保表单已经渲染后再调用 clearValidate
        this.$nextTick(() => {
            if (this.$refs.ruleForm) {
                this.$refs.ruleForm.clearValidate();
            }
        });
    },
    // 新增操作
    handleAdd() {
        if (this.$refs.rulform !== undefined) this.$refs.rulform.resetFields();
        this.dialogVisible = true;   // 打开弹窗
        this.fileUrl = '';
        this.querycourse();
        this.form = {};
        this.$refs['ruleForm'].clearValidate();
        this.dialogName = "试卷新增";
    },
    // 保存操作，更新或新增调用
    save(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.form.ccid = this.form.ccid.join(',');
            this.$axios.post(this.form.id?'/api/exams/edit' : '/api/exams/add', this.form).then(res => {
              if(res.data.code == 200){  // 表示成功
                this.$message.success(res.data.msg);
                this.dialogVisible = false;
                this.getData();
              } else {
                this.$message.warning(res.data.msg);  //错误信息
              }
            })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
    },
    // 删除操作
    handleDelete(index, row) {
        this.$confirm('确定要删除吗？', '提示', {
           type: 'warning'
        }).then(() => {
             this.$axios.get('/api/exams/deleteById?id='+row.id).then(res => {
                if(res.data.code == 200){// 操作成功
                    this.$message.success(res.data.msg);
                    this.tableData.splice(index, 1);
                    this.getData();
            }else{
              this.$message.warning(res.data.msg);
            }
          });
        }).catch(() => {
        })
    },
    // 获取专业列表
    getMajorList() {
        this.majorList = [];
        this.$axios.post('/api/major/queryAll',{}).then(res => {
            for(var i in res.data.data){
               this.majorList.push({id:res.data.data[i].id+'',name:res.data.data[i].name});
            }
         });
    },
    // 专业变更时获取对应课程
    handleMajorChange(majorId) {
        if (!majorId) {
            this.courseList = [];
            return;
        }
        this.$axios.get(`/api/course/listByMajor/${majorId}`).then(res => {
            if (res.data.code === 200) {
                this.courseList = res.data.data;
            }
        });
    },
    // 打开自动组卷对话框
    handleAutoGenerate() {
        this.querycourse();
        this.autoGenerateVisible = true;
        if (this.$refs.generateForm) {
            this.$refs.generateForm.resetFields();
        }
    },
    // 生成试卷
    generateExam() {
        this.$refs.generateForm.validate(valid => {
            if (valid) {
                const totalCount = this.generateForm.choiceCount + this.generateForm.fillCount + this.generateForm.essayCount;
                if (totalCount === 0) {
                    this.$message.warning('请至少选择一种题型');
                    return;
                }
                this.generateForm.ccid = this.generateForm.ccid.join(',');
                this.$axios.post('/api/exams/generateExam', this.generateForm).then(res => {
                    if (res.data.code === 200) {
                        this.$message.success('试卷生成成功');
                        this.autoGenerateVisible = false;
                        this.getData();
                    } else {
                        this.generateForm.ccid = this.generateForm.ccid.split(',');
                        this.$message.error(res.data.msg);
                    }
                });
            }
        });
    },
    // 打开上传对话框
    handleUpload() {
        this.uploadVisible = true;
        this.fileList = [];
        if (this.$refs.uploadForm) {
            this.$refs.uploadForm.resetFields();
        }
    },
    // 上传前检查
    beforeUpload(file) {
        const isValidType = ['application/pdf', 'image/jpeg', 'image/png'].includes(file.type);
        if (!isValidType) {
            this.$message.error('只能上传 PDF/JPG/PNG 格式文件!');
            return false;
        }
        return true;
    },
    // 上传成功回调
    handleUploadSuccess(res, file) {
        if (res.code === 200) {
            this.uploadForm.filePath = res.data;
            this.$message.success('文件上传成功');
        } else {
            this.$message.error(res.msg);
        }
    },
    // 上传失败回调
    handleUploadError() {
        this.$message.error('文件上传失败');
    },
    // 提交上传表单
    submitUpload() {
        this.$refs.uploadForm.validate(valid => {
            if (valid) {
                if (!this.uploadForm.filePath) {
                    this.$message.warning('请先上传文件');
                    return;
                }
                const params = {
                    ...this.uploadForm,
                    type: '02', // 手动上传
                    fileType: this.uploadForm.filePath.split('.').pop().toLowerCase(),
                    status: '01' // 默认启用
                };
                params.ccid = params.ccid.join(',');
                this.$axios.post('/api/exams/add', params).then(res => {
                    if (res.data.code === 200) {
                        this.$message.success('试卷上传成功');
                        this.uploadVisible = false;
                        this.getData();
                    } else {
                        this.$message.error(res.data.msg);
                    }
                });
            }
        });
    },
    // 预览试卷
    previewExam(row) {
        if(row.type == '01'){
            this.previewVisible = true;
        // 添加 #toolbar=1 参数以显示PDF工具栏
        this.previewUrl = `${this.baseUrl}/api/exams/preview/${row.id}?t=${new Date().getTime()}#toolbar=1&navpanes=1&scrollbar=1`;
        }else{
            window.open(`${row.filePath}`, '_blank');
        }
    },
    // 下载试卷
    async downloadExam(row) {
      try {
        // 创建一个隐藏的 a 标签
        const link = document.createElement('a');
        link.style.display = 'none';
        
        // 设置下载链接
        link.href = `${this.baseUrl}/api/exams/download/${row.id}`;
        
        // 设置文件名
        link.download = `${row.title}.pdf`;
        
        // 添加到页面并触发点击
        document.body.appendChild(link);
        link.click();
        
        // 清理 DOM
        document.body.removeChild(link);
      } catch (error) {
        this.$message.error('下载失败：' + error.message);
      }
    },
    // 关闭预览
    handlePreviewClose() {
        this.previewVisible = false;
        this.previewUrl = '';
    }
  }
}
</script>

<style scoped>
    .handle-box {
         margin-bottom: 20px;
     }
    .handle-input {
         width: 300px;
         display: inline-block;
     }
    .table {
         width: 100%;
         font-size: 14px;
     }
    .mr10 {
         margin-right: 10px;
     }
    .table-td-thumb {
         display: block;
         margin: auto;
         width: 40px;
         height: 40px;
     }
    .avatar-uploader .el-upload {
         border: 1px dashed #d9d9d9;
         border-radius: 6px;
         cursor: pointer;
         position: relative;
         overflow: hidden;
     }
    .avatar-uploader .el-upload:hover {
         border-color: #eeab1e;
     }
    .avatar-uploader-icon {
         font-size: 28px;
         color: #8c939d;
         width: 178px;
         height: 178px;
         line-height: 178px;
         text-align: center;
     }
    .avatar {
         width: 100% !important;
         height: 178px;
         display: block;
     }
    .video-js .vjs-icon-placeholder {
         width: 80%;
         height: 80%;
         display: block;
     }
    ::v-deep .el-upload--text{
         width: 100px !important;
         height: 100px !important;
     }
    .avatar-uploader-icon {
         font-size: 28px;
         color: #8c939d;
         width: 100px;
         height: 100px;
         line-height: 100px;
         text-align: center;
     }
    .avatar {
         width: 100px !important;
         height: 100px;
         display: block;
     }
    .question-config {
        padding: 10px;
        border: 1px solid #DCDFE6;
        border-radius: 4px;
    }
    .config-item {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    .config-item:last-child {
        margin-bottom: 0;
    }
    .score-input {
        margin-left: 20px;
    }
    .preview-container {
        height: calc(100vh - 120px);
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f0f2f5;
        padding: 10px;
    }
    .preview-embed {
        width: 100%;
        height: 100%;
        border: none;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    }
    /* 优化对话框样式 */
    ::v-deep .el-dialog__body {
        padding: 10px;
        /* height: calc(100vh - 120px); */
    }
    ::v-deep .el-dialog__header {
        padding: 15px 20px;
    }
</style>