<template>
  <div>
    <MyHeader></MyHeader>
    <div class="login-root">
      <div class="login-center">
        <div class="inner-login">
          <div class="s-skin-container"></div>
          <a-form
              id="login-form"
              :form="form"
              class="login-form"
              @submit="handleSubmit"
          >
            <a-form-item>
              <a-input
                  class="login-form-input"
                  v-decorator="[
          'username',
          { rules: [{ required: true, message: '请输入注册时设置的用户名!' }] },
        ]"
                  placeholder="用户名"
                  autocomplete=off
              >
                <a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)"/>
              </a-input>
            </a-form-item>
            <a-form-item>
              <a-input-password
                  class="login-form-input"
                  v-decorator="[
          'password',
          { rules: [{ required: true, message: '还没有输入密码么？' }] },
        ]"
                  type="password"
                  placeholder="密码"
              >
                <a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)"/>
              </a-input-password>
            </a-form-item>
            <a-form-item>
            <a-space direction="vertical">
              <a-space>
                <a-button type="primary" html-type="submit" class="login-form-button" v-bind:loading="login_loading" shape="round">
                  <b>登录</b>
                </a-button>
                <a-button class="register-form-button" @click="goToRegister" shape="round">注册</a-button>
              </a-space>
              <a-space>
                <a-button class="register-form-button" @click="goToLogin(true)" shape="round">管理员</a-button>
                <a-button class="register-form-button" @click="goToLogin(false)" shape="round">普通用户</a-button>
              </a-space>
            </a-space>
              <!--              <div style="text-align: center">-->
              <!--                没有帐号？-->
              <!--                <a href="javascript: void(0);" @click="goToRegister">-->
              <!--                  现在注册！-->
              <!--                </a>-->
              <!--              </div>-->
            </a-form-item>
          </a-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios_service from "../../../api/request"
import MyHeader from "@/views/layout/myheader";


export default {
  components: {
    MyHeader,
  },
  name: "login",
  beforeCreate() {
    this.form = this.$form.createForm(this, {name: 'normal_login'});
  },
  data: function () {
    return {
      login_loading: false,
      login_error: false,
      userValue: 'c',
    }
  },
  methods: {
    onChange(e) {
      if (e.target.value === 'a') {
        this.defaultValue = {
          name: 'admin',
          password: 'Ruby20211228',
        };
      } else {
        this.defaultValue = {
          name: 'normal',
          password: 'Ruby20211228',
        };
      }
    },
    goToLogin(isAdmin) {
      let data = isAdmin ? {name: 'admin', password: 'Ruby20211228'} : {name: 'normal', password: 'Ruby20211228'};
      let _this = this;
      axios_service.post_with_params(this.$store, "/auth/login", data).then((res) => {
        let nickname = res.detail.nickname;
        let type = res.detail.kind;
        let avatar = this.$global.staticURL + res.detail.avatar;
        let username = data.name;
        this.$store.commit('login', {'nickname': nickname, 'type': type, 'avatar': avatar, 'username': username});
        console.log(nickname);
        this.showSuccessMessage("登录成功，正在跳转");
        this.$router.back();
      }).catch((err) => {
        _this.login_loading = false;
        try {
          this.showErrorNotification(err.message);
        } catch (e) {
          console.log(e);
          this.showErrorNotification("ERROR");
        }
      })
    },
    handleSubmit(e) {
      e.preventDefault();
      let _this = this;
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log('Received values of form: ', values);
          _this.login_loading = true;
          let data = {
            name: values.username,
            password: values.password,
          }
          //
          axios_service.post_with_params(this.$store, "/auth/login", data).then((res) => {
              let nickname = res.detail.nickname;
              let type = res.detail.kind;
              let avatar = this.$global.staticURL + res.detail.avatar;
              let username = data.name;
              this.$store.commit('login', {'nickname': nickname, 'type': type, 'avatar': avatar, 'username': username});
              console.log(nickname);
              this.showSuccessMessage("登录成功，正在跳转");
              this.$router.back();
          }).catch((err) => {
                _this.login_loading = false;
                try {
                  this.showErrorNotification(err.message);
                } catch (e) {
                  console.log(e);
                  this.showErrorNotification("ERROR");
                }
              })
        }
      });
    },
    showErrorNotification(msg) {
      // this.$notification.open({
      //   message: '登录失败',
      //   description: msg,
      //   duration: 3,
      //   icon: <a-icon type="warning" style="color: #ed002f"/>,
      // });
      this.$message.error(msg);
    },
    showSuccessMessage(msg) {
      this.$message.success(msg);
    },
    goToRegister() {
      this.$router.push('/register')
    }
  },
}


</script>

<style scoped>
.login-root {
  font-size: 18px;
  padding-top: 50px;
  min-height: 100%;
}

.login-center {
  margin: 150px 0px 100px 900px;
}

.switch-group {
  width: 100%;
  margin-bottom: 30px;
}

.s-skin-container {
  position: fixed;
  _position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  min-width: 1000px;
  z-index: -10;
  background-color: #fb7299;
  background-image: url("../../../static/picture/81821752_p0.jpg");
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

.inner-login {
  /*border-top-left-radius: 16px;*/
  /*border-top-right-radius: 16px;*/
  /*border-bottom-right-radius: 16px;*/
  /*border-bottom-left-radius: 16px;*/
  background-color: #fff;
  display: inline-block;
  margin: auto;
  padding-top: 32px;
  padding-bottom: 16px;
  border-radius: 16px;
  border-width: 1px;
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.15);
}

.login-form {
  margin: 32px 64px 32px 64px;
}

.login-form-input {
  width: 250px;
}


.login-form-button {
  width: 120px;
}

.register-form-button {
  width: 120px;
}
</style>
