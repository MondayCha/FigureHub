<template>
  <div class="trendings">
    <div class="header">
      <div class="title">上新</div>
      <div class="page">
        <div class="prev-page" @click="scroll(-1)">
          <a-icon type="left" style="font-size: 20px"/>
        </div>
        <div class="next-page" @click="scroll(1)">
          <a-icon type="right" style="font-size: 20px"/>
        </div>
      </div>
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
         id:123,
         coverUrl: "http://localhost:2333/ImgStore/22.jpg",
         title: "Re：从零开始的异世界生活 艾米莉娅 偶像 Ver.",
         upname: '眼镜厂',
         imageUrl: "http://localhost:2333/ImgStore/22.jpg",
       },
       {
         id:123,
         coverUrl: "http://localhost:2333/ImgStore/9.jpg",
         title: "Fate / Grand Order 贞德 3段阶目",
         upname: 'ALTER',
         imageUrl: "http://localhost:2333/ImgStore/22.jpg",
       },
       {
         id:123,
         coverUrl: "http://localhost:2333/ImgStore/15.jpg",
         title: "figma#SP-129 Type-Moon Racing&GOOD SMILE Racing 尼禄·克劳狄乌斯 赛车女郎Ver.",
         upname: 'MaxFactory',
         imageUrl: "http://localhost:2333/ImgStore/22.jpg",
       },
     ],
   }
 },
}

////interface Tab {
////  name: string
////  day: number
////  url: string
////}
//export default {
//  components: {
//    Icon: () => import('../../icon.vue'),
//  },
//  data() {
//    return {
//      trendingCards: [],
//    }
//  },
//  methods: {
//    scroll(orientation: number) {
//      const contents = this.$refs.contents as HTMLElement
//      const style = getComputedStyle(contents)
//      const count = parseFloat(style.getPropertyValue('--card-count'))
//      const width = parseFloat(style.getPropertyValue('--card-width'))
//      const gap = 16
//      const distance = count * (width + gap)
//      contents.scrollBy(orientation * distance, 0)
//    }
//  },
//  async created() {
//    const { getTrendingVideos } = await import('../trending-videos')
//    this.trendingCards = getTrendingVideos()
//  },
//  async mounted() {
//    // let cancelHorizontalScroll: () => void
//    // addSettingsListener('simpleHomeWheelScroll', async (value: boolean) => {
//    //   if (value) {
//    //     const contents = this.$refs.contents as HTMLElement
//    //     const { enableHorizontalScroll } = await import('../../../utils/horizontal-scroll')
//    //     cancelHorizontalScroll = enableHorizontalScroll(contents)
//    //   } else {
//    //     cancelHorizontalScroll && cancelHorizontalScroll()
//    //   }
//    // }, true)
//    //
//    // // 等内容上去了再添加 snap 特性, 不然不知道为啥会错位
//    // const contents = this.$refs.contents as HTMLElement
//    // await SpinQuery.condition(() => contents, () => contents.childElementCount > 0)
//    // resources.applyImportantStyleFromText(`
//    //   .simple-home.snap .trendings .contents {
//    //     scroll-snap-type: x mandatory;
//    //   }
//    // `, 'trending-videos-snap-fix')
//  },
//}
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
