<template>
  <a-layout>
      <MySidebar head_index="1" />
      <a-layout id="pbbml" style="padding: 0 24px 24px">
        <MyBread first="百科管理" second="厂商信息" />
        <MyCollection></MyCollection>
    </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb";
import MyCollection from "@/components/manage/manufacturer/mycollection.vue";

export default {
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    MyCollection,
  },
};
</script>

<style>
.space-class {
  margin-bottom: 0px;
}

#pbbml {
  background-color: #fff;
}
</style>
