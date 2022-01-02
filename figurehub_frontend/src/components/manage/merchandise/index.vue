<template>
  <div>
    <div class="flextitle">
    </div>
    <div>
      <a-table
          bordered
          :pagination="pagination"
          :columns="columns"
          :data-source="data"
          :loading="loading"
          rowKey="id"
      >
        <template slot="operation" slot-scope="text, record">
          <a-popconfirm
              v-if="data.length"
              title="确定要下架此商品吗?"
              ok-text="确定"
              cancel-text="取消"
              @confirm="() => onDelete(record.id)"
          >
            <a-button type="link" click="javascript:;">下架商品</a-button>
          </a-popconfirm>
        </template>
      </a-table>
    </div>
  </div>
</template>

<script>
import CollectionCreateForm from "./form/createform.vue";
import UpdateForm from "./form/updateform.vue";
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
        {
          title: "单号",
          dataIndex: "id",
          key: "dealId",
        },
        {
          title: "卖家ID",
          dataIndex: "user_id",
          key: "seller",
        },
        {
          title: "售价",
          dataIndex: "price",
          key: "price",
        },
        {
          title: "类型",
          dataIndex: "kind",
          key: "kind",
        },
        {
          title: "时间",
          dataIndex: "created_at",
          key: "createTime",
        },
        {
          title: "数量",
          dataIndex: "status",
          key: "status",
        },
        {
          title: "操作",
          dataIndex: "operation",
          scopedSlots: {
            customRender: "operation",
          },
        },
      ],
      data: [],
      visible: false,
      updatevisible: false,
      showvisible: false,
      loading: false,
      searchType: 0,
      updateRecorder: {},
    };
  },
  methods: {
    formData() {
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
      axios_service.delete_with_params(this.$store, "/merchandises/" + key, null).then((res) => {
        console.log(res);
        let _this = this;
        _this.loading = true;
        _this.$message.success("已取消订单");
        _this.queryTable();
      });
    },
    addItem() {
      console.log("show");
      this.visible = true;
    },
    commentModal(record) {
      console.log("record is ", record);
      this.updateRecorder = record;
      this.updatevisible = true;
    },
    confirmModal(record) {
      this.updateRecorder = record;
      this.visible = true;
    },
    handleCancel() {
      this.visible = false;
    },
    updateCancel() {
      this.updatevisible = false;
    },
    queryTable() {
      let _this = this;
      _this.loading = true;
      let query_url = this.$store.state.user.type === 0 ? '/merchandises' : '/select/merchandises';
      let query_params = this.$store.state.user.type === 0 ? null : {user_name: this.$store.state.user.userID};
      axios_service.get_with_params(this.$store, query_url, query_params).then((res) => {
        //将返回的数据存入页面中声明的data中
        console.log(res);
        _this.data = res;
        this.formData();
        _this.loading = false;
      })
          .catch(function (error) {
            console.log("error case!");
            _this.$notification.open({
              message: "无法获取表格数据",
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
