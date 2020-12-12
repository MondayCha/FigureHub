<template>
  <div>
    <MyHeader head_index="1"></MyHeader>
    <div class="img-responsive">
      <img src="@/static/picture/girl_guitar_2560x1024.jpg">
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
<style lang="scss">

.img-responsive{
  max-width: 100%;
  height: 0;
  padding-bottom: 10%;
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
