<template>
  <div>
    <div class="s-skin-container"></div>
    <div style="margin-bottom: 50px">
      <MyHeader></MyHeader>
    </div>
    <div class="register-root">
      <div class="steps">
        <a-steps :current="current_step">
          <a-step title="账户信息"/>
          <a-step title="个人信息"/>
          <a-step title="完成"/>
        </a-steps>
      </div>
      <div class="register-info">
        <a-form-model ref="registerForm" :model="registerForm" :rules="rules" v-bind="layout">
          <template v-if="current_step === 0">
            <a-form-model-item has-feedback label="用户名" prop="username">
              <a-input v-model="registerForm.username"/>
            </a-form-model-item>
            <!--          <a-form-model-item has-feedback label="邮箱" prop="email">-->
            <!--            <a-input v-model="registerForm.email" />-->
            <!--          </a-form-model-item>-->
            <a-form-model-item has-feedback label="密码" prop="pass">
              <a-input v-model="registerForm.pass" type="password" autocomplete="off"/>
            </a-form-model-item>
            <a-form-model-item has-feedback label="确认密码" prop="checkPass">
              <a-input v-model="registerForm.checkPass" type="password" autocomplete="off"/>
            </a-form-model-item>
          </template>

          <template v-if="current_step === 1">
            <a-form-model-item label="昵称" prop="nickname">
              <a-input v-model="registerForm.nickname"/>
            </a-form-model-item>
            <a-form-model-item label="类型" prop="type">
              <a-radio-group default-value="1" button-style="solid" v-model="registerForm.type">
                <a-radio-button value="1">
                  注册用户
                </a-radio-button>
                <a-radio-button value="0">
                  管理员
                </a-radio-button>
                <a-radio-button value="2">
                  厂商用户
                </a-radio-button>
              </a-radio-group>
            </a-form-model-item>
            <a-form-model-item label="头像" prop="avatar">
              <a-upload
                  name="avatar"
                  list-type="picture-card"
                  class="avatar-uploader"
                  :show-upload-list="false"
                  :before-upload="beforeUpload"
                  @change="handleChange"
              >
                <img v-if="imageUrl" :src="imageUrl" alt="avatar" width="200"/>
                <div v-else>
                  <a-icon type="plus"/>
                  <div class="ant-upload-text">
                    Upload
                  </div>
                </div>
              </a-upload>
            </a-form-model-item>
          </template>

          <div class="button-container">
            <a-form-model-item>
              <div class="button-container">
                <div>
                  <a-button class="button" @click="previousStep" v-if="current_step == 1">
                    <a-icon type="left"/>
                    后退
                  </a-button>
                </div>
                <div>
                  <a-button type="primary" class="button" @click="nextStep" v-if="current_step == 0">
                    下一步
                    <a-icon type="right"/>
                  </a-button>
                </div>
                <div class="submit">
                  <a-button type="primary" class="button" @click="doSubmit" :loading="submitting"
                            v-if="current_step == 1">
                    提交
                    <a-icon type="right" v-if="!submitting"/>
                  </a-button>
                </div>
              </div>
            </a-form-model-item>
          </div>
        </a-form-model>
      </div>

      <div class="result" v-if="current_step == 2">
        <a-result
            status="success"
            title="注册成功~"
            sub-title="欢迎加入FigureHub!"
        >
          <template #extra>
            <a-button key="console" type="primary" @click="goToLogin">
              返回
            </a-button>
          </template>
        </a-result>
      </div>
    </div>
  </div>
</template>

<script>

import axios_service from "../../../api/request"
import MyHeader from "@/views/layout/myheader";


function getBase64(img, callback) {
  const reader = new FileReader();
  reader.addEventListener('load', () => callback(reader.result));
  reader.readAsDataURL(img);
}

export default {
  name: "Register",
  components: {
    MyHeader,
  },
  data: function () {
    let validateUsername = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入用户名'));
      } else {
        callback();
      }
    };
    let validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'));
      } else if (value.length < 8) {
        callback(new Error('密码至少应为8位'));
      } else {
        if (this.registerForm.checkPass !== '') {
          this.$refs.registerForm.validateField('checkPass');
        }
        callback();
      }
    };
    let validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.registerForm.pass) {
        callback(new Error("两次密码输入不一致！"));
      } else {
        callback();
      }
    };
    let validateEmail = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入邮箱'));
      } else if (!value.includes("@") || !value.includes(".")) {
        callback(new Error("邮箱格式错误！"));
      } else {
        callback();
      }
    };
    // let validateBirthday = (rule, value, callback) => {
    //   if (!value || value === '') {
    //     callback(new Error('请输入生日'));
    //   } else {
    //     callback();
    //   }
    // };
    return {
      current_step: 0,
      submitting: false,
      registerForm: {
        username: '',
        // email: '',
        pass: '',
        checkPass: '',
        nickname: '',
        // gender: 'unset',
        sign: '',
        type: 0,
      },
      rules: {
        username: [{validator: validateUsername, trigger: 'change'}],
        // email: [{validator: validateEmail, trigger: 'change'}],
        pass: [{validator: validatePass, trigger: 'change'}],
        checkPass: [{validator: validatePass2, trigger: 'change'}],
        // birthday: [{validator: validateBirthday, trigger: 'change'}],
      },
      layout: {
        labelCol: {span: 6},
        wrapperCol: {span: 16},
      },
      file: null,
      imageUrl: null,
    };
  },
  methods: {
    previousStep() {
      this.current_step = 0;
    },
    nextStep() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.current_step = 1;
        } else {
          return false;
        }
      });
    },
    checkFile(file) {
      const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
      if (!isJpgOrPng) {
        this.$message.error('请上传 JPG/PNG 文件!');
      }
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isLt2M) {
        this.$message.error('图片大小应小于 2MB!');
      }
      return isJpgOrPng && isLt2M;
    },
    doSubmit() {
      let _this = this;
      this.$refs.registerForm.validate(valid => {
        if (valid && this.checkFile(_this.file)) {
          _this.submitting = true;
          let params = {
            username: _this.registerForm.username,
            password: _this.registerForm.pass,
            nickname: _this.registerForm.nickname,
            type: _this.registerForm.type,
          }
          axios_service.register(_this.store, "/user/register", params, _this.file)
              .then((res) => {
                _this.submitting = false;
                if ('error_code' in res && res['error_code'] != 0) {
                  return Promise.reject(res);
                }
                _this.current_step = 2;
              })
              .catch((err) => {
                _this.submitting = false;
                console.log(err);
                this.$message.error("注册失败");
                // this.$notification.open({
                //   message: '注册失败',
                //   description: err.error_msg,
                //   duration: 0,
                //   icon: <a-icon type="warning" style="color: #ed002f"/>,
                // });
              })
        } else {
          return false;
        }
      });
    },
    beforeUpload(file, fileList) {
      let _this = this;
      getBase64(file, imageUrl => {
        _this.imageUrl = imageUrl;
      });
      return false;
    },
    handleChange(info) {
      console.log(info)
      let _this = this;
      this.file = info.file;
      getBase64(info.file, imageUrl => {
        _this.imageUrl = imageUrl;
      });
    },
    goToLogin() {
      this.$router.back();
    },
  }
}
</script>

<style scoped>
.s-skin-container {
  position: fixed;
  _position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  min-width: 1000px;
  z-index: -10;
  background-color: #cfe8fc;
  /*background-image: url("../../static/picture/floppies0005.png");*/
  background-position: center 0;
  background-repeat: repeat;
  background-size: cover;
  -webkit-background-size: cover;
  -o-background-size: cover;
  zoom: 1;
  animation: anim 25s linear infinite;
}
@keyframes anim {
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}

.register-root {
  background-color: #fff;
  padding: 32px;
  width: 80%;
  margin: 0 auto;
  text-align: left;
  border-radius: 16px;
  border-color: hsv(0, 0, 85%);
  border-width: 1px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
}

.steps {
  margin: 0 auto;
}

.register-info {
  margin: 32px auto;
  width: 60%;
}

.button-container {
  margin: 0 auto;
  display: flex;
  justify-content: space-around;
}

.button {
  margin: 0px 0px 0px 16px;
}

</style>
