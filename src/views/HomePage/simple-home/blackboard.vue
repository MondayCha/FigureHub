<template>
  <div class="blackboards">
    <div class="header">
      <!--      <a-button @click="updateIndex"></a-button>-->
      <div class="title">今日推荐</div>
      <a class="more" @click="routeToShop" target="_blank">
        <a-icon class="be-icon" type="ellipsis"/>
        更多
      </a>
    </div>
    <input
        class="hidden-input"
        type="radio"
        name="blackboard"
        v-for="(b, i) of blackboards"

        :checked="i === 0"
        :id="'blackboard' + i"
        :data-index="i"
        :key="i"
    />
    <div class="blackboard-cards">
      <a
          class="blackboard-card"
          target="_blank"
          v-for="(b, i) of blackboards"
          :key="i"
          :href="b.url"
          :title="b.title"
      >
        <img :src="b.imageUrl" style="width: 100%; max-width: 100%; height: auto;"/>
        <div class="title">{{ b.title }}</div>
      </a>
    </div>
    <div class="jump-dots">
      <label v-for="(b, i) of blackboards" :for="'blackboard' + i" :key="i">
        <div class="jump-dot"></div>
      </label>
    </div>
  </div>
</template>

<script>
import axios_service from "@/api/request";

export default {
  components: {
    matIcon: () => import('../../icon.vue'),
    'dpi-img': () => import('../../dpi-img.vue'),
  },
  data() {
    return {
      val: [false, true, false],
      blackboards: [
        {
          title: "剧场版动画《刀剑神域 进击篇》即将在2021年上映",
          url: "http://localhost:2333/ImgStore/LIGHT%20Insanae.jpg",
          imageUrl: this.$global.staticURL + "亚斯娜1.jpg",
        },
        {
          title: "剧场版动画《刀剑神域 进击篇》即将在2021年上映",
          url: this.$global.wikiURL + "亚斯娜2.jpg",
          imageUrl: "http://localhost:2333/ImgStore/LIGHT%20Insanae.jpg",
        },
        {
          title: "剧场版动画《刀剑神域 进击篇》即将在2021年上映",
          url: this.$global.staticURL + "亚斯娜3.jpg",
          imageUrl: this.$global.staticURL + "亚斯娜3.jpg",
        },
      ],
      interval: 0,
      inputIndex: 0,
    }
  },
  created() {
    axios_service.get("roleimg/selectAll", null).then((res) => {
      console.log(res);

    });
  },
  methods: {
    routeToShop() {
      this.$router.push("/market");
    },
    updateIndex() {
      // // console.log("click button");
      // var boards = document.getElementsByClassName('hidden-input');
      // // console.log(boards);
      // let targetIndex = 0
      // for (let i = 0; i < boards.length; i++) {
      //   if (boards[i].checked === true) {
      //     boards[i].checked = false;
      //     targetIndex = (i + 1) % boards.length;
      //     boards[targetIndex].checked = true;
      //     break;
      //   }
      // }
    },
  },
  watch: {
    $route(to, from) {
      clearInterval(this.interval);
    }
  },
  async mounted() {
    // var mtime;
    // var show = function () {
    //   this.updateIndex();
    //   clearTimeout(mtime);
    //   mtime = setTimeout(show,1000);
    // }
    // mtime = setTimeout(show,1000);
    this.interval = setInterval(() => {
      let boards = document.getElementsByClassName('hidden-input');
      let targetIndex = 0
      for (let i = 0; i < boards.length; i++) {
        if (boards[i].checked === true) {
          boards[i].checked = false;
          targetIndex = (i + 1) % boards.length;
          boards[targetIndex].checked = true;
          break;
        }
      }
    }, 5000);
    window.onresize = function () {
      clearInterval(this.interval);
    }
  }
}
</script>
<style lang="scss">
$first-row-height: 250px;
.hidden-input {
  display: none;
  @for $i from 1 to 16 {
    &:checked:nth-of-type(#{$i})
    ~ .jump-dots
    label:nth-child(#{$i})
    .jump-dot {
      background-color: #00A0D8;
      height: 40px;
    }
    &:checked:nth-of-type(#{$i}) ~ .blackboard-cards .blackboard-card {
      transform: translateY(calc(-1 * #{$i - 1} * var(--blackboard-height)));
    }
  }
}

.simple-home .blackboards {
  position: relative;
  display: grid;
  grid-template-areas: 'header header' 'cards cards';
  grid-template-columns: 8px 1fr;
  grid-template-rows: 1fr $first-row-height;
  row-gap: 16px;
  column-gap: 16px;
  align-self: start;

  .jump-dots {
    position: absolute;
    top: 50%;
    left: 8px;
    transform: translateY(-50%);
    grid-area: cards;
    align-self: center;
    justify-self: center;

    & label {
      display: block;
    }

    & label:not(:last-child) {
      margin-bottom: 6px;
    }

    .jump-dot {
      background-color: #8884;
      border: 1px solid #8888;
      box-sizing: border-box;
      width: 8px;
      height: 20px;
      border-radius: 8px;
      cursor: pointer;
    }
  }

  .blackboard-cards {
    grid-area: cards;
    --blackboard-width: 568.5px;
    --blackboard-height: 250px;
    width: var(--blackboard-width);
    height: var(--blackboard-height);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 8px 0 #0001;

    .blackboard-card {
      width: 100%;
      height: 100%;
      position: relative;
      display: block;
      transition: 0.3s cubic-bezier(0.65, 0.05, 0.36, 1);

      img {
        width: 100%;
        height: 100%;
        object-fit: fill;
        display: block;
      }

      .title {
        position: absolute;
        bottom: 8px;
        left: 50%;
        transform: translateX(-50%);
        padding: 4px 16px;
        color: white;
        background-color: #000a;
        font-size: 14px;
        font-weight: bold;
        border-radius: 14px;
        white-space: nowrap;
        opacity: 0;
      }

      &:hover .title {
        opacity: 1;
      }
    }
  }
}
</style>
