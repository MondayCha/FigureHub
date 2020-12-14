<template>
  <a-layout style="background: transparent">
    <MyHeader head_index="2"></MyHeader>
    <template v-if="this.displayType === 0">
      <div class="s-skin-container"></div>
      <a-row :gutter="20" style="margin-left: 10%; margin-right: 10%; margin-top: 40px; margin-bottom: 10%">
        <a-col :span="4">
        </a-col>
        <a-col :span="16">
          <MyBread first="百科" second="手办"></MyBread>
          <div class="wiki-left-block">
            <div>
              <div class="wiki-picture-board">
                <a-carousel autoplay>
                  <div v-for="iu in imageURLs" style="display: table-cell">
                    <img :src="iu.url" class="img-style">
                  </div>
                </a-carousel>
              </div>
              <!--            <div style="margin-top: 10px; text-align: right">-->
              <!--              <a-icon type="heart" style="font-size: 30px"/>-->
              <!--            </div>-->
              <div style="margin-top: 20px; padding-left: 20px; text-align: left">
                <div class="h1title">
                  {{ this.$store.state.wiki_name }}
                </div>
              </div>
            </div>
            <div class="card-div">
              <CommentList
                  :object_info="this_object_info"
                  :ready="true"
                  :add-model="true"
              ></CommentList>
            </div>
          </div>
        </a-col>
        <a-col :span="4">
        </a-col>
      </a-row>
    </template>
    <template v-else-if="this.displayType === 1">

    </template>
  </a-layout>
</template>

<script>
import MyHeader from "../layout/myheader";
import CommentList from '@/components/Comments/CommentList'
import axios_service from "@/api/request";
import MyBread from "../layout/mybreadcrumb";

export default {
  components: {
    MyHeader, CommentList, MyBread
  },
  data: function () {
    return {
      imageURLs: [],
      displayType: 0,
      id: String,
      this_object_info: {
        req_url: 'comment/',
        obj_key: 'figureId',
        obj_id: '25',
      },
    }
  },
  watch: {
    $route(to, from) {
      this.id = to.params.wiki_id;
      if (to.params.wiki_type === 'manu') {
        this.displayType = 1;
      } else {
        this.displayType = 0;
      }
      console.log("wiki id is ", this.id);
      this.updatePage();
    }
  },
  created() {
    this.id = this.$route.params.wiki_id;
    if (this.$route.params.wiki_type === 'manu') {
      this.displayType = 1;
    } else {
      this.displayType = 0;
    }
    console.log("create wiki id is ", this.id);
    this.updatePage();
  },
  methods: {
    updatePage() {
      this.imageURLs = [],
      this.this_object_info.obj_id = this.id;
      axios_service.get("figureimg/selectByFigureId?figureId=" + this.id,null).then((res) => {
        console.log("ggfffffffffff", res);
        for (let i = 0; i < res.length; i++) {
          this.imageURLs.push({'url': this.$global.staticURL + res[i].imgpath});
        }
      })
    },
  }
};
</script>

<style lang="css" scoped="">
/deep/ .ant-row {
  background: transparent;
}

.s-skin-container {
  position: fixed;
  _position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  min-width: 1000px;
  z-index: -10;
  background-color: #ffffff;
  /*background-image: url("../../static/picture/golden-flower.jpg");*/
  background-position: center 0;
  background-repeat: no-repeat;
  background-size: cover;
  -webkit-background-size: cover;
  -o-background-size: cover;
  zoom: 1;
  animation: anim 25s linear infinite;
}

@keyframes anim {
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}

.wiki-left-block {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px 0 #0001;
  background: #ffffff;
}

.wiki-picture-board{
  border-radius: 20px;
}

.img-style{
  height: 100%;
  width: 100%;
}

.h1title {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  color: #181818;
  -webkit-box-orient: vertical;
  font-size: 22px;
  font-weight: bold;
  padding: 0px 12px 0;
  overflow: hidden;
  text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
  /*white-space: nowrap;*/
  /*!*文本不自动换行*!*/
  justify-self: stretch;
  text-overflow: ellipsis;
}


</style>
