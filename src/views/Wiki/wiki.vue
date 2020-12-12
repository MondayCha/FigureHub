<template>
  <a-layout>
    <MyHeader head_index="2"></MyHeader>
    <a-layout class="back">
      <div class="s-skin-container">
      </div>
      <div class="heroContent">
        <div style="font-size:200px">wiki</div>
        <div class="card">
              <div class="card-wrapper">
                <shop-card :data="card" orientation="vertical"></shop-card>
          </div>
        </div>
        <ContentSlot list-width="500" list-height="800"></ContentSlot>
      </div>
    </a-layout>
  </a-layout>
</template>
<script>
import MyHeader from "../layout/myheader";
import ShopCard from "../../components/shopList/shopCard"

export default {
  name: 'wiki',
  components: {
    MyHeader,
    ShopCard,
  },
  data() {
    return {
      card:{
        id:123,
        coverUrl: "https://i0.hdslb.com/bfs/archive/bd32aee10921815e6cb788858e4c1531609f5132.jpg@625w_312h.jpg",
        title: "jfdfhjsdhfj",
        imageUrl: "https://i0.hdslb.com/bfs/sycp/creative_img/202012/29f6dbfb63f6d29025e4bf7501eb6b89.jpg@625w_312h.jpg",
      },
    }
  },
};
</script>

<style>
.card {
  --card-width: 200px;
  --card-height: 250px;
  --card-count: 3;
  margin-top: 16px;
  display: flex;
  overflow: auto;
}

.back {
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
