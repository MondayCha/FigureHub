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
      <a-form-item label="作品名称">
        <a-input
          v-decorator="[
            'workName',
            {
              rules: [{ required: true, message: '角色名称不能为空！' }],
            },
          ]"
        />
      </a-form-item>
      <!-- <a-form-item label="gender">
        <a-input v-decorator="['gender']" />
      </a-form-item> -->
      <a-form-item label="作品类型">
        <a-radio-group
          v-decorator="[
            'kind',
            {
              // initialValue: '0',
            },
          ]"
        >
          <a-radio value="3">小说</a-radio>
          <a-radio value="2">游戏</a-radio>
          <a-radio value="1">漫画</a-radio>
          <a-radio value="0">动漫</a-radio>
        </a-radio-group>
      </a-form-item>
      <a-form-item label="作品介绍">
        <a-input type="textarea" v-decorator="['intro']" />
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
