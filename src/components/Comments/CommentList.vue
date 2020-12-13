<template>
  <div class="comment-list-root">
    <template>
      <div class="unable-new-comment" v-if="!$store.state.logged_in">
        <a-comment>
          <a-avatar slot="avatar" icon="user"/>
          <div slot="content">
            <a-form-item>
              <a-textarea :rows="2" value="登录后方可评论" disabled/>
            </a-form-item>
            <a-form-item style="text-align: right">
              <a-button html-type="submit" type="primary" shape="round" disabled>
                新增评论
              </a-button>
            </a-form-item>
          </div>
        </a-comment>
      </div>
      <div class="new-comment" v-if="$store.state.logged_in && addModel === true">
        <a-comment>
          <a-avatar
              slot="avatar"
              :src="$store.state.user.avatar"
              :alt="$store.state.user.nickname"
              size="large"
          />
          <div slot="content">
            <a-form-item>
              <a-textarea v-model="comment_value" :rows="4" :allowClear="true"/>
            </a-form-item>
            <a-form-item style="text-align: left">
              <a-button html-type="submit" :loading="submitting" type="primary" shape="round" @click="handleSubmit">
                新增评论
              </a-button>
            </a-form-item>
          </div>
        </a-comment>
      </div>
    </template>

    <a-skeleton :paragraph="{rows:12}" :loading="loading" active>
      <div v-if="comment_list.length !== 0" class="comment-list">
        <div class="inner-container">
          <div v-for="item of current_list" v-bind:key="item.commentId" class="container-card">
            <a-divider/>
            <comment :comment_id="item.commentId" :comment_time="item.updateTime"
                     :comment_video="object_info.obj_id" :commenter="item.username" :content="item.content"
                     @delComment="onDelComment"
            ></comment>
          </div>
        </div>
        <a-pagination :default-current="1" :page-size="page_size" :total="comment_list.length"
                      @change="onPaginationChange"/>
      </div>

      <div v-if="comment_list.length === 0" class="comment-info">
        <a-empty :description="false"/>
        <span>暂无评论</span>
      </div>
    </a-skeleton>
  </div>
</template>

<script>
import api_service from "@/api/request";
import Comment from "@/components/Comments/Comment"


export default {
  name: "CommentList",
  components: {Comment},
  props: ['mode', 'video_id', 'ready', 'permission', 'object_info', 'addModel'],
  data: function () {
    return {
      page_size: 10,
      loading: true,
      comment_value: "",
      submitting: false,
      current_list: [],
      comment_list: [],
      current_page: 1,
    };
  },
  methods: {
    onPaginationChange(current) {
      if (this.comment_list.length === 0) {
        return;
      }
      this.current_page = current;
      let start = (this.current_page - 1) * this.page_size;
      let end = (this.current_page * this.page_size < this.comment_list.length) ?
          (this.current_page * this.page_size) : (this.comment_list.length);
      this.current_list = this.comment_list.slice(start, end);
    },
    update_comments() {
      let _this = this;
      let reURL = String
      if (this.object_info.obj_key === 'figureId') {
        reURL = "/comment/selectByFigureId?figureId=" + this.object_info.obj_id;
      }else if(this.object_info.obj_key === 'username') {
        reURL = "/comment/selectByUsername?username=" + this.object_info.obj_id;
      }
      api_service.get(reURL, null)
          .then((res) => {
            console.log(res);
            _this.comment_list = res;
            _this.onPaginationChange(this.current_page);
            _this.loading = false;
          })
          .catch((err) => {
            console.log(err);
            this.$message.error('评论获取失败');
            _this.loading = false;
            _this.comment_list = [];
          })
    },
    onDelComment(comment_id) {
      this.comment_list = this.comment_list.filter(item => (item.commentId !== comment_id));
      this.onPaginationChange(this.current_page);
    },
    handleSubmit() {
      if (this.comment_value === '') {
        this.$message.warning('请输入评论内容!');
        return false;
      }
      this.submitting = true;
      let _this = this;
      let reqURL = this.object_info.req_url + "insert?" + this.object_info.obj_key + "=" + this.object_info.obj_id;
      api_service.post_with_params(this.$store, reqURL, {content: this.comment_value})
          .then((res) => {
            _this.submitting = false;
            _this.$message.success('评论成功');
            _this.comment_value = ""
            _this.update_comments();
          })
          .catch((err) => {
            console.log(err);
            _this.submitting = false;
            _this.$message.error('评论失败');
          })

    }
  },
  watch: {
    ready: function (to, from) {
      if (to === true) {
        this.update_comments();
      }
    }
  },
  mounted() {
    if (this.ready === true) {
      this.update_comments();
    }
  }
}
</script>

<style scoped>
.container-card {
  /*border-top: 1px solid #dddddd;*/
}

.comment-list {
  text-align: center;
}

.comment-info {
  text-align: center;
}

.comment-list-root {
  padding: 20px;
  width: 100%;
}
</style>
