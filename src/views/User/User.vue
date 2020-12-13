<template>
  <a-layout style="background-color: #fff">
    <MyHeader></MyHeader>
    <a-layout style="background-color: #ffffff;">
      <a-row :gutter="20" style="margin-left: 10%; margin-right: 10%; margin-top: 40px; margin-bottom: 10%">
        <a-col :span="2">
        </a-col>
        <a-col :span="20">
          <div class="info">
            <div class="info-with-avatar">
              <div class="basic-info">
                <a-descriptions title="用户信息"
                                :column="{ xxl: 4, xl: 3, lg: 3, md: 3, sm: 2, xs: 1 }"
                                :colon="false"
                >
                  <a-descriptions-item label="昵称" class="dstrong">
                    {{ user.nickname }}
                  </a-descriptions-item>
                  <a-descriptions-item label="用户名" class="dstrong">
                    {{ user.username }}
                  </a-descriptions-item>
                  <a-descriptions-item label="用户类型" class="dstrong">
                    <template v-if="user.type == '1'">
                      <a-tag color="orange">注册用户</a-tag>
                    </template>
                    <template v-else-if="user.type == '0'">
                      <a-tag color="green">管理员</a-tag>
                    </template>
                    <template v-else="user.type == '1'">
                      <a-tag color="purple">厂商用户</a-tag>
                    </template>
                  </a-descriptions-item>
                </a-descriptions>
              </div>
              <a-avatar class="info-avatar" shape="circle" :size="120" :src="this.$global.staticURL + user.imgpath"/>
            </div>

            <div class="user-actions">
              <a-tabs default-active-key="1" @change="tabChangeCallback">
                <a-tab-pane key="1" tab="用户评论">
                  <CommentList
                      :object_info="this_object_info"
                      :ready="true"
                      :add-model="false"
                  ></CommentList>
                </a-tab-pane>
                <a-tab-pane key="2" tab="用户收藏">
                  <CollectList></CollectList>
                </a-tab-pane>
              </a-tabs>
            </div>
          </div>
        </a-col>
        <a-col :span="2">
        </a-col>
      </a-row>
    </a-layout>
  </a-layout>
</template>

<script>
import MyHeader from "@/views/layout/myheader";
import axios_service from "@/api/request";
import CommentList from "@/components/Comments/CommentList"
import CollectList from "@/components/Collect/Collect"

const payment_info = {
  amount: 98,
  content: "升级高级会员",
  payment_type: "membership",
  video_id: 0,
};

export default {
  components: {
    MyHeader,
    CommentList,
    CollectList,
  },
  name: "User",
  data: function () {
    return {
      payment_info: payment_info,
      user_id: "",
      user: {
        username: String,
        nickname: String,
        type: 1,
        imgpath: String,
      },
      error_happened: false,
      buyMembershipShow: false,
      current_tab: 1,
      this_object_info: {
        req_url: 'comment/',
        obj_key: 'username',
        obj_id: String,
      }
    };
  },
  methods: {
    onGoHome() {
      this.$router.push("/index")
    },
    updatePage() {
      let _this = this;
      axios_service.get("user/selectByUsername?username=" + this.user_id, null)
          .then((res) => {
            _this.error_happened = false;
            _this.user = res;
          })
          .catch((err) => {
            _this.error_happened = true;
          })

    },
    buyMembership() {
      this.buyMembershipShow = true;
    },
    cancelPayment() {
      this.buyMembershipShow = false;
    },
    tabChangeCallback(key) {
      this.current_tab = key;
    }
  },
  // watch: {
  //   $route(to, from) {
  //     if (to.params.router_user_id) {
  //       this.user_id = to.params.router_user_id;
  //       this.updatePage();
  //     }
  //   }
  // },
  beforeMount() {
    if (this.$route.params.id) {
      this.user_id = this.$route.params.id;
      this.error_happened = false;
    } else {
      this.user_id = this.$store.state.user.userID;
      return;
    }
    this.this_object_info.obj_id = this.user_id;
    this.updatePage();
  },
  watch: {
    $route(to, from) {
      this.user_id = to.params.id;
      if (!this.user_id) {
        this.user_id = this.$store.state.user.userID;
      }
      this.this_object_info.obj_id = this.user_id;
      this.updatePage();
    }
  },
  created() {
    this.user_id = this.$route.params.id;
    if (!this.user_id) {
      this.user_id = this.$store.state.user.userID;
    }
    this.this_object_info.obj_id = this.user_id;
    this.updatePage();
  }
}
</script>

<style scoped>
/deep/ .ant-descriptions-item-label {
  font-weight: bold;
  color: rgba(0, 0, 0, 0.5);
}

.info {
  background-color: #ffffff;
  margin-left: 64px;
  margin-right: 64px;
}

.info-with-avatar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.basic-info {
  text-align: left;
  width: 80%;
  padding: 16px;
  box-shadow: 0 4px 8px 0 #0001;

  background-color: #fff;
  border-radius: 8px;
}

.info-avatar {
  background-color: #fff;
  box-shadow: 0 4px 8px 0 #0001;
}

.user-actions {
  box-shadow: 0 1px 4px rgba(0, 10, 10, 0.15);
  padding: 16px 24px;
  background-color: #fff;
  border-radius: 8px;
  margin: 16px 0px 0px;
}

.upgrade-button {
  padding: 0;
}
</style>
