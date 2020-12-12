<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
  created () {
    //在页面加载时读取sessionStorage里的状态信息
    if (sessionStorage.getItem("store") ) {
      this.$store.replaceState(Object.assign({}, this.$store.state,JSON.parse(sessionStorage.getItem("store"))))
    }
    //在页面刷新时将vuex里的信息保存到sessionStorage里
    window.addEventListener("beforeunload",()=>{
      sessionStorage.setItem("store",JSON.stringify(this.$store.state))
    })
  }
}
</script>

<style lang="scss">
#app{
  //background-color: #ffffff;
  height: 100%;
}
::-webkit-scrollbar {
  width: 0.5rem;
}
/* Track */

::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(207,232,252,0.8);
  -webkit-border-radius: 10px;
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  background: rgba(251,114,153, 0.5);
  -webkit-box-shadow: inset 0 0 6px rgba(207,232,252,0.8);
}
::-webkit-scrollbar-thumb:window-inactive {
  background: rgba(169,169,169,0.4);
}
</style>
