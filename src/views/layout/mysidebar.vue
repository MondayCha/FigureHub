<template>
  <a-layout-sider
      width="200"
      breakpoint="lg"
      theme="light"
      collapsed-width="0"
      class="a-layout-sider"
  >
    <a-menu
        mode="inline"
        :default-selected-keys="[hIndex]"
        :default-open-keys="[openKey]"
        :style="{ height: '100%', borderRight: 0 }"
    >
      <a-sub-menu key="sub1" v-if="this.$store.state.logged_in && this.$store.state.user.type !== 1">
        <span slot="title"><a-icon type="smile"/>百科管理</span>
        <a-menu-item key="1">
          <router-link to="/manage/manufacturer">厂商信息</router-link>
        </a-menu-item>
        <a-menu-item key="2">
          <router-link to="/manage/role">角色信息</router-link>
        </a-menu-item>
        <a-menu-item key="3">
          <router-link to="/manage/figure">手办模型</router-link>
        </a-menu-item>
        <a-menu-item key="4">
          <router-link to="/manage/figure2role">手办角色</router-link>
        </a-menu-item>
        <a-menu-item key="5">
          <router-link to="/manage/work">作品信息</router-link>
        </a-menu-item>
        <!-- <a-menu-item key="4"> 手办表单 </a-menu-item> -->
      </a-sub-menu>
      <a-sub-menu key="sub2">
        <span slot="title"><a-icon type="pay-circle"/>手办交易</span>
        <a-menu-item key="6">
          <router-link to="/manage/order">我买到的</router-link>
        </a-menu-item>
        <a-menu-item key="7">
          <router-link to="/manage/ordersell">我卖出的</router-link>
        </a-menu-item>
        <a-menu-item key="8">
          <router-link to="/manage/ordersell">我发布的</router-link>
        </a-menu-item>
        <a-menu-item key="9" v-if="this.$store.state.user.type===0">
          <router-link to="/manage/all">交易管理</router-link>
        </a-menu-item>
      </a-sub-menu>
<!--      <a-sub-menu key="sub3">-->
<!--        <span slot="title"><a-icon type="gift"/>画个大饼</span>-->
<!--        <a-menu-item key="9"> 敬请期待</a-menu-item>-->
<!--        <a-menu-item key="10"> 敬请期待</a-menu-item>-->
<!--      </a-sub-menu>-->
<!--      <a-sub-menu key="sub4">-->
<!--        <span slot="title"><a-icon type="loading"/>正在加载</span>-->
<!--        <a-menu-item key="11"> 敬请期待</a-menu-item>-->
<!--        <a-menu-item key="12"> 敬请期待</a-menu-item>-->
<!--      </a-sub-menu>-->
    </a-menu>
  </a-layout-sider>
</template>

<script>
export default {
  name: "Sidebar",
  props: {
    head_index: String,
    openKey: 'sub1',
  },
  data() {
    return {
      hIndex: this.head_index
    }
  },
  beforeCreate() {

  },
  created() {
    // this.hIndex = this.head_index;
    if (this.hIndex <= 5) {
      this.openKey = 'sub1';
    } else if (this.hIndex <= 8) {
      this.openKey = 'sub2';
    } else {
      this.openKey = 'sub3';
    }
  }
};
</script>

<style>
.a-layout-sider {
  background: #fff;
}
</style>
