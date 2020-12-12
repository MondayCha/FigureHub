<template>
  <a-layout>
    <MyHeader head_index="4"></MyHeader>
<!--    <template v-if="this.$store.state.user.type===1">-->
<!--      <a-result-->
<!--          status="warning"-->
<!--          title="权限不足"-->
<!--          sub-title="如需访问，请联系网站管理员"-->
<!--          style="background-color: #ffffff; padding-top: 200px"-->
<!--      >-->
<!--        <template #extra>-->
<!--          <a-button key="console" type="primary" @click="onGoHome" shape="round">-->
<!--            回到主页-->
<!--          </a-button>-->
<!--        </template>-->
<!--      </a-result>-->
<!--    </template>-->
<!--    <template v-else>-->
      <a-layout class="a-layout">
        <router-view />
      </a-layout>
<!--    </template>-->
  </a-layout>
</template>
<script>
import MyHeader from "./layout/myheader";
import MySidebar from "./layout/mysidebar";
import MyBread from "./layout/mybreadcrumb";
import MyCollection from "@/components/manage/manufacturer/mycollection.vue";

export default {
  components: {
    MyHeader,
    MySidebar,
    MyBread,
    MyCollection,
  },
  methods:{
    onGoHome() {
      this.$router.push("/")
    },
  },
};
</script>

<style>
.a-layout {
  padding-right: 20px;
  height: 700px;
  background-color: #ffffff;
}
</style>
