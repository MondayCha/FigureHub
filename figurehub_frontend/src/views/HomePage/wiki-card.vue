<template>
  <a
    class="video-card"
    target="_blank"
    :href="this.data.sale_url"
    :class="{vertical: orientation === 'vertical'}"
  >
    <div class="cover-container">
      <dpi-img class="cover" :src="this.data.coverUrl" :size="{height: 120, width: 200}"></dpi-img>
      <div class="duration">{{this.data.title}}</div>
    </div>
    <h1 class="title" :title="this.data.title">{{this.data.title}}</h1>
    <div class="topics" v-if="topics && topics.length">
      <a
        class="topic"
        v-for="topic of topics.slice(0,3)"
        :key="topic.id"
        target="_blank"
      >#iii#</a>
    </div>
    <p class="description" :title="this.data.title" v-else>{{this.data.title}}</p>
    <a
      class="up"
      :class="{'no-face': !upFaceUrl}"
      target="_blank"
    >
      <dpi-img v-if="this.data.company_url" class="face" :src="this.data.company_url" :size="24"></dpi-img>
      <Icon v-else icon="up" type="extended"></Icon>
      <div class="name" :title="this.data.upname">{{this.data.upname}}</div>
    </a>
    <div class="stats">
    </div>
  </a>
</template>

<script>
export default {
  props: ['data', 'orientation'],
  // store,
  components: {
    'dpi-img': () => import('../dpi-img.vue'),
    Icon: () => import('../icon.vue')
  },
  data() {
    return {
      upFaceUrl: this.$global.staticURL + 'images/眼镜厂.png',
      danmakuCount: '',
      like: '',
      coins: '',
      favorites: '',
      dynamic: '',
      topics: [],
      upID: 0,
      epID: 0,
      // ...(_.omit(this.data, 'watchlater')),
      watchlaterInit: this.data.watchlater
    }
  },
  // computed: {
  //   vertical() {
  //     return this.orientation === 'vertical'
  //   },
  //   ...Vuex.mapState(['watchlaterList']),
  //   watchlater() {
  //     if (getUID() && this.watchlaterInit !== null) {
  //       return this.watchlaterList.includes(this.aid)
  //     } else {
  //       return null
  //     }
  //   }
  // },
  // methods: {
  //   ...Vuex.mapActions(['toggleWatchlater']),
  // }
}
</script>

<style lang="scss">
.video-card {
  display: grid;
  grid-template-columns: 200px 1fr;
  grid-template-rows: 1fr 1fr 1fr;
  grid-template-areas:
    'cover title'
    'cover description'
    'cover up';
  height: var(--card-height);
  width: var(--card-width);
  color: black;
  background-color: #fff;
  border-radius: 16px;
  box-shadow: 0 4px 8px 0 #0001;
  margin-right: var(--card-margin);
  margin-bottom: var(--card-margin);
  position: relative;

  body.dark &,
  body.dark &:hover {
    background-color: #282828;
    color: #eee;
  }
  &:hover {
    color: black;
  }
  &.vertical {
    grid-template-columns: auto auto;
    grid-template-rows: 2fr 1fr 1fr;
    grid-template-areas:
      'cover cover'
      'title title'
      'up up';
    .description,
    .topics {
      display: none;
    }
    .cover-container {
      border-radius: 16px 16px 0 0;
    }
    .title {
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      max-height: 3em;
      word-break: break-all;
      white-space: normal;
      line-height: 1.5;
      font-size: 11pt;
    }
    .up {
      align-self: start;
      white-space: nowrap;
      position: absolute;
      bottom: 12px;
      .name {
        text-overflow: ellipsis;
        overflow: hidden;
      }
      &:not(.no-face) {
        margin-left: 8px;
        max-width: calc(var(--card-width) - 16px);
      }
      &.no-face {
        margin-top: 8px;
        max-width: calc(var(--card-width) - 24px);
      }
    }
    .stats {
      align-self: end;
      justify-self: start;
      margin-bottom: 8px;
      margin-right: 0;
    }
  }
  & > * {
    justify-self: self-start;
    align-self: center;
  }
  &:hover {
    .cover {
      transform: scale(1.05);
      transition: 0.1s cubic-bezier(0.39, 0.58, 0.57, 1);
    }
    .duration,
    .watchlater {
      opacity: 1;
    }
  }
  .duration,
  .watchlater {
    opacity: 0;
  }

  .cover-container {
    grid-area: cover;
    border-radius: 16px 0 0 16px;
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
    .cover {
      object-fit: cover;
      width: 100%;
      height: 100%;
    }
    & > :not(.cover) {
      position: absolute;
    }
    .duration,
    .watchlater {
      bottom: 6px;
      padding: 4px 8px;
      background-color: #000a;
      color: white;
      border-radius: 14px;
      height: 24px;
      box-sizing: border-box;
      .mdi {
        font-size: 12pt;
        line-height: 1;
        margin-right: 4px;
      }
    }
    .duration {
      left: 6px;
    }
    .watchlater {
      right: 6px;
      display: flex;
      align-items: center;
      padding-left: 4px;
    }
  }
  .title {
    grid-area: title;
    font-size: 12pt;
    font-weight: bold;
    color: inherit;
    padding: 0 12px;
    white-space: nowrap;
    overflow: hidden;
    justify-self: stretch;
    text-overflow: ellipsis;
  }
  .topics {
    grid-area: description;
    display: flex;
    align-items: center;
    margin-left: 12px;
    .topic {
      color: inherit;
      padding: 4px 8px;
      background-color: #8882;
      margin-right: 8px;
      border-radius: 14px;
      white-space: nowrap;
      max-width: 120px;
      overflow: hidden;
      text-overflow: ellipsis;
      &:hover {
        background-color: #8884;
        color: var(--theme-color);
      }
    }
  }
  .description {
    grid-area: description;
    color: inherit;
    overflow: hidden;
    align-self: stretch;
    justify-self: stretch;
    margin: 0 12px;
    line-height: 1.5;
    height: 3em;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    scrollbar-width: none !important;

    &::-webkit-scrollbar {
      width: 0px !important;
    }
    &.single-line {
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
    }
  }
  .up,
  .stats {
    grid-area: up;
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
  .stats {
    justify-self: self-end;
    margin-right: 12px;
    display: flex;
    align-items: center;
    opacity: 0.5;
    .be-icon {
      font-size: 12pt;
      margin: 0 4px 0 12px;
      &.be-iconfont-favorites-outline {
        font-size: 14pt;
      }
      &.be-iconfont-coin-outline {
        font-size: 11pt;
      }
    }
  }
}
</style>
