<template>
  <a-layout>
    <MyHeader head_index="2"></MyHeader>
    <a-layout style="background-color: #ffffff;">
      <a-row :gutter="20" style="margin-left: 10%; margin-right: 10%; margin-top: 40px; margin-bottom: 10%">
        <a-col :span="2">
        </a-col>
        <a-col :span="20">
      <WikiMain></WikiMain>
        </a-col>
        <a-col :span="2">
        </a-col>
      </a-row>
    </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import WikiMain from "./wikimain";

export default {
  name: 'wiki',
  components: {
    MyHeader,WikiMain
  },
  data() {
    return {
    }
  },
};
</script>

<style>
.back {
  background-color: #ffffff;
}
</style>
