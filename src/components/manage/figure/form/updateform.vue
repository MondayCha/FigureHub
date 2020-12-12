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
        <a-form-item v-show="false" label="figureId">
          <a-input
            type="textarea"
            v-decorator="['figureId', { initialValue: recorder.figureId }]"
          />
        </a-form-item>
        <a-form-item label="模型名称">
          <a-input
            v-decorator="[
              'figureName',
              {
                rules: [{ required: true, message: '模型名称不能为空！' }],
                initialValue: recorder.figureName,
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
                initialValue: recorder.figureType,
              },
            ]"
            style="width: 100%"
            @change="selectChange"
          >
            <a-select-option
            v-for="typeCode in list"
            :value="typeCode.id"
            :key="typeCode.id"
            >{{ typeCode.name }}</a-select-option
          >
          </a-select>
        </a-form-item>
        <a-form-item label="模型价格">
          <a-input
            v-decorator="[
              'price',
              {
                rules: [{ pattern: /^\d*$/, message: '模型价格应该是数字！' }],
                initialValue: recorder.price,
              },
            ]"
          />
        </a-form-item>
        <a-form-item label="模型比例">
          <a-input
            v-decorator="[
              'prop',
              {
                initialValue: recorder.prop,
              },
            ]"
          />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
export default {
  props: ["visible", "recorder"],
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "update_form_in_modal2",
    });
  },
  data() {
    return {
      selectType: "",
      list:[
        {id:1,name:"GK手办"},
        {id:2,name:"PVC手办"},
        {id:3,name:"可动手办"},
        {id:4,name:"景品手办"},
        {id:5,name:"粘土人"},
        {id:0,name:"未知"},
    ],
    };
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
