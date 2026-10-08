<template>
  <GiPageLayout margin>
    <a-empty :description="`${title}功能正在建设中`" />
  </GiPageLayout>
</template>

<script setup lang="ts">
defineOptions({ name: 'ZhongyiPlaceholder' })

withDefaults(defineProps<{ title?: string }>(), {
  title: '该页面'
})
</script>
