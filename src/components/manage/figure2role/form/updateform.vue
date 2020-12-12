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
              'relaId',
              { initialValue: recorder.relaId },
            ]"
          />
        </a-form-item>
        <a-form-item label="手办名称">
          <a-select
            v-decorator="[
              'fId',
              {
                rules: [{ required: true, message: '手办名称不能为空！' }],
                initialValue: recorder.figureId,
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
                initialValue: recorder.roleId,
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
  </div>
</template>

<script>
export default {
  props: ["visible", "recorder", "roleList", "figureList"],
  data() {
    return {
      selectFigure: "",
      selectRole: "",
    };
  },
  beforeCreate() {
    this.form = this.$form.createForm(this, {
      name: "update_form_in_modal2",
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
