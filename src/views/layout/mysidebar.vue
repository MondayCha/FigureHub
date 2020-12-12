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
      :default-selected-keys="[head_index]"
      :default-open-keys="['sub1']"
      :style="{ height: '100%', borderRight: 0 }"
    >
      <a-sub-menu key="sub1">
        <span slot="title"
          ><a-icon type="smile" />
          <router-link to="/manage">百科管理</router-link>
        </span>
        <a-menu-item key="1"><router-link to="/manage">厂商信息</router-link></a-menu-item>
        <a-menu-item key="2"><router-link to="/manage/role">角色信息</router-link></a-menu-item>
        <a-menu-item key="3"><router-link to="/manage/figure">手办模型</router-link></a-menu-item>
        <a-menu-item key="4"><router-link to="/manage/figure2role">手办角色</router-link></a-menu-item>
        <!-- <a-menu-item key="4"> 手办表单 </a-menu-item> -->
      </a-sub-menu>
      <a-sub-menu key="sub2">
        <span slot="title"><a-icon type="pay-circle" />二手交易</span>
        <a-menu-item key="5"> 敬请期待 </a-menu-item>
        <a-menu-item key="6"> 敬请期待 </a-menu-item>
        <a-menu-item key="7"> 敬请期待 </a-menu-item>
        <a-menu-item key="8"> 敬请期待 </a-menu-item>
      </a-sub-menu>
      <a-sub-menu key="sub3">
        <span slot="title"><a-icon type="gift" />画个大饼</span>
        <a-menu-item key="9"> 敬请期待 </a-menu-item>
        <a-menu-item key="10"> 敬请期待 </a-menu-item>
      </a-sub-menu>
      <a-sub-menu key="sub4">
        <span slot="title"><a-icon type="loading" />正在加载</span>
        <a-menu-item key="11"> 敬请期待 </a-menu-item>
        <a-menu-item key="12"> 敬请期待 </a-menu-item>
      </a-sub-menu>
    </a-menu>
  </a-layout-sider>
</template>

<script>
export default {
  name: "Sidebar",
  props: {
    head_index: String,
  },
};
</script>

<style>
.a-layout-sider {
  background: #fff;
}
</style>
