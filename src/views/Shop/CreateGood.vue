<template>
  <div>
    <MyHeader head_index="7"></MyHeader>
    <div class="img-responsive">
      <h1 class="h1">发布新商品</h1>
    </div>
    <a-form-model :model="form" :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-form-model-item label="手办名称">
        <a-select @change="selectChange" placeholder="please select your zone">
          <a-select-option v-for="figure in figureList" :value="figure.figureId" :key="figure.figureId">
            {{ figure.figureName }}
          </a-select-option>
        </a-select>
      </a-form-model-item>
      <a-form-model-item has-feedback label="价格" prop="pass">
        <a-input prefix="￥" v-model="form.price" type="number" autocomplete="off"/>
      </a-form-model-item>
      <a-form-model-item label="状态">
        <a-radio-group button-style="solid" v-model="form.type">
          <a-radio-button value="1">
            二手
          </a-radio-button>
          <a-radio-button value="0">
            全新
          </a-radio-button>
        </a-radio-group>
      </a-form-model-item>
      <!--      v-if="form.type=='1'"-->
      <a-form-model-item label="照片">
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
      </a-form-model-item>
      <a-form-model-item :wrapper-col="{ span: 14, offset: 4 }">
        <a-button type="primary" @click="onSubmit" shape="round">
          发布
        </a-button>
        <a-button style="margin-left: 10px;" @click="onCancel" shape="round">
          返回
        </a-button>
      </a-form-model-item>
    </a-form-model>
  </div>
</template>
<script>
import axios_service from "@/api/request";

function getBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
  });
}

export default {
  components: {
    'MyHeader': () => import('../layout/myheader')
  },
  data() {
    return {
      previewVisible: false,
      previewImage: '',
      labelCol: {span: 4},
      wrapperCol: {span: 8},
      form: {
        price: '',
        type: '1',
        selectFigure: "",
      },
      fileList: [],
      figureList: [],
    };
  },

  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "uploadPicture",
    });
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
    onSubmit() {
      let _this = this;
      console.log('submit!', this.form);
      let params = {
        price: this.form.price,
        status: 0,
        type: this.form.type,
      };
      axios_service.post_with_params(this.$store, "merchandise/insert?", params).then((res) => {
        let mid = res.detail.merchandiseId.toString();
        let params2 = {
          merchandiseId: mid,
          figureId: _this.form.selectFigure,
        };
        axios_service.post_with_params(this.$store, "sale/insert?", params2).then(() =>{
          _this.axios_upload(0, mid, _this.fileList).then(() => {
            _this.fileList = [];
            this.$message.success("发布成功");
            this.$router.back();
          }).catch((err) => {
            console.log(err);
            this.$message.error("发布失败");
          });
        }).catch((err) => {
          console.log(err);
          this.$message.error("发布失败");
        });
      }).catch((err) => {
        console.log(err);
        this.$message.error("发布失败");
      })
    },
    axios_upload(index, uid, formList) {
      if (index == formList.length) {
        return;
      }
      let _this = this;
      return axios_service.post_with_file(this.$store, "merchandiseimg/insert?merchandiseId=" + uid, null, formList[index].originFileObj).then((res) => {
        return _this.axios_upload(index + 1, uid, formList);
      });
    },
    onCancel() {
      this.$router.back();
    },
    selectChange(value) {
      this.form.selectFigure = value;
    },
    queryTable() {
      console.log("try figure");
      let _this = this;
      axios_service.get_with_params(this.$store, "/figure/selectAll", null).then((res1) => {
        _this.figureList = res1;
      }).catch(function (error) {
        console.log("figure fail");
      });
    },
  },
  created() {
    this.queryTable();
  }
}
</script>
<style scoped lang="scss">

.form-uploader {
  width: 400px;
}

/* you can make up upload button and sample style by using stylesheets */
.ant-upload-select-picture-card i {
  font-size: 32px;
  color: #999;
}

.ant-upload-select-picture-card .ant-upload-text {
  margin-top: 8px;
  color: #666;
}

.img-responsive {
  max-width: 100%;
  height: 0;
  padding-bottom: 10%;
  margin-bottom: 30px;
  background-color: #fef9ff; /*背景色*/
  overflow: hidden;
  background: url("../../static/picture/girl_guitar_2560x1024.jpg");
  background-position: bottom;
  background-size: cover;

  .h1{
    margin-top: 100px;
    margin-left: 250px;
    color: #ffffff;
    font-weight: bold;
    font-size: 30px;
  }
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
