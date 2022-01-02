<template>
  <a-layout>
      <MySidebar head_index="2"/>
      <a-layout class="pbbml">
        <MyBread first="百科管理" second="角色信息"/>
        <RoleCollection/>
      </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb"
import RoleCollection from "@/components/manage/role"

export default {
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    RoleCollection
  },
};
</script>

<style>
.pbbml {
  background-color: #fff; 
  padding: 0 24px 24px;
}
</style>
