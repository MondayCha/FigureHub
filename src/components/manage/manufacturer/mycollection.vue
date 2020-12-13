<template>
  <div>
    <div class="flextitle">
      <div>
        <a-button type="primary" @click="showModal" shape="round">添加</a-button>
      </div>
      <div>
        <a-input-group style="width: 400px">
          <a-select default-value="0" style="width: 18%" @change="selectChange">
            <a-select-option value="0"> 名称</a-select-option>
            <a-select-option value="1"> 主页</a-select-option>
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
          rowKey="manuId"
      >
        <template slot="operation" slot-scope="text, record">
          <a-button type="link" @click="updateModal(record)">修改</a-button>
          <a-popconfirm
              v-if="data.length"
              title="确定要删除吗?"
              ok-text="确定"
              cancel-text="取消"
              @confirm="() => onDelete(record.manuId)"
          >
            <a href="javascript:;">删除</a>
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
import axios from "axios";
import axios_service from "@/api/request";

export default {
  components: {
    CollectionCreateForm,
    UpdateForm,
  },
  data() {
    return {
      pagination: {
        defaultPageSize: 7,
        showTotal: (total) => `共${total}条数据`,
      },
      columns: [
        // {
        //   title: "编号",
        //   dataIndex: "manuId",
        //   key: "manuId",
        //   width: "10%",
        // },
        {
          title: "厂商名称",
          dataIndex: "manuName",
          key: "manuName",
          width: "20%",
        },
        {
          title: "厂商主页",
          dataIndex: "manuLink",
          key: "manuLink",
          width: "55%",
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
      axios_service.delete_with_params(this.$store, "/manufacturer/delete?manuId=" + key, null).then((res) => {
        console.log(res);
        let _this = this;
        _this.loading = true;
        _this.queryTable();
      });
    },
    showModal() {
      console.log("show");
      this.visible = true;
    },
    searchModal(value) {
      if (!value || value == "") {
        console.log("search undefined");
        this.queryTable();
      } else if (this.searchType == 0) {
        console.log("searchType 0");
        const params = {
          manuName: value,
        };
        console.log(params);
        let _this = this;
        _this.loading = true;
        axios_service.get_with_params(this.$store, "/manufacturer/selectByName?", params).then((res) => {
              //将返回的数据存入页面中声明的data中
              _this.data = res;
              _this.loading = false;
            })
            .catch(function (error) {
              alert(error);
            });
      } else {
        console.log("searchType 1");
        const params = {
          manuLink: value,
        };
        console.log(params);
        let _this = this;
        _this.loading = true;
        axios_service.get_with_params(this.$store, "/manufacturer/selectByLink?", params).then((res) => {
              //将返回的数据存入页面中声明的data中
              _this.data = res;
              _this.loading = false;
            })
            .catch(function (error) {
              alert(error);
            });
      }
    },
    updateModal(record) {
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
      console.log("update up");
      const form = this.$refs.updateForm.form;
      form.validateFields((err, values) => {
        if (err) {
          return;
        }
        let params = {
          manuId: values.manuId,
          manuName: values.manuName,
          manuLink: values.manuLink,
        };
        axios_service.put_with_params(this.$store, "/manufacturer/update?", params).then((res) => {
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
        let params = {
          manuName: values.manuName,
          manuLink: values.manuLink,
        };
        axios_service.post_with_params(this.$store, "/manufacturer/insert?", params).then((res) => {
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
      console.log("init");
      let _this = this;
      _this.loading = true;
      axios_service.get_with_params(this.$store, "/manufacturer/selectAll", null).then((res) => {
            //将返回的数据存入页面中声明的data中
            _this.data = res;
            _this.loading = false;
          })
          .catch(function (error) {
            console.log("error case!");
            _this.$message.error("无法获取表格数据");
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
