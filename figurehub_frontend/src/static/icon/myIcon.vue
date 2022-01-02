<template>
  <div class="custom-icons-list">
    <heart-icon :style="{ color: 'hotpink' }" />
  </div>
</template>
<script>
const HeartSvg = {
  template: `
    <svg t="1607702962998" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1194" xmlns:xlink="http://www.w3.org/1999/xlink" width="200" height="200">
    <defs>
        <style type="text/css"></style>
    </defs>
    <path d="M586.4 635.9h133.3c8.6 0 15.5 6.9 15.5 15.5V774c0 8.6-6.9 15.5-15.5 15.5H586.4v123.3c0 8.6-6.9 15.5-15.5 15.5H453.1c-8.6 0-15.5-6.9-15.5-15.5V789.5H304.4c-8.6 0-15.5-6.9-15.5-15.5V651.3c0-8.6 6.9-15.5 15.5-15.5h133.2V559H304.4c-8.6 0-15.5-6.9-15.5-15.5V420.9c0-8.6 6.9-15.5 15.5-15.5h133.2L232.4 122.8c-7.4-10.2-0.1-24.6 12.5-24.6h110.8c4.8 0 9.4 2.2 12.3 6.1l144 187.6 145-187.7c2.9-3.8 7.5-6 12.3-6h109.8c12.7 0 20 14.4 12.5 24.6L586.2 405.4h133.4c8.6 0 15.5 6.9 15.5 15.5v122.6c0 8.6-6.9 15.5-15.5 15.5H586.4v76.9z" p-id="1195"></path>
</svg>
  `,
};

const HeartIcon = {
  template: `
    <a-icon :component="HeartSvg" />
  `,
  data() {
    return {
      HeartSvg,
    };
  },
};

export default {
  components: {
    HeartIcon,
  },
};
</script>
<style scoped>
.custom-icons-list >>> .anticon {
}
</style>
