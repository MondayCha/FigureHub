<template>
  <div>
    <MyHeader head_index="1"></MyHeader>
    <!--    <div class="img-responsive">-->
    <!--      <img src="@/static/picture/girl_guitar_2560x1024.jpg">-->
    <!--    </div>-->
    <div class="hpio-homesearch">
      <div class="home-search-content">
        <div class="home-search">
          <input class="form-control home-search-text" v-model="message" placeholder="请输入关键/条目ID/JAN码等 如: FATE / GRAND ORDER" v-on:keyup.enter="submit">
          <a-icon type="search" class="home-search-icon" v-on:click="submit"/></div>
      </div>
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
  data() {
    return {
      message: '',
    }
  },
  computed: {
    activeComponent() {
      return 'simple-home'
    }
  },
  methods: {
    submit() {
      if (this.message == null || this.message === "") {
        this.$store.commit('commitSearch', '');
        this.$router.push('/market');
      } else {
        this.$store.commit('commitSearch', this.message);
        this.$router.push('/market');
      }
    },
  },
}
</script>
<style scoped lang="scss">
.hpio-homesearch {
  width: 100%;
  height: 400px;
  background-image: url(../../static/picture/girl_guitar_2560x1024.jpg);
  background-repeat: no-repeat;
  background-size: 100%;
  margin-top: -20px;
  padding-top: 200px;
}

.home-search {
  display: flex;
  width: 50%;
  height: 55px;
  border-radius: 20px;
  margin: 0px auto;
  position: relative;
  align-items: center;
}

.home-search-content {
  padding-top: 65px;
  position: relative;
}

.home-search-icon {
  font-size: 26px;
  position: absolute;
  right: 30px;
  color: #f3f3f3;
  cursor: pointer;
}

.home-search-icon:focus + .home-search-content {
  color: #5e6467;
}

.home-search-text {
  border: 0px;
  border-radius: 20px;
  height: 100%;
  background-color: rgba(255, 255, 255, .2);
  color: #FFF;
  padding: 0 42px;
  width: 100%;
}

.home-search-text::placeholder {
  border: 0px;
  color: rgba(255, 255, 255, 1);
  opacity: 1
}

.home-search-text:focus::-webkit-input-placeholder {
  border: 0px;
  color: #5e6467;
  opacity: 1
}

.home-search-text:focus {
  background-color: #f3f3f3;
  color: #464a4c;
  border: none !important;
}

i.fa-search {
  width: 4rem;
  line-height: 55px;
  text-align: center;
  position: absolute;
  top: 0;
}

i.fa-long-arrow-left {
  transition: color .3s, transform .4s, -webkit-transform .4s;
  top: 0;
  right: 0;
  width: 4rem;
  line-height: 55px;
  text-align: center;
  position: absolute;
}

.home-search-text:focus + a > i.fa-long-arrow-left {
  transform: rotate(180deg);
  transition: color .3s, transform .4s, -webkit-transform .4s;
}

.home-search-text:focus ~ i {
  color: #5e6467;
}

.home-search-text:focus ~ .home-search-confirm > i {
  color: #5e6467;
}

.btn {
  padding: 7px 10px;
}

//button:focus{outline:0;!important;}
//:focus{outline:0;}

.hpoi-glyphiconcolor {
  color: #676c6a;
}

.btn-default {
  color: inherit;
  background: #fff;
  border: 1px solid #e7eaec;
}

.home-search-confirm {
  color: #FFFFFF;
}

i.fa-search {
  color: #FFFFFF;
}

.sk-spinner-circle .sk-circle:before {
  background-color: #1c84c6;
}

@media screen and (max-width: 1200px) {
  .hpoi-latestinformation-soll {
    position: static;
    margin-right: 0;
  }
}

/*所有div阴影*/
.swiper-container, .hpio-popularRec-right > .item, .hpoi-market, .hpoi-srshop-store, .exhbn-item, .conter-left-item,
.conter-right-infbox .conter-right-item, .conter-left-Gkitem, .hpoi-conter-ltsifrato > .hpoi-conter-left,
.hpoi-latestinformation-rg > .hpoi-conter-rightrg {
  transition: box-shadow 0.3s ease-in-out;
}

.swiper-container:hover, .hpio-popularRec-right > .item:hover, .hpoi-market:hover, .hpoi-srshop-store:hover, .exhbn-item:hover,
.conter-left-item:hover, .conter-right-infbox .conter-right-item:hover, .conter-left-Gkitem:hover,
.hpoi-conter-ltsifrato > .hpoi-conter-left:hover, .hpoi-latestinformation-rg > .hpoi-conter-rightrg:hover {
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}


.img-responsive {
  max-width: 100%;
  height: 0;
  padding-bottom: 20%;
  background-color: #fef9ff; /*背景色*/
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
