<template>
  <div style="padding-top: 20px">
    <a-spin :spinning="isLoading" size="large" class="flex">
      <el-row :gutter="20" class="flex">
        <el-col v-for="(list,index) in lists" :key="index" :span="6" style="padding: 0px">
          <div class="grid-content bg-purple">
            <div v-for="(picturesMessage, index) in list.picturesMessage" :key="index" class="itemBorder">
              <my-item :pictures-message="picturesMessage"></my-item>
            </div>
          </div>
        </el-col>
      </el-row>
    </a-spin>
  </div>
</template>

<script>
import myShopItem from "./shopItem";
import axios from 'axios';
import axios_service from "@/api/request";

//import pic from "https://i0.hdslb.com/bfs/sycp/creative_img/202012/b21688b8754e5d8c8ad793072fe38036.jpg@625w_312h.jpg"

function getPosts(goodList) {
  // 存储所有http请求
  let reqList = []
  // 存储后台响应每个请求后的返回结果
  let resList = []

  for (let i = 0; i < goodList.length; i++) {
    let req = axios.get(`merchandises/${goodList[i].merchandise.id}/images`);
    reqList.push(req)
    resList.push(('post' + (i + 1)).replace(/[']+/g, ''))
  }

  return axios.all(reqList).then(axios.spread(function (...resList) {
    return resList // 拿到所有posts数据
  }))
}

export default {
  components: {
    myItem: myShopItem
  },
  data() {
    return {
      displayItems: [
        {
          picture_id: Number,
          painter_id: Number,
          picture_address: String,
          owner_url: String,
          uploadTime: String,
          title: String,
        }
      ],

      collectionItems: [
        {
          user_id: Number,
          picture_id: Number,
          collectTime: String,
        }
      ],

      lists: [
        {
          totalHeight: Number,
          picturesMessage: [
            {
              width: Number,
              height: Number,
              picture: {
                picture_id: Number,
                painter_id: Number,
                picture_address: String,
                owner_url: String,
                uploadTime: String,
                title: String,
              },
              collection: {
                user_id: Number,
                picture_id: Number,
                CollectTime: String,
              }
            }
          ]
        }
      ],
      pictureWidth: 500,
      goodList: [],
      isLoading: false,
    }
  },

  // var: timer=setInterval(this.makeSureLoad, 50),
  methods: {
    //开始时的初始化，设置总共有listNum列pagelist
    startInit(listNum) {
      let _this = this;
      _this.lists = [];
      //console.log("listNum为： " + listNum + "开始列数为： " + _this.lists.length);
      for (let i = 0; i < listNum; i++) {
        _this.lists.push({
          totalHeight: 0,
          picturesMessage: []
        });
      }
      //console.log("初始化完后的总列数为：" + _this.lists.length);
    },

    //还没有重写
    initialsubList() {
      let _this = this;
      for (let i = 0; i < _this.lists.length; i++) {
        _this.lists[i].totalHeight = 0;
        _this.lists[i].picturesMessage = [];
        //console.log("正在重置List" + i + " ,重置后结果为： 高度" + _this.lists[i].totalHeight);
      }
      //console.log('完成pagelist的充值');
    },

    //loading picture function
    imgload(pictureItem, callback) {
      //console.log("ima load")
      var img = new Image();
      img.src = pictureItem.picture_address;
      // if (img.complete) {
      //   //图片是否存在缓存
      //   callback(img);
      //   return;
      // }
      img.onload = function () {
        callback(img, pictureItem);
      }
    },

    calculateImageHeight(width, height) {
      //console.log("宽度是: " + width, "高度是: " + height);
      //console.log("相对高度是: " + ((this.pictureWidth) * height / width));
      return ((this.pictureWidth) * height / width);
    },

    allocPicture(img, pictureItem) {
      let _this = this;
      //console.log('图片信息为: src——' + img.src + ", height——" + img.height + ';');
      //输出调试信息
      for (let i = 0; i < _this.lists.length; i++) {
        //console.log('待插入的列表的信息为,list' + i + ": " + this.lists[i].totalHeight);
      }
      //1.计算那一列是最短的
      let insertColumn = 0;
      let minHeight = _this.lists[0].totalHeight; //不能没有列
      for (let i = 0; i < _this.lists.length; i++) {
        if (_this.lists[i].totalHeight < minHeight) {
          insertColumn = i;
          minHeight = _this.lists[i].totalHeight;
        }
      }
      //2.将图片信息插入最短的一列，并更新列总高度
      _this.lists[insertColumn].totalHeight += _this.calculateImageHeight(img.width, img.height);
      let newPictureMessage = {
        width: img.width,
        height: img.height,
        picture: pictureItem,
        collection: {
          user_id: -1,
          picture_id: -1,
          CollectTime: null,
        }
      }
      _this.lists[insertColumn].picturesMessage.push(newPictureMessage);
      //console.log("put picture in list" + insertColumn);
      // let isCollected = false;
      // for(let i=0; i<_this.collectionItems; i++){
      //   if(_this.collectionItems[i].picture_id == pictureItem.picture_id){
      //     //
      //   }
      // }
    },
    //mydebug
    mydebug() {
      let _this = this;
      for (let i = 0; i < _this.lists.length; i++) {
        //console.log("list" + i + "中picturesMessage的长度为：" + _this.lists[i].picturesMessage.length);
      }
    },

    //axios function
    search() {
      let _this = this;
      //console.log("router发生变化并监听到了");
      //console.log("监听的类型是: " + _this.$route.params.type);
      if (_this.$route.params.type == 'keyword') {
        let keyword = _this.$route.params.keyword;
        _this.selectByKeyword(keyword);
      }
    },

    async getCard(goodList) {
      let posts = await getPosts(goodList);
      let items = [];
      for (let i = 0; i < posts.length; i++) {
        if (posts[i] && posts[i].status === 200 && posts[i].data.length > 0) {
          let tmpItem = {
            'title': goodList[i].figure.name,
            'owner': goodList[i].seller_name,
            'picture_address': this.$global.staticURL + posts[i].data[0].url,
            'owner_url': this.$global.staticURL + goodList[i].seller_avatar,
            'price': goodList[i].merchandise.price,
            'sale_id': goodList[i].id,
            'figure_id': goodList[i].figure.id,
            'owner_id': goodList[i].seller_id,
            'merchandise_id': goodList[i].merchandise.id,
            'merchandise_kind': goodList[i].merchandise.kind,
            'merchandise_status': goodList[i].merchandise.status,
          }
          items.push(tmpItem)
        }
      }
      // return JSON.stringify(items);
      return items;
    },

    /***
     * 处理全图片搜集部分
     */
    selectAllPictures() {
      //console.log('准备搜集所有图片...')
      this.isLoading = true;
      let _this = this;
      let search_url = "sales";
      let search_params = null;
      if (this.$store.state.search_item !== '') {
        search_url = "search/sales";
        search_params = {figure_name: this.$store.state.search_item}
        this.$store.commit('commitSearch', '');
      }
      axios_service.get(search_url, search_params).then((res) => {
        if (res.length > 0) {
          _this.goodList = res;
          this.getCard(_this.goodList).then((res) => {
            _this.displayItems = res;
            //2.列表初始化
            _this.initialsubList();
            //3.分配图片
            for (let i = 0; i < _this.displayItems.length; i++) {
              _this.imgload(_this.displayItems[i], _this.allocPicture);
            }
          });
        }
        this.isLoading = false;
      });
    },

    //还没重写
    selectByKeyword(keyword) {
      //console.log("开始准备selectByKeyword的axios,其中keyword是: " + keyword);
      axios.get('/pictures/searchKeyword', {
        params: {
          keyword: keyword
        }
      }).then((response) => {
        //console.log("完成了selectByKeyword的axios,其中keyword为: " + keyword);
        this.displayItems = response.data;
        //console.log(this.displayItems);
        this.initialsubList();
        //load all pictures
        for (let i = 0; i < this.displayItems.length; i++) {
          this.imgload(this.displayItems[i].picture_address, this.allocPicture);
        }
      }).catch(function (error) {
        if (error.response) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx
          //console.log(error.response.data);
          //console.log(error.response.status);
          //console.log(error.response.headers);
        } else if (error.request) {
          // The request was made but no response was received
          // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
          // http.ClientRequest in node.js
          //console.log(error.request);
        } else {
          // Something happened in setting up the request that triggered an Error
          //console.log('Error', error.message);
        }
        //console.log(error.config);
      });
    },

    /***
     * 处理图片收藏部分
     */
    showNowUserCollections() {
      let _this = this;

      //console.log("准备获得用户所有的收藏图片...");
      //1.axios获得当前用户所有的收藏图片
      axios.get('/collection/getPictures', {
        params: {
          user_id: _this.$store.state.user.userID,
        }
      }).then(function (response) {
        _this.displayItems = response.data;
        //console.log("用户获取收藏图片成功!");

        //2.初始化
        _this.startInit(3);

        //3.分配图片
        for (let i = 0; i < _this.displayItems.length; i++) {
          _this.imgload(_this.displayItems[i], _this.allocPicture);
        }
      }).catch(function (error) {
        //console.log(error);
      })
    },
  },
}
</script>

<style scoped>
.spin-content {
  border: 1px solid #91d5ff;
  background-color: #e6f7ff;
  padding: 500px;
}

:last-child {
  margin-bottom: 0;
}

.bg-purple {
  /*购物页面*/
  background: #ffffff;
}

.grid-content {
  border-radius: 16px;
  min-height: 24px;
}

.flex {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

.itemBorder {
  box-sizing: border-box;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: 5px;
  /*padding-bottom: 16px;*/
  overflow: hidden;
}

</style>
