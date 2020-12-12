<template>
  <a-layout>
    <MyHeader></MyHeader>
  </a-layout>
<!--  <div class="video-page-root">-->
<!--    <div>-->
<!--      {{this.video_id}}-->
<!--    </div>-->
<!--    <template v-if="error_happened">-->
<!--      <a-result-->
<!--          status="warning"-->
<!--          title="视频加载失败"-->
<!--          sub-title="请确认该视频是否存在，或联系网站管理员"-->
<!--      >-->
<!--        <template #extra>-->
<!--          <a-button key="console" type="primary" @click="onGoHome">-->
<!--            回到主页-->
<!--          </a-button>-->
<!--        </template>-->
<!--      </a-result>-->
<!--    </template>-->
<!--  </div>-->
</template>

<script>
import MyHeader from "@/views/layout/myheader";

export default {
  components: {
    MyHeader,
  },
  name: "User",
  data: function () {
    return {
      error_happened: false,
      video_id: "",
    };
  },
  methods: {
    onGoHome() {
      this.$router.push('/index');
    }
  },
  watch: {
    $route(to, from) {
      this.video_id = to.params.id;
    }
  },
  created() {
    this.video_id = this.$route.params.id;
  }
}
</script>

<style scoped>

.video-page-root {
  padding-top: 16px;
  width: 75%;
  margin: 0 auto;
}

.video-info-top {
  margin-bottom: 8px;
}

.video-info-title{
  text-align: left;
  font-size: 22px;
  font-weight: bold;
}

.video-info-subtop {
  text-align: left;
  color: #888888;
}

.info-video-info, .info-author-info, .comments {
  margin-top: 8px;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 10, 10, 0.15);
  background-color: #fff;
}

.info {
  display: flex;
  justify-content: space-between;
  justify-items: center;
}

.info-video-info {
  width: 75%;
  margin-right: 4px;
  text-align: left;
  font-size: 16px;
  color: #888888;
}

.info-author-info {
  width: 25%;
  margin-left: 4px;
}

.author-nickname{
  margin: 8px;
  font-size: 16px;
}

.comment-title {
  margin-top: 16px;
  font-size: 18px;
  text-align: left;
  font-weight: bold;
}


</style>
