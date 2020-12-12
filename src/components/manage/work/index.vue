<template>
  <div>
    <div class="flextitle">
      <div>
        <a-button type="primary" @click="addItem" shape="round">添加</a-button>
      </div>
      <div v-if="false">
        <a-input-group style="width: 400px">
          <a-select default-value="0" style="width: 18%" @change="selectChange">
            <a-select-option value="0"> 名称</a-select-option>
            <a-select-option value="1"> 类别</a-select-option>
          </a-select>
          <a-input-search
              style="width: 82%"
              placeholder="请输入要搜索的关键词"
              allow-clear
              enter-button
              @search="searchModal"
          />
        </a-input-group>
      </div>
    </div>
    <collection-create-form
        ref="collectionForm"
        :visible="visible"
        @cancel="handleCancel"
        @create="handleCreate"
    />
    <div>
      <a-table
          bordered
          :pagination="pagination"
          :columns="columns"
          :data-source="data"
          :loading="loading"
          rowKey="workName"
      >
        <template slot="operation" slot-scope="text, record">
          <a-button type="link" @click="updateModal(record)">修改</a-button>
          <a-popconfirm
              v-if="data.length"
              title="确定要删除吗?"
              ok-text="确定"
              cancel-text="取消"
              @confirm="() => onDelete(record.workName)"
          >
            <a-button type="link" click="javascript:;">删除</a-button>
          </a-popconfirm>
        </template>
      </a-table>
      <update-form
          ref="updateForm"
          :visible="updatevisible"
          :recorder="updateRecorder"
          @cancel="updateCancel"
          @create="updateCreate"
      />
    </div>
  </div>
</template>

<script>
import CollectionCreateForm from "./form/createform.vue";
import UpdateForm from "./form/updateform.vue";
import UploadImageForm from "../uploadImageForm"
import axios from "axios";
import axios_service from "@/api/request";

export default {
  components: {
    CollectionCreateForm,
    UpdateForm,
    UploadImageForm,
  },
  data() {
    return {
      pagination: {
        defaultPageSize: 7,
        showTotal: (total) => `共${total}条数据`,
      },
      columns: [
        {
          title: "名称",
          dataIndex: "workName",
          key: "workName",
          width: "15%",
        },
        {
          title: "类别",
          dataIndex: "kindStr",
          key: "kindStr",
          width: "5%",
        },
        {
          title: "介绍",
          dataIndex: "intro",
          key: "intro",
          // width: "45%",
        },
        {
          title: "操作",
          width: "15%",
          dataIndex: "operation",
          scopedSlots: {
            customRender: "operation",
          },
        },
      ],
      data: [],
      visible: false,
      updatevisible: false,
      loading: false,
      searchType: 0,
      updateRecorder: {},
    };
  },
  methods: {
    formData() {
      for (let i = 0; i < this.data.length; i++) {
        let tmp_gender = this.data[i].kind;
        if (tmp_gender == 0) {
          this.data[i].kindStr = "动画";
        } else if (tmp_gender == 1) {
          this.data[i].kindStr = "漫画";
        } else if (tmp_gender == 2) {
          this.data[i].kindStr = "游戏";
        } else {
          this.data[i].kindStr = "小说";
        }
      }
    },
    selectChange(value) {
      this.searchType = value;
      console.log(this.searchType);
    },
    onCellChange(key, dataIndex, value) {
      const dataSource = [...this.dataSource];
      const target = dataSource.find((item) => item.key === key);
      if (target) {
        target[dataIndex] = value;
        this.dataSource = dataSource;
      }
    },
    onDelete(key) {
      console.log(key);
      axios_service.delete_with_params(this.$store, "/work/delete?workName=" + key, null).then((res) => {
        console.log(res);
        let _this = this;
        _this.loading = true;
        _this.queryTable();
      });
    },
    addItem() {
      console.log("show");
      this.visible = true;
    },
    searchModal(value) {
      this.$message.error("没写");
      return ;
      if (!value || value == "") {
        this.queryTable();
      } else {
        let params = {}
        let url = ""
        if (this.searchType == 0) {
          params = {roleName: value,};
          url = "/role/selectByName?";
        } else {
          let tmp_gender = "0";
          if (value == "女") {
            tmp_gender = "2";
          } else if (value == "男") {
            tmp_gender = "1";
          } else {
            tmp_gender = "0";
          }
          params = {gender: tmp_gender,};
          url = "/role/selectByGender?";
        }
        let _this = this;
        _this.loading = true;
        axios_service.get_with_params(this.$store, url, params).then((res) => {
          //将返回的数据存入页面中声明的data中
          _this.data = res;
          _this.formData();
          _this.loading = false;
        }).catch(function (error) {
          alert(error);
        });
      }
    },
    updateModal(record) {
      console.log("record is ", record);
      this.updateRecorder = record;
      this.updatevisible = true;
    },
    handleCancel() {
      this.visible = false;
    },
    updateCancel() {
      this.updatevisible = false;
    },
    updateCreate() {
      this.$message.error("后端可能有bug");
      return;
      const form = this.$refs.updateForm.form;
      form.validateFields((err, values) => {
        if (err) {
          return;
        }
        const params = {
          workName: values.workName,
          kind: values.kind,
          intro: values.intro,
        };
        axios_service.put_with_params(this.$store, "/work/update?", params).then((res) => {
          console.log(res);
          let _this = this;
          _this.loading = true;
          _this.queryTable();
        });
        form.resetFields();
        this.updatevisible = false;
      });
    },
    handleCreate() {
      const form = this.$refs.collectionForm.form;
      form.validateFields((err, values) => {
        if (err) {
          return;
        }
        console.log("Received values of form: ", values);
        const params = {
          workName: values.workName,
          kind: values.kind,
          intro: values.intro,
        };
        axios_service.post_with_params(this.$store, "/work/insert?", params).then((res) => {
          console.log(res);
          let _this = this;
          _this.loading = true;
          _this.queryTable();
        });
        form.resetFields();
        this.visible = false;
      });
    },
    queryTable() {
      let _this = this;
      _this.loading = true;
      axios_service.get_with_params(this.$store, "/work/selectAll", null).then((res) => {
        //将返回的数据存入页面中声明的data中
        _this.data = res;
        _this.formData();
        _this.loading = false;
      })
          .catch(function (error) {
            console.log("error case!");
            _this.$notification.open({
              message: "无法获取Role表格数据",
              icon: <a-icon type="warning" style="color: #ff1820"/>,
              description:
                  "请检查后端是否正常运行，是否允许跨域；或修改main.js中的axios全局参数，以匹配后端Api",
              duration: 10,
            });
          });
    },
  },
  created() {
    this.queryTable();
    console.log(this.data);
  },
};
</script>
<style>
.editable-cell {
  position: relative;
}

.editable-cell-input-wrapper,
.editable-cell-text-wrapper {
  padding-right: 24px;
}

.editable-cell-text-wrapper {
  padding: 5px 24px 5px 5px;
}

.editable-cell-icon,
.editable-cell-icon-check {
  position: absolute;
  right: 0;
  width: 20px;
  cursor: pointer;
}

.editable-cell-icon {
  line-height: 18px;
  display: none;
}

.editable-cell-icon-check {
  line-height: 28px;
}

.editable-cell:hover .editable-cell-icon {
  display: inline-block;
}

.editable-cell-icon:hover,
.editable-cell-icon-check:hover {
  color: #108ee9;
}

.editable-add-btn {
  margin-bottom: 8px;
}

.editable-row-operations a {
  margin-right: 8px;
}

.flextitle {
  margin: 0 0 20px 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
}
</style>
