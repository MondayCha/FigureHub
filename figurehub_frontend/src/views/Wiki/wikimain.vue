<template >
  <a-list :grid="{ gutter: 16, column: 3 }" :data-source="data">
    <a-list-item slot="renderItem" key="item.id" @click="jumpToRole(item.id)" slot-scope="item, index">
      <a-card :title="item.origin_name" class="card">
        <p class="h1title">
          {{ item.name }}
        </p>
      </a-card>
    </a-list-item>
  </a-list>
</template>
<script>
import axios_service from "@/api/request";

export default {
  data() {
    return {
      data: [],
    };
  },
  created() {
    let _this = this;
    axios_service.get("/characters", null).then((res) => {
      //将返回的数据存入页面中声明的data中
      _this.data = res;
    });
  },
  methods: {
    jumpToRole(wikiID){
      this.$router.push(`wiki/characters/${wikiID}`);
    }
  }
};
</script>
<style>
.card {
  cursor: pointer;
  position: relative;
  width: 100%;
  height: 100%;
  margin: 10px 0 10px 0;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px 0 #0001;
  background-color: #ffffff;
}

.card:hover {
  box-shadow: 0 4px 8px 0 #0002;
}

.h1title {
  display: block;
  max-height: 3em;
  word-break: break-all;
  line-height: 1.5;
  font-size: 16pt;
  color: #fb7299;
  font-weight: bold;
  padding: 3px 12px 0;
  overflow: hidden;
  text-overflow: ellipsis; /*文字溢出的部分隐藏并用省略号代替*/
  white-space: nowrap;
  /*文本不自动换行*/
  justify-self: stretch;
}
</style>
