<template>
  <div class="simplify-home">
    <component class="simplify-home-component" :is="activeComponent"></component>
  </div>
</template>
<script lang="ts">
export default {
  components: {
    'simple-home': () => import('./simple-home/simple-home.vue'),
  },
  computed: {
    activeComponent () {
      return this.homeStyle === '清爽' ? 'simple-home' : 'minimal-home'
    }
  },
  props: {
    homeStyle: String,
  },
}
</script>
<style lang="scss">
</style>
