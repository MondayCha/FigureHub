<template>
  <a-layout style="background-color: #ffffff">
    <MyHeader head_index="3"></MyHeader>
    <a-row :gutter="20" style="margin-left: 10%; margin-right: 10%; margin-top: 40px; margin-bottom: 10%">
      <a-col :span="1">
      </a-col>
      <a-col :span="16">
        <div class="sale-left-block">
          <div>
            <div class="sale-picture-board">
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
              <a-row type="flex" justify="space-between" align="top">
                <a-col :span="17">
                  <div class="h1title">
                    {{ this.$store.state.sale.title }}
                  </div>
                  <div class="tagdiv">
                    <a-tag v-for="(tag,index) in tagContent" :key="index"
                           :color="tag.color" @click="clickTag(tag.content, tag.url)">{{ tag.content }}
                    </a-tag>
                  </div>
                </a-col>
                <a-col :span="7">
                  <div style="padding-left: 25px">
                    <a-space>
                      <a-button size="large" type="primary" icon="heart" shape="circle" @click="collect"/>
                      <a-button size="large" style="background-color: #00a0d8; color: #fff" shape="round"
                                @click="handleBuy">
                        <b>购买￥{{ this.$store.state.sale.price }}</b></a-button>
                    </a-space>
                  </div>
                </a-col>
              </a-row>
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
      <a-col :span="6">
        <div class="grid-conten">
          <div>
            <div style="padding: 25px">
              <div style="display: flex; flex-direction: row;">
                <div style=" width: 90px">
                  <dpi-img :src="this.$store.state.sale.owner_url"
                           class="el-avatar el-avatar--circle"
                           style="height: 80px; width: 80px"></dpi-img>
                </div>
                <!--      个人介绍-->
                <div style="margin-left: 20px">
                  <div class="username">{{ this.$store.state.sale.owner }}</div>
                  <div class="usertext">
                    这个人很懒，还没有写介绍...
                  </div>
                </div>
              </div>
              <a-button type="primary" shape="round" class="rightbutton" @click="viewHomePage"><b
                  style="letter-spacing: 3px">查看主页</b></a-button>
              <a-modal
                  v-model="modalVisible"
                  title="发起订单"
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
                <div class="centered-block">
                  <a-steps :current="current" style="">
                    <a-step v-for="item in steps" :key="item.title" :title="item.title"/>
                  </a-steps>
                  <div class="steps-content">
                    <template v-if="current === 0">
                      <!--                    <div style="margin-top: 100px; margin-bottom: 100px; margin-left: 250px">-->
                      <!--                      <font style="font-size:20px">卖家： {{ this.$store.state.sale.owner }}</font>-->
                      <!--                      <br>-->
                      <!--                      <font style="font-size:20px">商品名： {{ this.$store.state.sale.title }}</font>-->
                      <!--                      <br>-->
                      <!--                      <font style="font-size:20px">价格 ： ￥{{ this.$store.state.sale.price }}</font>-->
                      <!--                    </div>-->
                      <div style="margin-top: 5%">
                        <div class="info">
                          <a-statistic class="info-item" title="订单内容" :value="this.$store.state.sale.title"
                          />
                          <a-statistic class="info-item" title="金额(CNY)" :precision="2"
                                       :value="this.$store.state.sale.price">
                            <template #prefix>
                              ￥
                            </template>
                          </a-statistic>
                          <a-statistic class="info-item" title="卖方" groupSeparator=""
                                       :value="this.$store.state.sale.owner"/>
                        </div>
                      </div>
                    </template>
                    <template v-if="current === 1">
                      <div style="margin-top: 10px">
                        <font style="font-size:15px">订单号：</font>
                      </div>
                      <div style="text-align: center">
                        <img src="https://s3.ax1x.com/2020/12/14/rnMEKe.jpg"
                             style="width:300px; height: 300px; margin-top: 20px">
                        <br>
                      </div>
                    </template>
                    <template v-if="current === 2">
                      <div style="margin-top: 100px; margin-bottom: 100px">
                        <div style="text-align: center">
                          <a-spin style="font-size: 100px">
                            <a-icon slot="indicator" type="loading" style="font-size: 64px" spin/>
                          </a-spin>
                        </div>
                        <p style="text-align: center; margin-top: 30px">
                          <font style="font-size: 20px">确认支付结果中...</font>
                        </p>
                      </div>
                    </template>
                    <template v-if="current === 3">
                      <div style="margin-top: 5%">
                        <!--                        <a-statistic class="info-item" title="订单编号" groupSeparator=""-->
                        <!--                                     :value="this.$store.state.sale.owner"/>-->
                        <!--                        <a-statistic class="info-item" title="订单内容" :value="this.$store.state.sale.title"-->
                        <!--                        />-->
                        <!--                        <a-statistic class="info-item" title="金额(CNY)" :precision="2"-->
                        <!--                                     :value="this.$store.state.sale.price">-->
                        <!--                          <template #prefix>-->
                        <!--                            ￥-->
                        <!--                          </template>-->
                        <!--                        </a-statistic>-->
                        <a-result
                            status="success"
                            title="支付成功！"
                        >
                        </a-result>
                      </div>
                    </template>
                  </div>
                </div>
              </a-modal>
            </div>
            <div shadow="always" style="margin-top: 15px; padding: 20px;" class="sale-left-block">
              <div class="username" style="margin-bottom: 15px; margin-left: 7px">
                相关推荐
              </div>
              <a-row :gutter="4" style="margin: 10px 0px 10px 5px">
                <a-col :span="12"><img :src="staimgurl1"
                                       class="asideImg"/></a-col>
                <a-col :span="12"><img :src="staimgurl2"
                                       class="asideImg"/></a-col>
              </a-row>
              <a-row :gutter="4" style="margin: 10px 0px 10px 5px">
                <a-col :span="12"><img :src="staimgurl3"
                                       class="asideImg"/></a-col>
                <a-col :span="12"><img
                    :src="staimgurl4"
                    class="asideImg"/></a-col>
              </a-row>
            </div>
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
import getRandColor from './getRandColor'

function hslToRgb(H, S, L) {
  let R, G, B;
  if (+S === 0) {
    R = G = B = L; // 饱和度为0 为灰色
  } else {
    var hue2Rgb = function (p, q, t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    };
    const Q = L < 0.5 ? L * (1 + S) : L + S - L * S;
    const P = 2 * L - Q;
    R = hue2Rgb(P, Q, H + 1 / 3);
    G = hue2Rgb(P, Q, H);
    B = hue2Rgb(P, Q, H - 1 / 3);
  }
  return '#' + hex(Math.round(R * 230)) + hex(Math.round(G * 200)) + hex(Math.round(B * 230));
}

function hex(x) {
  return ("0" + parseInt(x).toString(16)).slice(-2);
}

// 获取随机HSL
function randomHsl() {
  var H = Math.random();
  var S = Math.random();
  var L = Math.random();
  return [H, S, L];
}

// 获取HSL数组
function getRGB() {
  let ret = randomHsl();
  ret[1] = 0.7 + (ret[1] * 0.2); // [0.7 - 0.9] 排除过灰颜色
  ret[2] = 0.4 + (ret[2] * 0.4); // [0.4 - 0.8] 排除过亮过暗色
  // 数据转化到小数点后两位
  ret = ret.map(function (item) {
    return parseFloat(item.toFixed(2));
  });
  return hslToRgb(ret[0], ret[1], ret[2]);
}

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
      staimgurl1: String,
      staimgurl2: String,
      staimgurl3: String,
      staimgurl4: String,
      imageURLs: [],
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
      tagContent: [],
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
      introduction: String,
      successDealId: 0,
      clickedCollect: false,
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
  created() {
    axios_service.get("merchandiseimg/selectByMerchandiseId?merchandiseId=" + this.$store.state.sale.merchandise_id).then((res) => {
      for (let i = 0; i < res.length; i++) {
        this.imageURLs.push({'url': this.$global.staticURL + res[i].imgpath});
      }
    })
    axios_service.get("figure/selectById?figureId=" + this.$store.state.sale.figure_id).then((res) => {
      console.log(res)
      this.tagContent.push({
        color: getRGB(),
        url: 'manu/' + res.manuName,
        content: res.manuName,
      });
      let name = res.figureName;
      let arr = name.split(" ");
      for (let i = 0; i < arr.length; i++) {
        this.tagContent.push({
          color: getRGB(),
          url: 'figure/' + this.$store.state.sale.figure_id,
          content: arr[i],
        });
      }
    })
    axios_service.get("roleimg/selectAll", null).then((res) => {
      console.log("select all role img ", res);
      let i = Math.floor(Math.random() * res.length);
      let le = res.length;
      this.staimgurl1 = this.$global.staticURL + res[i % le].imgpath;
      this.staimgurl2 = this.$global.staticURL + res[(i + 3) % le].imgpath;
      this.staimgurl3 = this.$global.staticURL + res[(i + 5) % le].imgpath;
      this.staimgurl4 = this.$global.staticURL + res[(i + 7) % le].imgpath;
    })
  },
  methods: {
    viewHomePage() {
      this.$router.push('/user/' + this.$store.state.sale.owner_id)
    },
    collect() {
      let _this = this;
      axios_service.post_with_params(this.$store, "collection/insert?", {
        'merchandiseId': this.$store.state.sale.merchandise_id,
      }).then((res) => {
        if (_this.clickedCollect === false) {
          _this.$message.success('收藏成功');
          _this.clickedCollect = true;
        } else {
          _this.$message.warning('已取消');
        }
      }).catch((e) => {
        this.$message.error('收藏失败');
      });
    },
    next() {
      this.current++
      if (this.current === 1) {
        axios_service.post_with_params(this.$store, "deal/insert?", {
          'status': 0,
          'seller': this.$store.state.sale.owner_id,
          'merchandiseId': this.$store.state.sale.merchandise_id,
        }).then((response) => {
          console.log("res of deal", response.data);
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
        setTimeout(() => {
          this.disable = false;
          this.current++;
          this.$message.success("支付成功!")
        }, 1000);
        // axios_service.get("deal/selectByMerchandiseId?merchandiseid=" + this.$store.state.sale.merchandise_id).then((res) => {
        //   console.log("ressssssssssss ",res)
        //
        // }).catch((err) => {
        //   this.disable = true;
        // })
      }
    },
    buyDone() {
      this.$message.success('购买成功');
      this.modalVisible = false
      this.current = 0
    },
    handleBuy() {
      this.modalVisible = true;
    },
    clickTag(head, url) {
      this.$store.commit("wikiName", head);
      this.$router.push("/wiki/" + url);
    }
  }
}
</script>

<style scoped="">
.right-word-container {
  display: inline-block;
  text-align: left;
}

.wordOfPrice {
  padding-right: 10px;
  font-family: priceFont, "Microsoft YaHei", Arial;
  color: #ffffff;
  font-size: 50px;
}

.asideImg {
  height: 110px;
  width: 110px;
  border-radius: 16px;
  object-fit: cover;
}

.sale-left-block {
  position: relative;
  padding-bottom: 40px;
  margin-bottom: 50px;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 3px 6px 0 #0002;
}

.sale-picture-board {
  border-radius: 20px;
}

.username {
  color: #ff7488;
  font-size: 16px;
  font-weight: bold;
  overflow: hidden;
  text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
  white-space: nowrap;
  justify-self: stretch;
  text-overflow: ellipsis;
}

.usertext {
  font-size: 13px;
  letter-spacing: 1px;
  font-weight: 100;
  text-align: left;
  margin-left: 0px;
  margin-top: 4px;
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

.rightbutton {
  margin-top: 20px;
  width: 100%;
}

.ant-carousel >>> .slick-slide {
  text-align: center;
  height: 450px;
  line-height: 160px;
  overflow: hidden;
}

.img-style {
  height: 100%;
  width: 100%;
  /*object-fit: scale-down;*/
  /*background-size: 100%;!*背景水平铺满*!*/
  /*filter:blur(10px);!*虚化值，越大越模糊*!*/
}

.card-div {
  padding: 20px 15px 30px 15px;
}


.tagdiv {
  margin-top: 12px;
  padding-left: 10px;
}

.tagdiv /deep/ .ant-tag {
  margin-bottom: 8px;
}

.centered-block {
  width: 90%;
  margin: 16px auto;
}

.info-item {
  margin: 16px 0px;
  font-size: 16px;
  font-weight: bold;
  overflow: hidden;
  justify-self: stretch;
  text-overflow: ellipsis;
}
</style>

