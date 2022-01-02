<template>
  <div class="comment-root" style="text-align: left;">
    <div>
      <a-modal
          title="确认删除？"
          :visible="showDelete"
          :confirm-loading="deleteLoading"
          @ok="handleDelOk"
          @cancel="handleDelCancel"
      >
        <p>此操作不可撤销</p>
      </a-modal>
    </div>
    <a-comment>
      <template slot="actions">
        <div>
          <a-icon type="delete" class="comment-action" @click="deleteComment"
                  v-if="$store.state.logged_in && this.$store.state.user.userID == this.commenter"/>
        </div>
      </template>

      <a slot="author" @click="gotoAuthor(comment_creator)">{{ comment_creator.nickname }}</a>
      <a-avatar
          @click="gotoAuthor(comment_creator)"
          slot="avatar"
          :src="this.$global.staticURL+comment_creator.imgpath"
          :alt="comment_creator.nickname"
      />
      <div slot="content">
        {{ content }}
      </div>
      <a-tooltip slot="datetime" :title="moment(comment_time).format('YYYY-MM-DD HH:mm:ss')">
        <span>{{ moment(comment_time).fromNow() }}</span>
      </a-tooltip>
    </a-comment>
  </div>
</template>

<script>
import moment from "moment";
import api_service from "@/api/request";
import axios_service from "@/api/request";

export default {
  name: "Comment",
  // components: {VideoCard},
  props: ['comment_id', 'figure_id', 'commenter', 'comment_video', 'comment_time', 'content',],
  data: function () {
    return {
      comment_creator: {},
      replaced_content: "",
      showDelete: false,
      deleteLoading: false,
      moment,
      likeStatus: false,
      likeNum: -1,
    };
  },
  methods: {
    deleteComment() {
      this.showDelete = true;
    },
    handleDelOk(e) {
      this.deleteLoading = true;
      let _this = this;
      api_service.delete_with_params(this.$store, `/figures/${this.figure_id}/comments/${this.comment_id}`)
          .then((res) => {
            _this.showDelete = false;
            _this.deleteLoading = false;
            this.$message.success('评论删除成功');
            this.$emit('delComment', this.comment_id);
          })
          .catch((err) => {
            _this.showDelete = false;
            _this.deleteLoading = false;
            this.$error({
              title: '出错了',
              content: h => <div>评论删除失败</div>,
              onOk() {
              },
            });
          })
    },
    handleDelCancel(e) {
      this.showDelete = false;
    },
    handleEditCancel(e) {
      this.showEdit = false;
    },
    gotoAuthor(author) {
      this.$router.push("/user/" + author.username.toString())
    }
  },
  created() {
    api_service.get("users/" + this.commenter)
        .then((res) => {
          console.log("comment card is " + res)
          this.comment_creator = res;
        })
  }
}
</script>

<style scoped>
.pinkIcon {
  color: #fb7299;
}

.comment-action {
  margin: 0px 8px 0px 0px;
}

</style>
