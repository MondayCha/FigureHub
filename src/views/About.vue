<template>
  <a-layout>
    <MyHeader head_index="4"></MyHeader>
    <a-layout class="back">
      <div class="s-skin-container"></div>
      <div class="heroContent">
        <div class="h1">Figure Hub</div>
        <p>
          集搜索、销售、二手交易、用户分享于一体的手办交易平台</p>
        <p>18373483周一扬</p>
        <p>18373528杨凌华</p>
        <p>18373580李亦龙</p>
      </div>
    </a-layout>
  </a-layout>
</template>

<script>
import MyHeader from "./layout/myheader";

export default {
  components: {
    MyHeader,
  },
};
</script>

<style lang="css" scoped>
@font-face {
  font-family: myFont;
  src: url("../static/fonts/Attractype Reborn.otf") format("opentype");
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
  background-color: #fb7299;
  background-image: url("../static/picture/golden-flower.jpg");
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

.hero {
  border-radius: 8px;
  width: 1430px;
  height: 650px;
  margin: 17px auto 37px;
  padding-top: 494px;
  z-index: 0;
  color: #fff;
  position: relative;
  top: 0;
  left: 0;
  background-color: #fb7299;
  background-image: url("../static/picture/golden-flower.jpg");
  background-position: center 0;
  background-repeat: no-repeat;
  background-size: cover;
  -webkit-background-size: cover;
  -o-background-size: cover;
}

.heroContent {
  position: absolute;
  font-size: 18px;
  text-shadow: 0.1em 0.1em rgba(77, 77, 77, 0.3);
  top: 50%;
  left: 50%;
  padding-top: 0;
  width: 100%;
  z-index: 999;
  color: #fff;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
}

.h1 {
  font-family: myFont;
  font-size: 120px;
  position: static;
  top: auto;
  left: auto;
  font-weight: 400;
  padding-right: 0;
  padding-left: 0;
  box-sizing: border-box;
}
</style>
