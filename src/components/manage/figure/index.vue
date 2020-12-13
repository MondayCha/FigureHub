<template>
  <div>
    <div class="flextitle">
      <div>
        <a-button type="primary" @click="addItem" shape="round">添加</a-button>
      </div>
      <div>
        <a-input-group style="width: 400px">
          <a-select default-value="0" style="width: 18%" @change="selectChange">
            <a-select-option value="0"> 名称</a-select-option>
            <a-select-option value="1"> 类型</a-select-option>
            <a-select-option value="2"> 价格</a-select-option>
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
          rowKey="figureId"
      >
        <template slot="operation" slot-scope="text, record">
          <a-button type="link" @click="updateModal(record)">修改</a-button>
          <a-button type="link" @click="uploadModal(record)">传图</a-button>
          <a-popconfirm
              v-if="data.length"
              title="确定要删除吗?"
              ok-text="确定"
              cancel-text="取消"
              @confirm="() => onDelete(record.figureId)"
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
      <upload-image-form
          ref="uploadForm"
          :visible="uploadvisible"
          :recorder="uploadRecorder"
          @cancel="uploadCancel"
          @create="uploadCreate"
      />
    </div>
  </div>
</template>

<script>
import CollectionCreateForm from "./form/createform.vue";
import UpdateForm from "./form/updateform.vue";
import UploadImageForm from "../uploadImageForm";
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
          dataIndex: "figureName",
          key: "figureName",
        },
        {
          title: "类型",
          dataIndex: "figureTypeStr",
          key: "figureTypeStr",
          width: "10%",
        },
        {
          title: "价格",
          dataIndex: "price",
          key: "price",
          width: "10%",
        },
        {
          title: "比例",
          dataIndex: "prop",
          key: "prop",
          width: "10%",
        },
        {
          title: "厂商",
          dataIndex: "manuName",
          key: "manuName",
          width: "10%",
        },
        {
          title: "操作",
          width: "20%",
          dataIndex: "operation",
          scopedSlots: {
            customRender: "operation",
          },
        },
      ],
      data: [],
      roleData: [],
      visible: false,
      updatevisible: false,
      loading: false,
      searchType: 0,
      updateRecorder: {},
      uploadRecorder: {},
      uploadTime: 0,
      uploadvisible: false,
    };
  },
  methods: {
    formData(){
      let _this = this;
      for (let i = 0; i < _this.data.length; i++) {
        let tmp_gender = _this.data[i].figureType;
        let tmp_role = _this.data[i].figureId;
        if (tmp_gender == 1) {
          _this.data[i].figureTypeStr = "GK手办";
        } else if (tmp_gender == 2) {
          _this.data[i].figureTypeStr = "PVC手办";
        } else if (tmp_gender == 3) {
          _this.data[i].figureTypeStr = "可动手办";
        } else if (tmp_gender == 4) {
          _this.data[i].figureTypeStr = "景品手办";
        } else if (tmp_gender == 5) {
          _this.data[i].figureTypeStr = "粘土人";
        } else {
          _this.data[i].figureTypeStr = "未知";
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
      let _this = this;
      axios_service.delete_with_params(_this.$store, "/figure/delete?figureId=" + key, null).then((res) => {
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
      if (!value || value === "") {
        this.queryTable();
      } else {
        let params = {}
        let url = ""
        console.log(this.searchType);
        if (this.searchType == 0) {
          params = {figureName: value,};
          url = "/figure/selectByName?";
        }else if(this.searchType == 1){
          params = {figureType: value,};
          url = "/figure/selectByType?";
        }else{
          params = {price: value,};
          url = "/figure/selectByPrice?";
        }
        let _this = this;
        _this.loading = true;
        axios_service.get_with_params(_this.$store, url, params).then((res) => {
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
      this.updateRecorder = record;
      this.updatevisible = true;
    },
    uploadModal(record) {
      this.uploadvisible = true;
      this.uploadRecorder = record;
    },
    uploadCreate() {
      let formList = this.$refs.uploadForm.fileList;
      const uid = this.uploadRecorder.figureId.toString();
      this.uploadTime = formList.length;
      console.log("image");
      console.log(formList[0]);
      this.axios_upload(0, uid, formList).then(() => {
        this.$refs.uploadForm.fileList = [];
        this.uploadvisible = false;
      });
    },
    axios_upload(index, uid, formList) {
      if (index == formList.length) {
        return;
      }
      let _this = this;
      return axios_service.post_with_file(this.$store, "/figureimg/insert?figureId=" + uid, null, formList[index].originFileObj).then((res) => {
        return _this.axios_upload(index + 1, uid, formList);
      });
    },
    uploadCancel() {
      this.uploadvisible = false;
    },
    handleCancel() {
      this.visible = false;
    },
    updateCancel() {
      this.updatevisible = false;
    },
    updateCreate() {
      const form = this.$refs.updateForm.form;
      form.validateFields((err, values) => {
        if (err) {
          return;
        }
        const params = {
          figureId: values.figureId,
          figureName: values.figureName,
          figureType: values.figureType,
          price: values.price,
          prop: values.prop,
        };
        console.log("update test ", values);
        let _this = this;
        axios_service.put_with_params(_this.$store, "/figure/update?", params).then((res) => {
              console.log(res);
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
        let params = {
          figureName: values.figureName,
          figureType: values.figureType,
          price: values.price,
          prop: values.prop,
        };
        let _this = this;
        axios_service.post_with_params(_this.$store, "/figure/insert?", params).then((res) => {
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
      axios_service.get_with_params(_this.$store, "/figure/selectAll", null).then((res) => {
        //将返回的数据存入页面中声明的data中
        console.log(res);
        _this.data = res;
        _this.formData();
        _this.loading = false;
      })
          .catch((err) => {
            console.log("error case!");
            console.log(err);
            _this.$notification.open({
              message: "无法获取GK表格数据",
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
