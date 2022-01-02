<template>
  <div class="trendings">
    <div class="header">
      <div class="title">上新</div>
    </div>
    <div class="contents" ref="contents">
      <div class="card-wrapper" v-for="card in trendingCards" :key="card.id">
        <video-card :data="card" orientation="vertical"></video-card>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  components:{
    'video-card' : ()=>import('../wiki-card'),
  },
  data() {
   return {
     trendingCards: [
       {
         id:2,
         coverUrl: this.$global.staticURL + 'images/1.jpg',
         title: "剧场版约会大作战 万由里裁决 时崎狂三",
         upname: 'ALTER',
         company_url: this.$global.staticURL + "images/眼镜厂.png",
         imageUrl: this.$global.staticURL + "images/22.jpg",
         sale_url: 'http://ruby-git.act.buaa.edu.cn:15377/#/wiki/figures/2'
       },
       {
         id:1,
         coverUrl: this.$global.staticURL + 'images/22.jpg',
         title: "Re：从零开始的异世界生活 艾米莉娅 偶像 Ver.",
         upname: 'ALTER',
         company_url: this.$global.staticURL + "images/眼镜厂.png",
         imageUrl: this.$global.staticURL + "images/22.jpg",
         sale_url: 'http://ruby-git.act.buaa.edu.cn:15377/#/wiki/figures/23'
       },
       {
         id:3,
         coverUrl: this.$global.staticURL + 'images/9.jpg',
         title: "Fate / Grand Order 贞德 3段阶目",
         upname: 'BANDAI',
         company_url: this.$global.staticURL + "images/Bandai.png",
         imageUrl: this.$global.staticURL + "images/22.jpg",
         sale_url: 'http://ruby-git.act.buaa.edu.cn:15377/#/wiki/figures/3'
       },
     ],
   }
 },
}
</script>

<style lang="scss">
.simple-home .trendings {
  display: flex;
  flex-direction: column;
  .header {
    padding: 0 8px;
    .page {
      display: flex;
      align-items: center;
      > * {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 4px;
        background-color: #8882;
        border-radius: 50%;
        margin-left: 8px;
        cursor: pointer;
        &:hover {
          background-color: #8884;
        }
      }
      .prev-page .be-icon {
        transform: translateX(-1px);
      }
      .next-page .be-icon {
        transform: translateX(1px);
      }
    }
  }
  .contents {
    --card-width: 200px;
    --card-height: 250px;
    --card-count: 3;
    margin-top: 16px;
    display: flex;
    overflow: auto;
    height: calc(var(--card-height) + 16px);
    width: calc((var(--card-width) + 16px) * var(--card-count));
    scrollbar-width: none !important;

    @media screen and (max-width: 1300px) and (min-width: 900px) {
      & {
        --card-count: 2;
      }
    }
    @media screen and (max-width: 1100px) and (min-width: 900px) {
      & {
        --card-count: 4;
      }
    }
    @media screen and (min-width: 1550px) {
      & {
        --card-count: 4;
      }
    }
    // @media screen and (min-width: 1850px) {
    //   & {
    //     --card-count: 5;
    //   }
    // }
    &::-webkit-scrollbar {
      width: 0 !important;
      height: 0 !important;
    }
    .card-wrapper {
      padding: 0 8px;
      scroll-snap-align: start;
      flex-shrink: 0;
    }
  }
}
</style>
