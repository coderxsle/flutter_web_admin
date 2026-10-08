<template>
  <!-- 本地自定义图标（裸名，如 menu-analyse / menu-home）：映射到 custom 图标集，沿用旧版 24px -->
  <Icon v-if="isLocalIcon" :icon="`custom:${props.icon}`" :width="LOCAL_ICON_SIZE" :height="LOCAL_ICON_SIZE" />
  <!-- icon-park 图标与显式 custom: 图标 -->
  <Icon v-else-if="isIconifyIcon" :icon="props.icon" :width="16" :height="16" />
  <!-- Arco 图标组件（如 icon-home） -->
  <component :is="props.icon" v-else-if="props?.icon && props?.icon?.startsWith('icon')" :size="24">
  </component>
  <!-- 其它 Iconify 集合（如 mdi:home） -->
  <Icon v-else-if="props?.icon" :icon="props.icon" :width="24" :height="24" />
</template>

<script lang="ts" setup>
import { Icon } from '@iconify/vue'

interface Props {
  icon?: string
}

const props = withDefaults(defineProps<Props>(), {
  icon: ''
})

/** 本地自定义图标尺寸（与旧版 GiSvgIcon 的 :size="24" 保持一致） */
const LOCAL_ICON_SIZE = 24

/** icon-park 与显式 custom: 前缀的图标 */
const isIconifyIcon = computed(() => {
  return !!props.icon && (props.icon.startsWith('icon-park') || props.icon.startsWith('custom:'))
})

/**
 * 本地自定义图标裸名，例如 menu-analyse、menu-home、arco、vite
 * @description 这类值不带集合前缀，历史上由 GiSvgIcon + vite-plugin-svg-icons 渲染；
 * 上游改为 Iconify 自定义图标集后统一映射为 custom: 前缀，
 * 这样后端/菜单数据里的裸名无需改动即可继续渲染
 */
const isLocalIcon = computed(() => {
  return !!props.icon && !props.icon.startsWith('icon') && !props.icon.includes(':')
})
</script>

<style lang="scss" scoped></style>
