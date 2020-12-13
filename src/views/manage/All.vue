<template>
  <a-layout>
    <MySidebar head_index="8"/>
    <a-layout class="pbbml">
      <MyBread first="手办交易" second="交易管理"/>
      <OrderSellCollection/>
    </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import MySidebar from "../layout/mysidebar";
import MyBread from "../layout/mybreadcrumb"
import OrderSellCollection from "@/components/manage/Order"

export default {
  name: 'Work',
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    OrderSellCollection
  },
};
</script>

<style>
.pbbml {
  background-color: #fff;
  padding: 0 24px 24px;
}
</style>
