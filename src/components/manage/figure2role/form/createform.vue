<template>
  <a-modal
    :visible="visible"
    title="添加新关联"
    okText="添加"
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
      <a-form-item label="手办名称">
        <a-select
          v-decorator="[
            'fId',
            {
              rules: [{ required: true, message: '手办名称不能为空！' }],
              setFieldsValue: selectFigure,
            },
          ]"
          style="width: 100%"
          @change="selectChange"
        >
          <a-select-option
            v-for="figure in figureList"
            :value="figure.figureId"
            :key="figure.figureId"
            >{{ figure.figureName }}</a-select-option
          >
        </a-select>
      </a-form-item>
      <a-form-item label="对应角色">
        <a-select
          style="width: 100%"
          @change="selectChange1"
          v-decorator="[
            'rId',
            {
              rules: [{ required: true, message: '对应角色不能为空！' }],
              setFieldsValue: selectRole,
            },
          ]"
        >
          <a-select-option
            v-for="role in roleList"
            :value="role.roleId"
            :key="role.roleId"
            >{{ role.roleName }}</a-select-option
          >
        </a-select>
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script>
export default {
  props: ["visible", "roleList", "figureList"],
  data() {
    return {
      selectFigure: "",
      selectRole: "",
    };
  },
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "form_in_modal",
    });
  },
  methods: {
    selectChange(value) {
      this.selectFigure = value;
    },
    selectChange1(value) {
      this.selectRole = value;
    },
  },
};
</script>

<style>
</style>
