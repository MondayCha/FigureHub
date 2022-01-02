<template>
  <a-modal
    :visible="visible"
    title="创建新项目"
    okText="创建"
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
    <a-form layout="vertical" :form="form">
      <a-form-item label="角色名称">
        <a-input
          v-decorator="[
            'roleName',
            {
              rules: [{ required: true, message: '角色名称不能为空！' }],
            },
          ]"
        />
      </a-form-item>
      <!-- <a-form-item label="gender">
        <a-input v-decorator="['gender']" />
      </a-form-item> -->
      <a-form-item label="角色性别">
        <a-radio-group
          v-decorator="[
            'gender',
            {
              // initialValue: '0',
            },
          ]"
        >
          <a-radio value="2">女</a-radio>
          <a-radio value="1">男</a-radio>
          <a-radio value="0">未知</a-radio>
        </a-radio-group>
      </a-form-item>
      <a-form-item label="角色介绍">
        <a-input type="textarea" v-decorator="['intro']" />
      </a-form-item>
      <a-form-item label="作品">
        <a-input type="textarea" v-decorator="['workName']" />
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script>
export default {
  props: ["visible"],
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "form_in_modal",
    });
  },
};
</script>

<style>
</style>
