<template>
  <i v-if="isCollected" class="el-icon-star-on" @click="cancelCollection"></i>
  <i v-else class="el-icon-star-off" @click="submitCollection"></i>
</template>

<script>
import axios from 'axios';

export default {
  props: {//参数能否动态更新?
    user_id: Number,
    picture_id: Number,
    isCollected: Boolean,
  },

  data(){
    return {}
  },

  computed: {
    status: {
      get: function () {
        return this.isCollected;
      },

      set: function (value) {//覆盖怎么办?
        this.isCollected = value;
      }
    },
  },

  methods: {
    //由父组件触发
    updateStatus(inputStatus){
      this.status = inputStatus;
    },

    //判断当前点击触发的事件是添加收藏还是取消收藏
    judgeAction(){
      let _this = this;
      if(_this.status){
        //当前图片已被收藏，故点击事件为取消收藏
        _this.submitCollection();
      }else{
        //当前图片未被收藏，点击事件为收藏
        _this.cancelCollection();
      }
    },

    //添加收藏
    submitCollection() {
      let _this = this;
      let user_id = _this.$store.state.user.userID;
      console.log("正在添加收藏...");
      //0.对用户登录状态进行验证
      if(user_id < 0 ){
        this.$message({
          message: '添加收藏失败！请先登录',
          center: true,
          showClose: true,
          type: 'warning',
        });
        return ;
      }

      //1.axios发送post请求
      axios.post('/collections/add',{
        user_id: user_id,
        picture_id: _this.picture_id,
      }).then(function (response) {
        //2.更改当前状态为已收藏
        _this.status = true;
        console.log("添加收藏成功!");
      }).catch(function (error) {
        console.log(error);
      })

    },

    //取消收藏
    cancelCollection(){
      let _this = this;
      let user_id = _this.$store.state.user.userID;
      console.log("正在取消收藏...");
      if(user_id < 0 ){
        this.$message({
          message: '取消收藏失败！请先登录',
          center: true,
          showClose: true,
          type: 'warning',
        });
        return ;
      }
      axios.post('/collections/cancel',{
        user_id: user_id,
        picture_id: _this.picture_id,
      }).then(function (response) {
        _this.status = false;
        console.log("取消收藏成功!");
      }).catch(function (error) {
        console.log(error);
      })
    }
  },

  created() {//创建时将是否收藏的信息赋值给status
    this.status = this.isCollected;
  }
}
</script>

<style scoped>

</style>
