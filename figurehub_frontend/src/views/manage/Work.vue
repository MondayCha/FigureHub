<template>
  <a-layout>
    <MySidebar head_index="5"/>
    <a-layout class="pbbml">
      <MyBread first="百科管理" second="作品信息"/>
      <WorkCollection/>
    </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb"
import WorkCollection from "@/components/manage/work"

export default {
  name: 'Work',
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    WorkCollection
  },
};
</script>

<style>
.pbbml {
  background-color: #fff;
  padding: 0 24px 24px;
}
</style>
