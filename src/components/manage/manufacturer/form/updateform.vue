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
        <a-form-item v-show="false" label="manuId">
          <a-input
            type="textarea"
            v-decorator="[
              'manuId',
              { initialValue: recorder.manuId },
            ]"
          />
        </a-form-item>
        <a-form-item label="厂商名称">
          <a-input
            v-decorator="[
              'manuName',
              {
                rules: [{ required: true, message: '厂商名称不能为空！' }],
                initialValue: recorder.manuName,
              },
            ]"
          />
        </a-form-item>
        <a-form-item label="厂商主页">
          <a-input
            type="textarea"
            v-decorator="[
              'manuLink',
              { initialValue: recorder.manuLink },
            ]"
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
      name: "update_form_in_modal1",
    });
  },
};
</script>
<style>
</style>
