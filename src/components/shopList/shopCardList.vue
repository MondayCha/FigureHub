<template>
  <div style="padding-top: 20px">
    <!--    <el-button type="primary" icon="el-icon-edit" circle @click="changestore"></el-button>-->
    <!--        <el-button type="success" icon="el-icon-check" circle @click="mydebug"></el-button>-->
    <el-row :gutter="20" class="flex">
      <el-col v-for="(list,index) in lists" :key="index" :span="6" style="padding: 0px">
        <div class="grid-content bg-purple">
          <div v-for="picturesMessage in list.picturesMessage" class="itemBorder">
            <my-item :pictures-message="picturesMessage"></my-item>
          </div>
        </div>
      </el-col>
    </el-row>
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
    console.log("getPosts ", goodList[i].merchandiseId);
    let req = axios.get("merchandiseimg/selectByMerchandiseId?merchandiseId=" + goodList[i].merchandiseId);
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
    }
  },

  computed: {
    userID() {//监听用户id,从而对收藏内容的显示进行变更
      //id变更时,进行主页collection显示的更新
      return this.$store.state.user.userID;
    }
  },

  watch: {
    '$route': 'search',
    userID() {
      //console.log("监听用户id变化成功...");
      this.selectAllCollections();
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
      } else {

      }
    },

    async getCard(goodList) {
      let posts = await getPosts(goodList);
      let items = [];
      for (let i = 0; i < posts.length; i++) {
        if (posts[i] && posts[i].status === 200) {
          console.log(posts[i]);
          let tmpItem = {
            'title': goodList[i].figureName,
            'owner': goodList[i].nickname,
            'picture_address': 'http://localhost:2333/ImgStore/' + posts[i].data[0].imgpath,
            'owner_url': 'http://localhost:2333/ImgStore/' + goodList[i].imgpath,
            'price': goodList[i].price,
            'sale_id': goodList[i].saleId,
            'figure_id': goodList[i].figureId,
            'owner_id': goodList[i].username,
            'merchandise_id': goodList[i].merchandiseId,
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
      let _this = this;
      let search_url = "sale/selectAll";
      if (this.$store.state.search_item != '') {
        search_url = "sale/selectByFigureName?figureName=" + this.$store.state.search_item;
        this.$store.commit('commitSearch', '');
      }
      axios_service.get(search_url, null).then((res) => {
        console.log("liost is ", res);
        _this.goodList = res;
        this.getCard(_this.goodList).then((res) => {
          _this.displayItems = res;
          console.log("所有的图片信息为：" + _this.displayItems);
          //2.列表初始化
          _this.initialsubList();
          //3.分配图片
          for (let i = 0; i < _this.displayItems.length; i++) {
            _this.imgload(_this.displayItems[i], _this.allocPicture);
          }
          //4.若用户已经登录，加载收藏关系
          if (_this.$store.state.user.userID !== "") {
            _this.selectAllCollections();
            _this.allocAllCollectionMessage();
          }
        });
      });

      //1.axios获得所有图片
      // axios.get('/pictures/selectAll').then((response) => {
      //   _this.displayItems = response.data;
      //   //console.log("所有的图片信息为：" + _this.displayItems);
      //   //2.列表初始化
      //   _this.initialsubList();
      //   //3.分配图片
      //   for (let i = 0; i < _this.displayItems.length; i++) {
      //     _this.imgload(_this.displayItems[i], _this.allocPicture);
      //   }
      //   //4.若用户已经登录，加载收藏关系
      //   if (_this.$store.state.user.userID !== "") {
      //     _this.selectAllCollections();
      //     _this.allocAllCollectionMessage();
      //   }
      // }).catch(function (error) {
      //   //console.log(error);
      // });
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

        //4.每张图片添加已收藏
        _this.selectAllCollections();
        // _this.allocAllCollectionMessage();异步请求!又忘了！八嘎
      }).catch(function (error) {
        //console.log(error);
      })
    },


    selectAllCollections() {
      //console.log("准备搜集用户的收藏信息...");
      let _this = this;
      let nowUserID = _this.$store.state.user.userID;
      //1.axios请求获得所有当前用户收藏信息
      axios.get('/collections/get', {
        params: {
          user_id: nowUserID,
        }
      }).then(function (response) {
        _this.collectionItems = response.data;
        //console.log("获取收藏信息成功,信息数目为：" + _this.collectionItems.length);
        //debug
        for (let i = 0; i < _this.collectionItems.length; i++) {
          //console.log("用户id：" + _this.collectionItems[i].user_id + "图片id：" + _this.collectionItems[i].picture_id)
        }

        _this.allocAllCollectionMessage();
      }).catch(function (error) {
        //console.log(error);
      })
    },

    allocAllCollectionMessage() {
      let _this = this;
      for (let i = 0; i < _this.collectionItems.length; i++) {
        _this.allocCollectionMessage(_this.collectionItems[i]);
      }
    },

    allocCollectionMessage(collectionItem) {
      let _this = this;
      //1.从所有的list中寻找与当前collectionItem图片id相同的一项
      for (let i = 0; i < _this.lists.length; i++) {
        for (let j = 0; j < _this.lists[i].picturesMessage.length; j++) {//双循环，笨死了，但是无哈希
          if (_this.lists[i].picturesMessage[j].picture.picture_id == collectionItem.picture_id) {
            //2.找到收藏项所在pagelist中的位置后，将collectoin信息进行替换
            //console.log("收藏位置在：第" + (i + 1) + "列， 第" + (j + 1) + "个");
            let newPictureMessage = _this.lists[i].picturesMessage[j];
            newPictureMessage.collection = collectionItem;
            _this.lists[i].picturesMessage.splice(j, 1, newPictureMessage);
          }
        }
      }
    }
  },
}
</script>

<style scoped>
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
