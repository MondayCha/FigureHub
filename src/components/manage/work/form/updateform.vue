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
        <a-form-item label="作品名称">
          <a-input
            v-decorator="[
              'workName',
              {
                rules: [{ required: true, message: '名称不能为空！' }],
                initialValue: recorder.roleName,
              },
            ]"
          />
        </a-form-item>
        <a-form-item label="作品类型">
          <a-radio-group
            v-decorator="[
              'kind',
              {
                initialValue: ''+ recorder.gender,
              },
            ]"
          >
            <a-radio value="3">小说</a-radio>
            <a-radio value="2">游戏</a-radio>
            <a-radio value="1">漫画</a-radio>
            <a-radio value="0">动漫</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item label="介绍">
          <a-input
            type="textarea"
            v-decorator="['intro', { initialValue: recorder.intro }]"
          />
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
