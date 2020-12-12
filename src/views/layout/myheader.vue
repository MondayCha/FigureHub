<template>
  <a-row type="flex" align="middle" class="myHeader" style="background: #fff">
    <a-col :span="2"></a-col>
    <a-col :span="2">
      <router-link to="/">
        <div class="logo">FigureHub</div>
      </router-link>
    </a-col>
    <a-col :span="4">
      <a-layout-header style="padding: 0; height: 50px; background: #fff">
        <a-menu
            id="gtcbml"
            theme="light"
            mode="horizontal"
            :default-selected-keys="[head_index]"
            :style="{ lineHeight: '50px', borderBottom: 'none' }"
        >
          <a-menu-item key="1" class="menu-font" style="padding: 0">
            <router-link to="/home">首页</router-link>
          </a-menu-item>
          <a-menu-item key="2" class="menu-font" style="padding: 0">
            <router-link to="/wiki">百科</router-link>
          </a-menu-item>
          <a-menu-item key="3" class="menu-font" style="padding: 0">
            <router-link to="/market">购物</router-link>
          </a-menu-item>
          <a-menu-item key="4" class="menu-font" style="padding: 0" v-if="this.$store.state.user.type===0">
            <router-link to="/manage">管理</router-link>
          </a-menu-item>
          <a-menu-item key="4" class="menu-font" style="padding: 0" v-else>
            <router-link to="/aboutus">关于</router-link>
          </a-menu-item>
        </a-menu>
      </a-layout-header>
    </a-col>
    <a-col span="3">
    </a-col>
    <a-col span="5">
      <a-input-search placeholder="Fate Stay Night" style="width: 300px; border: 0px" @search="onSearch"/>
    </a-col>
    <a-col :span="2">
    </a-col>
    <a-col :span="1">
      <div v-if="this.$store.state.logged_in">
        <div class="userdata">
          <template>
            <a-popover v-model="visible" :title="this.$store.state.user.nickname" trigger="hover"
                       style="border-radius: 16px;">
              <a slot="content" @click="user">
                <p>
                  <a-icon type="home" theme="filled"/>
                  个人主页
                </p>
              </a>
              <a slot="content" @click="hide">
                <p>
                  <a-icon type="setting" theme="filled"/>
                  管理中心
                </p>
              </a>
              <a slot="content" @click="logout">
                <p>
                  <a-icon type="right-circle" theme="filled"/>
                  退出账号
                </p>
              </a>
              <!--              <a-button shape="circle" icon="User"></a-button>-->
              <a-avatar :src="this.$store.state.user.avatar" style="cursor:pointer"/>
<!--              <a-avatar src="../"/>-->
<!--              <img src="../../static/backend/90140f22ea214b848edac43898d9150f.png"  alt="上海鲜花港 - 郁金香" />-->
            </a-popover>
          </template>
        </div>
      </div>
      <div v-else>
        <a-button icon="login" shape="round" @click="onLogin">
          登录
        </a-button>
      </div>
    </a-col>
    <a-col :span="4">
      <div v-if="this.$store.state.logged_in">
        <a-layout-header style="padding: 0; height: 50px; background: #fff">
          <a-menu
              id="person"
              theme="light"
              mode="horizontal"
              :default-selected-keys="[head_index]"
              :style="{ lineHeight: '50px', borderBottom: 'none' }"
          >
            <a-menu-item key="5" class="menu-font" style="padding: 0">
              <router-link to="/manage">收藏</router-link>
            </a-menu-item>
            <a-menu-item key="6" class="menu-font" style="padding: 0">
              <router-link to="/manage">订单</router-link>
            </a-menu-item>
            <a-menu-item key="7" class="menu-font" style="padding: 0">
              <router-link to="/manage"><b>发布</b></router-link>
            </a-menu-item>
          </a-menu>
        </a-layout-header>
      </div>
    </a-col>
  </a-row>
</template>

<script>
import axios_service from "@/api/request";

export default {
  name: "Header",
  props: {
    head_index: String,
  },
  data() {
    return {
      visible: false,
      nickName: "",
    };
  },
  methods: {
    onSearch(value) {
      if (value == null || value == "") {
        value = "Fate";
      }
      this.$router.push('/search/' + value);
    },
    hide() {
      this.$router.push('/home');
      this.visible = false;
    },
    logout() {
      axios_service.post_with_params(this.$store, "user/logout", null).then((res) => {
        this.$store.commit('logout');
        this.visible = false;
        this.$router.push('/login');
        this.$message.success("退出成功");
      });
    },
    user() {
      this.$router.push('/User/myspace');
      this.visible = false;
    },
    onLogin() {
      this.$router.push('/login');
    },
    change() {
      alert("aaa");
      this.$router.push({
        path: "/about",
        params,
      });
    },
  },
};
</script>

<style scoped>
.myHeader {
  padding: 0px;
  height: 50px;
  position: relative;
  -webkit-box-shadow: 0 1px 1px rgba(18, 18, 18, 0.1);
  box-shadow: #0002 0 1px 10px 1px;
  z-index: 10;
  max-width: 100%;
}

/*box-shadow: 0 1px 1px rgba(18, 18, 18, 0.1);*/


#gtcbml {
  height: 50px;
  background-color: #fff;
}

.menu-font {
  height: 50px;
  width: 60px;
  text-align: center;
}

.userdata {
  margin-left: 20px;
  color: #fb7299;
  font-size: small;
}

.logo {
  margin-left: 20px;
  font-size: 25px;
  font-family: myFont, Impact, Haettenschweiler, "Arial Narrow Bold", sans-serif;
  color: #fb7299;
  width: 100%;
}
</style>
