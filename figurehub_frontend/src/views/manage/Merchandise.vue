<template>
  <a-layout>
    <MySidebar head_index="8" />
    <a-layout id="pbbml" style="padding: 0 24px 24px">
      <MyBread first="手办交易" second="我发布的" />
      <MyCollection></MyCollection>
    </a-layout>
  </a-layout>
</template>
<script>

import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb";
import MyCollection from "@/components/manage/merchandise/index.vue";

export default {
  components: {
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
