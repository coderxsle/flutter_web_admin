<template>
  <a-tag v-if="gender === '1'" color="arcoblue" class="g-round">
    <template #icon><icon-man /></template>
    <template #default>男</template>
  </a-tag>
  <a-tag v-if="gender === '2'" color="purple" class="g-round">
    <template #icon><icon-woman /></template>
    <template #default>女</template>
  </a-tag>
  <a-tag v-if="gender === '3'" color="gray" class="g-round">
    <template #icon><icon-lock /></template>
    <template #default>保密</template>
  </a-tag>
</template>

<script lang="ts" setup>
defineOptions({ name: 'GiCellGender' })

const props = withDefaults(defineProps<Props>(), {
  gender: '1'
})

interface Props {
  gender?: Gender | string
}

const gender = computed(() => String(props.gender))
</script>

<style lang="scss" scoped></style>
