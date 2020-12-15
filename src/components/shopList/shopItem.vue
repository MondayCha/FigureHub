<template>
  <div class="item" :class="{vertical:'vertical'}" @click="routeJump">
    <div class="item-content">
      <div class="cover-container">
        <dpi-img class="item-img" :src="this.picturesMessage.picture.picture_address"></dpi-img>
      </div>
      <div class="word-container">
        <div class="left-word-container">
          <h1 class="h1title" :title="title">{{ this.picturesMessage.picture.title }}</h1>
          <div style="width: fit-content; margin-bottom: 10px">
            <div
                class="up"
                :class="{'no-face': !owner_url}"
            >
              <dpi-img v-if="owner_url" class="face" :src="this.picturesMessage.picture.owner_url" :size="24"></dpi-img>
              <div class="name" :title="owner">{{ this.picturesMessage.picture.owner }}</div>
            </div>
          </div>
        </div>
        <div class="right-word-container">
          <span style="font-size:20px; color: #00a0d8; "><b>￥</b></span>
          <span class="wordOfPrice">{{ this.picturesMessage.picture.price }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
//部分来源：https://github.com/cheer-fun/pixivic-pc

export default {
  name: "PictureItem",
  components: {
    'dpi-img': () => import('../../views/dpi-img.vue'),
  },

  props: {//获取pagelist所传递的图片信息参数，以及是否收藏参数
    picturesMessage: {
      width: Number,
      height: Number,
      picture: {
        title: String,
        owner: String,
        cover_url: null,
        owner_url: null,
        price: -1,
        sale_id: null,
      },
      collection: {
        user_id: -1,
        picture_id: -1,
        CollectTime: String,
      }
    }
  },

  data() {
    return {
      title: String,
      owner: String,
      cover_url: null,
      owner_url: 'http://localhost:2333/ImgStore/logo.svg',
      price: -1,
    }
  },

  // computed: {//计算样式
  //   isCollected() {
  //     return (this.picturesMessage.collection.user_id >= 0) ? true : false;
  //   }
  // },

  methods: {
    routeJump() {
      this.$store.commit('routeToSale', this.picturesMessage.picture);
      this.$router.push('/market/sale=' + this.picturesMessage.picture.sale_id);
    },
  },
}

</script>

<style scoped lang="scss">
@font-face {
  font-family: priceFont;
  src: url("../../static/fonts/Oswald-Stencil-Regular-2.ttf") format("truetype");
}

.word-container {
  width: 100%;
  height: 70px;
}

.left-word-container {
  width: 55%;
  height: 100%;
  display: inline-block;
}

.right-word-container {
  width: 45%;
  height: 100%;
  display: inline-block;
  text-align: right;
}

.wordOfPrice {
  padding-right: 10px;
  font-family: priceFont, "Microsoft YaHei", Arial;
  color: #fb7299;
  text-align: right;
  font-size: 50px;
}

.up {
  margin-left: 12px;
  display: flex;
  align-items: center;
  padding: 2px;
  background-color: #8882;
  border-radius: 14px;
  color: inherit;

  &.no-face {
    background-color: transparent;
    padding: 0;

    .be-icon {
      font-size: 14pt;
      opacity: 0.75;
    }
  }

  .face {
    border-radius: 50%;
    width: 24px;
    height: 24px;
  }

  .name {
    margin: 0 8px;
    overflow: hidden;
    text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
    white-space: nowrap;
    /*文本不自动换行*/
  }

  &:not(.no-face):hover {
    background-color: #8884;
  }

  &:hover {
    .name,
    .be-icon {
      color: var(--theme-color);
    }
  }
}

.cover-container {
  border-radius: 16px 16px 0 0;
  overflow: hidden;
}

.h1title {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  max-height: 3em;
  word-break: break-all;
  white-space: normal;
  line-height: 1.5;
  font-size: 11pt;
  grid-area: title;
  font-weight: bold;
  padding: 3px 12px 0;
  overflow: hidden;
  text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
  white-space: nowrap;
  /*文本不自动换行*/
  justify-self: stretch;
  text-overflow: ellipsis;
}

.item {
  box-sizing: border-box;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: 8px;
  /*padding-bottom: 16px;*/
  overflow: hidden;
  /*box-shadow: 0 4px 8px 0 #0001;*/
}

.item-content {
  cursor: pointer;
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px 0 #0001;
  background-color: #ffffff;
}

.item-img {
  width: 100%;
  height: 100%;
  transform: scale(1);
  transition: opacity 0.3s, transform 0.3s ease;
  object-fit: cover;
  //box-shadow: 0 4px 8px 0 #0001;
  overflow: hidden;
  position: relative;
}

.item-img:hover {
  transform: scale(1.05);
}

.cover-container {
  border-radius: 16px 16px 0 0;
}

</style>

