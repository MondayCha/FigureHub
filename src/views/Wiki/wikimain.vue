<template >
  <a-list item-layout="vertical" size="large" :pagination="pagination" :data-source="data">
    <!--    <div slot="footer"><b>ant design vue</b> footer part</div>-->
    <a-list-item slot="renderItem" key="item.roleId" slot-scope="item, index">
      <template v-for="{ type, text } in actions" slot="actions">
        <span :key="type">
          <a-icon :type="type" style="margin-right: 8px"/>
          {{ text }}
        </span>
      </template>
      <img
          slot="extra"
          width="272"
          height="300"
          style="object-fit: cover"
          alt="logo"
          :src="item.src"
      />
      <a-list-item-meta :description="item.intro">
        <div slot="title" @click="jumpToRole(item.roleId)">{{ item.roleName }}</div>
        <!--        <a-avatar slot="avatar" :src="item.avatar"/>-->
      </a-list-item-meta>
    </a-list-item>
  </a-list>
</template>
<script>
import axios_service from "@/api/request";

const listData = [];
for (let i = 0; i < 23; i++) {
  listData.push({
    href: 'https://www.antdv.com/',
    title: `ant design vue part ${i}`,
    avatar: 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png',
    description:
        'Ant Design, a design language for background applications, is refined by Ant UED Team.',
    content:
        'We supply a series of design principles, practical patterns and high quality design resources (Sketch and Axure), to help people create their product prototypes beautifully and efficiently.',
  });
}

export default {
  data() {
    return {
      listData,
      pagination: {
        onChange: page => {
          console.log(page);
        },
        pageSize: 3,
      },
      actions: [
        {type: 'star-o', text: '156'},
        {type: 'like-o', text: '156'},
        {type: 'message', text: '2'},
      ],
      data: [],
    };
  },
  created() {
    let _this = this;
    axios_service.get("/role/selectAll", null).then((res) => {
      //将返回的数据存入页面中声明的data中
      console.log(res);
      _this.data = res;
      _this.data[0].src='http://localhost:2333/ImgStore/%E4%BA%9A%E6%96%AF%E5%A8%9C3.jpg';
      _this.data[1].src='http://localhost:2333/ImgStore/%E5%88%9D%E9%9F%B3%E6%9C%AA%E6%9D%A53.jpg';
      _this.data[2].src='http://localhost:2333/ImgStore/4.jpg';
      _this.formData();
    });
  },
  methods: {
    formData() {
      for (let i = 0; i < this.data.length; i++) {
        console.log(this.data[i].gender);
        let tmp_gender = this.data[i].gender;
        if (tmp_gender == 2) {
          this.data[i].genderStr = "女";
        } else if (tmp_gender == 1) {
          this.data[i].genderStr = "男";
        } else {
          this.data[i].genderStr = "未知";
        }
      }
    },
  }
};
</script>
<style></style>
