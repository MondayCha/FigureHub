<template>
  <a-layout>
    <MyHeader head_index="3"></MyHeader>
    <a-layout class="market_back">
      <ShopList ref="HomePageList"></ShopList>
    </a-layout>
  </a-layout>
</template>

<script>
import MyHeader from "../layout/myheader";
import ShopList from "../../components/shopList/shopCardList"

export default {
  components: {
    MyHeader,
    ShopList,
  },
  created() {
    this.$nextTick(() => {
      this.$refs.HomePageList.startInit(3);
      this.$refs.HomePageList.selectAllPictures();
    })
  }
};
</script>

<style>
.market_back {
  padding-left: 100px;
  padding-right: 100px;
  background-color: #ffffff;
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
  zoom: 1;
}

.heroContent {
  position: absolute;
  font-size: 18px;
  top: 50%;
  left: 50%;
  padding-top: 0;
  width: 100%;
  z-index: 999;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
  color: rgba(255, 156, 180, 0.3);
}
</style>
