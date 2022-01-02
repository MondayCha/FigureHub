<template>
  <div>
    <a-modal
      :visible="visible"
      title="修改项目"
      okText="修改"
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
      destroyOnClose
    >
      <a-form layout="vertical" :form="form">
        <a-form-item v-show="false" label="roleId">
          <a-input
            type="textarea"
            v-decorator="['roleId', { initialValue: recorder.roleId }]"
          />
        </a-form-item>
        <a-form-item label="角色名称">
          <a-input
            v-decorator="[
              'roleName',
              {
                rules: [{ required: true, message: '角色名称不能为空！' }],
                initialValue: recorder.roleName,
              },
            ]"
          />
        </a-form-item>
        <a-form-item label="角色性别">
          <a-radio-group
            v-decorator="[
              'gender',
              {
                initialValue: ''+ recorder.gender,
              },
            ]"
          >
            <a-radio value="2">女</a-radio>
            <a-radio value="1">男</a-radio>
            <a-radio value="0">未知</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="角色介绍">
          <a-input
            type="textarea"
            v-decorator="['intro', { initialValue: recorder.intro }]"
          />
        </a-form-item>
        <a-form-item label="作品">
          <a-input
              v-decorator="['workName', { initialValue: recorder.workName }]" />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
export default {
  props: ["visible","recorder"],
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "update_form_in_modal2",
    });
  },
};
</script>
<style>
</style>
