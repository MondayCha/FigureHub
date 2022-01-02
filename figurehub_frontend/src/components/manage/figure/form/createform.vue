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
            'name',
            {
              rules: [{ required: true, message: '模型名称不能为空！' }],
            },
          ]"
        />
      </a-form-item>
      <a-form-item label="模型类型">
        <a-select
          v-decorator="[
            'kind',
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
        <a-input v-decorator="['scale']" />
      </a-form-item>
      <a-form-item label="模型厂商">
        <a-select
          style="width: 100%"
          @change="selectChange1"
          v-decorator="[
            'company_id',
            {
              rules: [{ required: true, message: '对应厂商不能为空！' }],
              setFieldsValue: selectCompany,
            },
          ]"
        >
          <a-select-option
            v-for="company in companyList"
            :value="company.id"
            :key="company.id"
            >{{ company.name }}</a-select-option
          >
        </a-select>
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script>
export default {
  props: ["visible", "companyList"],
  data() {
    return {
      selectType: "",
      selectCompany: "",
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
    selectChange1(value) {
      this.selectCompany = value;
    },
  },
};
</script>

<style>
</style>
