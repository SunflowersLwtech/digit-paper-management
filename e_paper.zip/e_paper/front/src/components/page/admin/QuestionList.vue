<template>
    <div>
      <div class="container">
        <!-- 搜索和操作区域 -->
        <div class="handle-box">
          <el-input v-model="query.content" placeholder="请输入题目内容" class="handle-input mr10"></el-input>
          <el-select v-model="query.type" placeholder="题目类型" clearable class="mr10">
            <el-option label="选择题" value="01"></el-option>
            <el-option label="填空题" value="02"></el-option>
            <el-option label="简答题" value="03"></el-option>
          </el-select>
          <el-button type="primary" icon="el-icon-search" @click="getData">搜索</el-button>
          <el-button type="primary" icon="el-icon-plus" @click="handleAdd">添加题目</el-button>
        </div>
  
        <!-- 题目列表 -->
        <el-table :data="tableData" border class="table" ref="multipleTable">
          <el-table-column type="selection" width="55" align="center"></el-table-column>
          <el-table-column prop="courseName" label="课程名称"></el-table-column>
          <el-table-column prop="type" label="题目类型" width="100">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.type === '01'" type="primary">选择题</el-tag>
              <el-tag v-if="scope.row.type === '02'" type="success">填空题</el-tag>
              <el-tag v-if="scope.row.type === '03'" type="warning">简答题</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="content" label="题目内容" min-width="200"></el-table-column>
          <el-table-column prop="options" label="选项" min-width="200">
            <template slot-scope="scope">
              <template v-if="scope.row.type === '01'">
                <div v-for="(value, key) in JSON.parse(scope.row.options || '{}')" :key="key">
                  {{ key }}: {{ value }}
                </div>
              </template>
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column prop="answer" label="答案" min-width="150"></el-table-column>
          <el-table-column label="操作" width="180" align="center">
            <template slot-scope="scope">
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="handleEdit(scope.row)">编辑</el-button>
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDelete(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
  
        <!-- 分页器 -->
        <div class="pagination">
          <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="query.currentPage"
            :page-sizes="[10, 20, 50, 100]"
            :page-size="query.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
          </el-pagination>
        </div>
      </div>
  
      <!-- 添加/编辑题目对话框 -->
      <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="60%" @close="resetForm">
        <el-form :model="form" :rules="rules" ref="form" label-width="100px">
          <el-form-item label="所属课程" prop="cid">
            <el-select v-model="form.cid" placeholder="请选择课程" style="width: 100%">
              <el-option
                v-for="item in courseList"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
  
          <el-form-item label="题目类型" prop="type">
            <el-select v-model="form.type" placeholder="请选择题目类型" @change="handleTypeChange" style="width: 100%">
              <el-option label="选择题" value="01"></el-option>
              <el-option label="填空题" value="02"></el-option>
              <el-option label="简答题" value="03"></el-option>
            </el-select>
          </el-form-item>
  
          <el-form-item label="题目内容" prop="content">
            <el-input type="textarea" v-model="form.content" :rows="3" placeholder="请输入题目内容"></el-input>
          </el-form-item>
  
          <!-- 选择题选项 -->
          <template v-if="form.type === '01'">
            <el-form-item label="选项" prop="optionsList">
              <div v-for="(item, index) in optionsList" :key="index" class="option-item">
                <el-input v-model="item.value" :placeholder="`选项${item.key}内容`">
                  <template slot="prepend">{{ item.key }}</template>
                </el-input>
                <el-button type="text" class="delete-btn" @click="removeOption(index)" 
                           v-if="optionsList.length > 2">删除</el-button>
              </div>
              <el-button type="text" @click="addOption" v-if="optionsList.length < 6">
                <i class="el-icon-plus"></i> 添加选项
              </el-button>
            </el-form-item>
  
            <el-form-item label="正确答案" prop="selectedAnswers">
              <el-checkbox-group v-model="selectedAnswers">
                <el-checkbox v-for="item in optionsList" :key="item.key" :label="item.key">
                  选项{{ item.key }}
                </el-checkbox>
              </el-checkbox-group>
            </el-form-item>
          </template>
  
          <!-- 填空题和简答题答案 -->
          <el-form-item label="答案" prop="answer" v-else>
            <el-input type="textarea" v-model="form.answer" :rows="3" 
                      :placeholder="form.type === '02' ? '请输入填空题答案' : '请输入简答题答案'"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
              <el-option label="启用" value="01"></el-option>
              <el-option label="禁用" value="02"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveQuestion">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </template>
  
  <script>
  export default {
    name: 'Question',
    data() {
      return {
          type:'',
          userInfo:{},
        query: {
          content: '',
          type: '',
          currentPage: 1,
          pageSize: 10
        },
        total: 0,
        tableData: [],
        dialogVisible: false,
        dialogTitle: '添加题目',
        courseList: [],
        form: {
          cid: '',
          type: '',
          content: '',
          answer: '',
          status: '01'
        },
        optionsList: [
          { key: 'A', value: '' },
          { key: 'B', value: '' }
        ],
        selectedAnswers: [],
        rules: {
          cid: [{ required: true, message: '请选择所属课程', trigger: 'change' }],
          type: [{ required: true, message: '请选择题目类型', trigger: 'change' }],
          content: [{ required: true, message: '请输入题目内容', trigger: 'blur' }],
          selectedAnswers: [{
            validator: (rule, value, callback) => {
              if (this.form.type === '01' && (!this.selectedAnswers || this.selectedAnswers.length === 0)) {
                callback(new Error('请选择正确答案'));
              } else {
                callback();
              }
            }, 
            trigger: 'change' 
          }]
        }
      }
    },
    created() {
        this.type = this.common.get('type');
        this.userInfo = this.common.getUserInfo('userInfo');
        if(this.userInfo===null){
            this.$router.push('/');
        }
      this.getData();
      this.getCourseList();
    },
    methods: {
      // 获取课程列表
        getCourseList() {
            this.courseList = [];
            this.$axios.post('/api/course/queryAll',{}).then(res => {
                for(var i in res.data.data){
                    this.courseList.push({id:res.data.data[i].id+'',name:res.data.data[i].majorName+"--"+res.data.data[i].name});
                }
            });
        },
  
      // 获取题目列表
      getData() {
        const params = {
          content: this.query.content,
          type: this.query.type,
          pagesize: this.query.pageSize,
          currentPage: this.query.currentPage
        };
        this.$axios.post('/api/question/selectPage', params).then(res => {
          if (res.data.code === 200) {
            this.tableData = res.data.data.list;
            this.total = res.data.data.total;
          }
        });
      },
  
      // 处理题目类型变更
      handleTypeChange(val) {
        this.form.answer = '';
        this.selectedAnswers = [];
        if (val === '01') {
          this.optionsList = [
            { key: 'A', value: '' },
            { key: 'B', value: '' }
          ];
        }
      },
  
      // 添加选项
      addOption() {
        const keys = ['A', 'B', 'C', 'D', 'E', 'F'];
        if (this.optionsList.length < keys.length) {
          this.optionsList.push({
            key: keys[this.optionsList.length],
            value: ''
          });
        }
      },
  
      // 删除选项
      removeOption(index) {
        this.optionsList.splice(index, 1);
        // 更新已选答案
        this.selectedAnswers = this.selectedAnswers.filter(answer => 
          this.optionsList.some(option => option.key === answer)
        );
      },
  
      // 新增题目
      handleAdd() {
        this.dialogTitle = '添加题目';
        this.dialogVisible = true;
        this.form = {
          type: '',
          content: '',
          answer: '',
          status: '01'
        };
        this.optionsList = [
          { key: 'A', value: '' },
          { key: 'B', value: '' }
        ];
        this.selectedAnswers = [];
      },
  
      // 编辑题目
      handleEdit(row) {
        this.dialogTitle = '编辑题目';
        this.form = JSON.parse(JSON.stringify(row));
        this.dialogVisible = true;
  
        if (row.type === '01' && row.options) {
          const options = JSON.parse(row.options);
          this.optionsList = Object.entries(options).map(([key, value]) => ({
            key,
            value
          }));
          this.selectedAnswers = row.answer.split('');
        }
      },
  
      // 保存题目
      saveQuestion() {
        this.$refs.form.validate(valid => {
          if (valid) {
            const formData = { ...this.form };
  
            if (formData.type === '01') {
              // 验证选项是否填写完整
              const emptyOption = this.optionsList.find(item => !item.value.trim());
              if (emptyOption) {
                this.$message.warning('请填写完整的选项内容');
                return;
              }
              // 验证是否选择答案
              if (this.selectedAnswers.length === 0) {
                this.$message.warning('请选择正确答案');
                return;
              }
              // 处理选择题数据
              const optionsObj = {};
              this.optionsList.forEach(item => {
                optionsObj[item.key] = item.value;
              });
              formData.options = JSON.stringify(optionsObj);
              formData.answer = this.selectedAnswers.sort().join('');
            }
  
            const url = formData.id ? '/api/question/edit' : '/api/question/add';
            this.$axios.post(url, formData).then(res => {
              if (res.data.code === 200) {
                this.$message.success(res.data.msg);
                this.dialogVisible = false;
                this.getData();
              } else {
                this.$message.error(res.data.msg);
              }
            });
          }
        });
      },
  
      // 删除题目
      handleDelete(row) {
        this.$confirm('确认删除该题目?', '提示', {
          type: 'warning'
        }).then(() => {
          this.$axios.get(`/api/question/deleteById?id=${row.id}`).then(res => {
            if (res.data.code === 200) {
              this.$message.success('删除成功');
              this.getData();
            } else {
              this.$message.error(res.data.msg);
            }
          });
        }).catch(() => {});
      },
  
      // 重置表单
      resetForm() {
        if (this.$refs.form) {
          this.$refs.form.resetFields();
        }
        this.form = {
          cid: '',
          type: '',
          content: '',
          answer: '',
          status: '01'
        };
        this.optionsList = [
          { key: 'A', value: '' },
          { key: 'B', value: '' }
        ];
        this.selectedAnswers = [];
      },
  
      handleSizeChange(val) {
        this.query.pageSize = val;
        this.getData();
      },
  
      handleCurrentChange(val) {
        this.query.currentPage = val;
        this.getData();
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
  
  .mr10 {
    margin-right: 10px;
  }
  
  .option-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }
  
  .option-item .el-input {
    margin-right: 10px;
  }
  
  .delete-btn {
    color: #f56c6c;
  }
  
  .pagination {
    margin-top: 20px;
    text-align: right;
  }
  </style> 