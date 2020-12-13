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
          rowKey="dealId"
      >
        <template slot="operation" slot-scope="text, record">
          <a-popconfirm
              v-if="data.length"
              title="确定要取消此交易吗?"
              ok-text="确定"
              cancel-text="取消"
              @confirm="() => onDelete(record.dealId)"
          >
            <a-button type="link" click="javascript:;">删除订单</a-button>
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
          dataIndex: "dealId",
          key: "dealId",
          width: "5%",
        },
        {
          title: "买家",
          dataIndex: "buyer",
          key: "buyer",
          width: "10%",
        },
        {
          title: "手办名称",
          dataIndex: "figureName",
          key: "figureName",
          width: "40%",
        },
        {
          title: "时间",
          dataIndex: "createTime",
          key: "createTime",
          width: "15%",
        },
        {
          title: "状态",
          dataIndex: "statusStr",
          key: "statusStr",
          width: "5%",
        },
        {
          title: "操作",
          width: "10%",
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
      for (let i = 0; i < this.data.length; i++) {
        let tmp_gender = this.data[i].status;
        if (tmp_gender == 2) {
          this.data[i].statusStr = "已完成";
        } else if (tmp_gender == 1) {
          this.data[i].statusStr = "待评价";
        } else {
          this.data[i].statusStr = "待收货";
        }
      }
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
      axios_service.delete_with_params(this.$store, "/deal/delete?dealId=" + key, null).then((res) => {
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
      axios_service.get_with_params(this.$store, "/deal/selectBySeller?seller=" + this.$store.state.user.userID, null).then((res) => {
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
