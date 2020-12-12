<template>
  <a-breadcrumb style="margin: 16px 0">
    <a-breadcrumb-item>{{first}}</a-breadcrumb-item>
    <a-breadcrumb-item>{{second}}</a-breadcrumb-item>
  </a-breadcrumb>
</template>

<script>
export default {
  name: "Breadcrumb",
  props: {
    first: String,
    second: String,
  },
};
</script>

<style>
</style>