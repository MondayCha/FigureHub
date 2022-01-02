<template>
  <div>
    <a-modal
      :visible="visible"
      title="我要评论"
      okText="确认"
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
        <a-form-item>
          <a-input
            type="textarea"
            v-decorator="['content',
            {
              rules: [{ required: true, message: '评价不能为空！' }],
            },]"
          />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
export default {
  props: ["visible"],
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "update_form_in_modal2",
    });
  },
};
</script>
<style>
</style>
