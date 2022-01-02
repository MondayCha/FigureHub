<template>
  <a-modal
      :visible="visible"
      title="上传图片"
      okText="上传"
      cancelText="取消"
      @cancel="
      () => {
        $emit('cancel');
      }
    "
      @ok="
      () => {
        $emit('create');
      }
    "
  >
    <div class="clearfix">
      <a-upload
          name="uploadImg"
          list-type="picture-card"
          class="form-uploader"
          :file-list="fileList"
          :before-upload="beforeUpload"
          @change="handleChange"
      >
        <div v-if="fileList.length < 9">
          <a-icon type="plus"/>
          <div class="ant-upload-text">
            Upload
          </div>
        </div>
      </a-upload>
      <a-modal :visible="previewVisible" :footer="null" @cancel="handleCancel">
        <img alt="example" style="width: 100%" :src="previewImage"/>
      </a-modal>
    </div>
  </a-modal>
</template>

<script>
import axios_service from "../../api/request"

function getBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
  });
}

export default {
  props: ["visible", "recorder"],
  data() {
    return {
      previewVisible: false,
      previewImage: '',
      fileList: [],
      url_id: "",
    };
  },
  methods: {
    handleCancel() {
      this.previewVisible = false;
    },
    async handlePreview(file) {
      if (!file.url && !file.preview) {
        file.preview = await getBase64(file.originFileObj);
      }
      this.previewImage = file.url || file.preview;
      this.previewVisible = true;
    },
    beforeUpload(file, fileList) {
      let _this = this;
      getBase64(file, imageUrl => {
        _this.imageUrl = imageUrl;
      });
      return false;
    },
    handleChange({fileList}) {
      this.fileList = fileList;
    },
  },
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "uploadPicture",
    });
  },
};
</script>

<style>
/* you can make up upload button and sample style by using stylesheets */
.ant-upload-select-picture-card i {
  font-size: 32px;
  color: #999;
}

.ant-upload-select-picture-card .ant-upload-text {
  margin-top: 8px;
  color: #666;
}
</style>
