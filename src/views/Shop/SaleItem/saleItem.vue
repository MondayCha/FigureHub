<template>
  <a-layout style="background-color: #ffffff">
    <MyHeader head_index="3"></MyHeader>
    <a-row :gutter="20" style="margin-left: 10%; margin-right: 10%; margin-top: 40px; margin-bottom: 10%">
      <a-col :span="16">
        <div class="sale-left-block">
          <div>
            <div class="sale-picture-board">
              <a-carousel autoplay>
                <div style="max-width: 100%; overflow: hidden"><img
                    src="http://localhost:2333/ImgStore/LIGHT%20Insanae.jpg"></div>
                <div style="max-width: 100%; overflow: hidden"><img
                    src="http://localhost:2333/ImgStore/LIGHT%20Insanae.jpg"></div>
              </a-carousel>
            </div>
            <!--            <div style="margin-top: 10px; text-align: right">-->
            <!--              <a-icon type="heart" style="font-size: 30px"/>-->
            <!--            </div>-->
            <div style="margin-top: 30px; padding-left: 5px; text-align: left">
              <div class="h1title">
                {{ this.$store.state.sale.title }}
              </div>
              <div style="margin-top: 12px">
                <a-tag v-for="(content,index) in tagContent" :key="index"
                       style="margin-right: 5px">{{ content }}
                </a-tag>
                <!--          <span>这里可根据关键词索引</span>-->
              </div>
              <div class="usertext" style="margin-top: 10px">
                2020年5月24日下午5点49分
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
      <a-col :span="8">
        <div class="grid-conten">
          <div>
            <a-card shadow="always">
              <div style="display: flex; flex-direction: row;">
                <div style=" width: 90px">
                  <dpi-img :src="this.$store.state.sale.owner_url"
                           class="el-avatar el-avatar--circle"
                           style="height: 80px; width: 80px"
                           @click="skipToPainterPage"></dpi-img>
                </div>
                <!--      个人介绍-->
                <div style="margin-left: 20px">
                  <div class="username">{{ this.$store.state.sale.owner }}</div>
                  <!--                  <div class="useraddress">北京</div>-->
                  <!--                  <div class="usertext">Twitter@matchachWeibo@抹茶專門店AM Glad to see u and always be happy to make friends-->
                  <!--                    with u~ thx to all the u friendly to me!!(　′?｀) (ps.If u want chat with me,use en)...-->
                  <!--                  </div>-->
                </div>
              </div>
              <a-button type="primary" shape="round" class="button" @click="viewHomePage">查看主页</a-button>
              <a-button type="primary" @click="handleBuy">
                购买
              </a-button>
              <a-modal
                  v-model="modalVisible"
                  title="订单"
                  centered
                  width="1000px"
              >
                <template slot="footer">
                  <a-button v-if="current < steps.length - 1" type="primary" @click="next" :disabled="disable">
                    下一步
                  </a-button>
                  <a-button
                      v-if="current === steps.length - 1"
                      type="primary"
                      @click="buyDone"
                  >
                    完成
                  </a-button>
                </template>
                <a-steps :current="current">
                  <a-step v-for="item in steps" :key="item.title" :title="item.title"/>
                </a-steps>
                <div class="steps-content">
                  <template v-if="current === 0">
                    <div style="margin-top: 100px; margin-bottom: 100px; margin-left: 250px">
                      <font style="font-size:20px">用户名： {{ this.$store.state.user.nickname }}</font>
                      <br>
                      <font style="font-size:20px">游戏名： </font>
                      <br>
                      <font style="font-size:20px">价格 ： ￥</font>
                    </div>
                  </template>
                  <template v-if="current === 1">
                    <div style="margin-top: 10px">
                      <font style="font-size:15px">订单号：</font>
                    </div>
                    <div style="text-align: center">
                      <img src="" style="width:300px; height: 300px; margin-top: 20px">
                      <br>
                      <font style="font-size:30px">￥</font>
                    </div>
                  </template>
                  <template v-if="current === 2">
                    <div style="margin-top: 100px; margin-bottom: 100px">
                      <div style="text-align: center">
                        <a-icon type="loading" style="font-size: 100px"/>
                      </div>
                      <p style="text-align: center; margin-top: 30px">
                        <font style="font-size: 20px">确认支付结果中...</font>
                      </p>
                    </div>
                  </template>
                  <template v-if="current === 3">
                    <div style="margin-top: 100px; margin-bottom: 100px; margin-left: 250px">
                      <font style="font-size:20px">订单号：</font>
                      <br>
                      <font style="font-size:20px">用户名：</font>
                      <br>
                      <font style="font-size:20px">游戏名：</font>
                      <br>
                      <font style="font-size:20px">支付额： ￥</font>
                      <br>
                      <font style="font-size:20px">下单时间：</font>
                      <br>
                      <font style="font-size:20px">订单状态： 已完成</font>
                    </div>
                  </template>
                </div>
              </a-modal>
            </a-card>

            <a-card shadow="always" style="margin-top: 15px">
              <div class="useraddress" style="margin-bottom: 15px">
                其他作品
              </div>
              <!--              <div>-->
              <!--                <a-row :gutter="2" style="margin-top: 10px; margin-bottom: 10px">-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                </a-row>-->
              <!--                <a-row :gutter="2" style="margin-top: 10px; margin-bottom: 10px">-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                  <a-col :span="8"><img src="http://localhost:2333/ImgStore/spike%E5%A4%B4%E5%83%8F1.jpg"-->
              <!--                                        class="asideImg"/></a-col>-->
              <!--                </a-row>-->
              <!--              </div>-->
            </a-card>
          </div>
        </div>
      </a-col>
    </a-row>
  </a-layout>
</template>

<script>
import MyHeader from "@/views/layout/myheader";
import CommentList from '@/components/Comments/CommentList'
import dpiImg from '@/views/dpi-img'
import axios_service from "@/api/request";

export default {
  name: "saleItem",
  components: {
    MyHeader,
    CommentList,
    dpiImg
  },
  props: ['prop_sale_id'],
  data: function () {
    return {
      current: 0,
      disable: false,
      steps: [
        {
          title: '确认订单',
          content: '确认'
        },
        {
          title: '付款',
          content: '付款'
        },
        {
          title: '确认支付结果',
          content: ''
        },
        {
          title: '订单结果',
          content: '结果'
        }
      ],
      modalVisible: false,
      tagContent: ["咒术回战", "五条悟", "无量空处", "DM袋喵"],
      this_object_info: {
        req_url: 'comment/',
        obj_key: 'figureId',
        obj_id: '25',
      },
      sale_id: "",
      user: {},
      error_happened: false,
      buyMembershipShow: false,
      current_tab: 1,
    };
  },
  watch: {
    $route(to, from) {
      if (to.params.sale_id) {
        this.sale_id = to.params.sale_id;
        this.updatePage();
      }
    }
  },
  beforeMount() {
    if (this.prop_sale_id) {
      this.sale_id = this.prop_sale_id;
      this.this_object_info.obj_id = this.$store.state.sale.figure_id;
      this.error_happened = false;
    } else if (this.$route.params.sale_id) {
      this.sale_id = this.$route.params.sale_id;
      this.this_object_info.obj_id = this.$store.state.sale.figure_id;
      this.error_happened = false;
    } else {
      this.error_happened = true;
      return;
    }
  },
  methods: {
    viewHomePage() {
      this.$router.push('/user/' + this.$store.state.sale.owner_id)
    },
    changeStatus() {
      this.current++
      this.disable = false
    },
    next() {
      this.current++
      if (this.current === 1) {
        axios_service.post_with_params(this.$store, "deal/insert?", {
          'status': 0,
          'seller': this.$store.state.sale.owner_id,
          'merchandiseId': this.$store.state.sale.merchandise_id,
        }).then((response) => {
          console.log(response.data);
        }).catch((e) => {
          this.$notification.error({
            message: '购买失败',
          })
          this.disable = true
          this.current--
        })
      }
      if (this.current === 2) {
        this.disable = true;
        axios_service.get("deal/selectByMerchandiseId?merchandiseid=" + this.$store.state.sale.merchandise_id).then((res) => {
          setTimeout(() => {
            this.disable = false;
            this.current++;
            this.$message.success("支付成功!")
          }, 2000);
        }).catch((err) => {
          this.disable = true;
        })
      }
    },
    buyDone() {
      this.$message.success('购买成功');
      this.modalVisible = false
      this.current = 0
    },
    handleBuy() {
      this.modalVisible = true;
    }
  }
}
</script>

<style scoped>
.sale-left-block {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px 0 #0001;
}

.sale-picture-board {
  border-radius: 20px;

}

.h1title {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-size: 22px;
  font-weight: bold;
  padding: 3px 12px 0;
  overflow: hidden;
  text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
  white-space: nowrap;
  /*文本不自动换行*/
  justify-self: stretch;
  text-overflow: ellipsis;
}

.ant-carousel >>> .slick-slide {
  text-align: center;
  height: 450px;
  line-height: 160px;
  overflow: hidden;
}
</style>

