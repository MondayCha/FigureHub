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
      <a-form-item label="模型名称">
        <a-input
          v-decorator="[
            'figureName',
            {
              rules: [{ required: true, message: '模型名称不能为空！' }],
            },
          ]"
        />
      </a-form-item>
      <a-form-item label="模型类型">
        <a-select
          v-decorator="[
            'figureType',
            {
              setFieldsValue: selectType,
            },
          ]"
          style="width: 100%"
          @change="selectChange"
        >
          <a-select-option value="1"> GK手办 </a-select-option>
          <a-select-option value="2"> PVC手办 </a-select-option>
          <a-select-option value="3"> 可动手办 </a-select-option>
          <a-select-option value="4"> 景品手办 </a-select-option>
          <a-select-option value="5"> 粘土人 </a-select-option>
          <a-select-option value="0"> 未知 </a-select-option>
        </a-select>
      </a-form-item>
      <a-form-item label="模型价格">
        <a-input
          v-decorator="[
            'price',
            { rules: [{ pattern: /^\d*$/, message: '模型价格应该是数字！' }] },
          ]"
        />
      </a-form-item>
      <a-form-item label="模型比例">
        <a-input v-decorator="['prop']" />
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script>
export default {
  props: ["visible"],
  data() {
    return {
      selectType: "",
    };
  },
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "form_in_modal",
    });
  },
  methods: {
    selectChange(value) {
      this.selectType = value;
    },
  },
};
</script>

<style>
</style>
