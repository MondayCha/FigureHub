<template>
  <div>
    <MyHeader head_index="1"></MyHeader>
<!--    <div class="img-responsive">-->
<!--      <img src="@/static/picture/girl_guitar_2560x1024.jpg">-->
<!--    </div>-->
    <div class="hpio-homesearch">
<!--      <div class="home-search-content">-->
<!--        <form id="search-form" target="_blank" action="search" method="post">-->
<!--          <input id="searchItemType" type="hidden" name="category" value="10000">-->
<!--          <div class="home-search-btn">-->
<!--            <input class="form-control home-search-text" autocomplete="off" type="text" id="keyword" name="keyword" placeholder="请输入关键/条目ID/JAN码等 如: GSC 路人女主">-->
<!--            <a href="javascript:void(0)" class="home-search-confirm" onclick="fn.SearchPush_index()">-->
<!--              <i class="fa fa-long-arrow-left"></i>-->
<!--            </a>-->
<!--            <i class="fa fa-search"></i>-->
<!--          </div>-->
<!--        </form>-->
<!--      </div>-->
    </div>
    <div class="simplify-home">
      <component class="simplify-home-component" :is="activeComponent"></component>
    </div>
  </div>
</template>
<script lang="ts">
export default {
  components: {
    'simple-home': () => import('./simple-home/simple-home.vue'),
    'MyHeader': () => import('../layout/myheader')
  },
  computed: {
    activeComponent() {
      return 'simple-home'
    }
  },
}
</script>
<style scoped lang="scss">
.hpio-homesearch {
  width: 100%;
  height: 400px;
  background-image:url(../../static/picture/girl_guitar_2560x1024.jpg);
  background-repeat:no-repeat;
  background-size:100%;
  margin-top: -20px;
}
.home-search-content{padding-top: 65px;position: relative;}
.home-search-text{border:0px; background-color: rgba(255,255,255,.2);color: #FFF;height: 55px;border-radius: 16px;padding: 0 42px;}
.home-search-text::placeholder{border:0px;color:#FFF;opacity:1}
.home-search-text:focus::-webkit-input-placeholder{border:0px;color:#5e6467;opacity:1}
.home-search-text:focus{background-color: #f3f3f3;color: #464a4c;border: none !important;}
i.fa-search{width: 4rem;line-height: 55px;text-align: center;position: absolute;top:0;}
i.fa-long-arrow-left{transition: color .3s,transform .4s,-webkit-transform .4s;top:0;right:0;width: 4rem;line-height: 55px;text-align: center;position: absolute;}
.home-search-text:focus + a > i.fa-long-arrow-left{transform: rotate(180deg);transition: color .3s,transform .4s,-webkit-transform .4s;}
.home-search-text:focus ~ i{color: #5e6467;}
.home-search-text:focus ~ .home-search-confirm > i{color: #5e6467;}
.home-search-btn{width:50%;margin:0px auto;position: relative;}
.btn{
  padding: 7px 10px;
}
//button:focus{outline:0;!important;}
//:focus{outline:0;}

.hpoi-glyphiconcolor {
  color: #676c6a;
}
.btn-default{
  color: inherit;
  background: #fff;
  border: 1px solid #e7eaec;
}
.home-search-confirm{
  color: #FFFFFF;
}
i.fa-search{
  color: #FFFFFF;
}
.sk-spinner-circle .sk-circle:before {
  background-color: #1c84c6;
}

@media screen and (max-width: 1200px) {
  .hpoi-latestinformation-soll{
    position: static;
    margin-right: 0;
  }
}

/*所有div阴影*/
.swiper-container,.hpio-popularRec-right>.item,.hpoi-market,.hpoi-srshop-store,.exhbn-item,.conter-left-item,
.conter-right-infbox .conter-right-item,.conter-left-Gkitem,.hpoi-conter-ltsifrato>.hpoi-conter-left,
.hpoi-latestinformation-rg > .hpoi-conter-rightrg{
  transition: box-shadow 0.3s ease-in-out;
}
.swiper-container:hover,.hpio-popularRec-right>.item:hover,.hpoi-market:hover,.hpoi-srshop-store:hover,.exhbn-item:hover,
.conter-left-item:hover,.conter-right-infbox .conter-right-item:hover,.conter-left-Gkitem:hover,
.hpoi-conter-ltsifrato>.hpoi-conter-left:hover,.hpoi-latestinformation-rg > .hpoi-conter-rightrg:hover{
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}


.img-responsive{
  max-width: 100%;
  height: 0;
  padding-bottom: 20%;
  background-color:#fef9ff;/*背景色*/
  overflow: hidden;
}
.img-responsive img {
  width: 100%;
}
.back {
  background-color: #ffffff;
}

.simplify-home {
  padding-top: 32px;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  //min-height: 100vh;

  body.dark & {
    background-color: #181818;
  }

  .simplify-home-component {
    max-width: 100%;
  }
}

html {
  scroll-behavior: smooth;
}
</style>
