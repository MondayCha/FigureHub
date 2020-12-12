<template>
  <a-layout>
      <MySidebar head_index="3"/>
      <a-layout class="pbbml">
        <MyBread first="百科管理" second="手办模型"/>
        <GCollection/>
      </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb";
import GCollection from "@/components/manage/figure"

export default {
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    GCollection
  },
};
</script>

<style>
.pbbml {
  background-color: #fff; 
  padding: 0 24px 24px;
}
</style>
