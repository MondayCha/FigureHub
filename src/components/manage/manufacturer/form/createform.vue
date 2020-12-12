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
      <a-form-item label="厂商名称">
        <a-input
          v-decorator="[
            'manuName',
            {
              rules: [{ required: true, message: '厂商名称不能为空！' }],
            },
          ]"
        />
      </a-form-item>
      <!-- 			<a-form-item label='manuName'>
				<a-input v-decorator="['manuName']" />
			</a-form-item> -->
      <a-form-item label="厂商主页">
        <a-input type="textarea" v-decorator="['manuLink']" />
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
