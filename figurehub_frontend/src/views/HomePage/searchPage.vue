<template>
  <div>
    <MyHeader></MyHeader>
    <div>
      {{this.value}}
    </div>
  </div>
</template>

<script>
export default {
  name: "searchPage",
  components: {
    'MyHeader': () => import('../layout/myheader')
  },
  data: function () {
    return {
      value: "",
    };
  },
  methods: {
  },
  watch: {
    $route(to, from) {
      this.value = to.params.id;
    }
  },
  created() {
    this.value = this.$route.params.id;
  }
}
</script>

<style scoped>

</style>
