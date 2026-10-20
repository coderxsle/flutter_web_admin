<template>
  <a-drawer v-model:visible="visible" title="操作日志详情" width="min(820px, 92vw)">
    <a-spin :loading="loading" style="width: 100%">
      <a-descriptions :column="{ xs: 1, sm: 1, md: 2 }" bordered size="large">
        <a-descriptions-item label="日志ID">{{ log?.id }}</a-descriptions-item>
        <a-descriptions-item label="操作结果">
          <a-tag v-if="log" :color="log.success ? 'green' : 'red'">{{ log.success ? '成功' : '失败' }}</a-tag>
        </a-descriptions-item>
        <a-descriptions-item label="操作模块">{{ log?.type }}</a-descriptions-item>
        <a-descriptions-item label="操作名">{{ log?.subType }}</a-descriptions-item>
        <a-descriptions-item label="操作内容" :span="2">{{ log?.action }}</a-descriptions-item>
        <a-descriptions-item label="操作人">{{ log?.creator }}</a-descriptions-item>
        <a-descriptions-item label="创建时间">{{ log?.createTime }}</a-descriptions-item>
        <a-descriptions-item label="链路编号" :span="2">{{ log?.traceId }}</a-descriptions-item>
        <a-descriptions-item label="业务ID">{{ log?.bizId }}</a-descriptions-item>
        <a-descriptions-item label="租户ID">{{ log?.tenantId }}</a-descriptions-item>
        <a-descriptions-item label="用户ID">{{ log?.userId }}</a-descriptions-item>
        <a-descriptions-item label="用户类型">{{ log?.userType }}</a-descriptions-item>
        <a-descriptions-item label="用户IP">{{ log?.userIp }}</a-descriptions-item>
        <a-descriptions-item label="请求方法">{{ log?.requestMethod }}</a-descriptions-item>
        <a-descriptions-item label="请求地址" :span="2">{{ log?.requestUrl }}</a-descriptions-item>
        <a-descriptions-item label="浏览器 UA" :span="2">{{ log?.userAgent }}</a-descriptions-item>
      </a-descriptions>

      <div class="operate-log-detail__extra">
        <div class="operate-log-detail__extra-title">拓展字段</div>
        <a-typography-text v-if="!extraSections.length" type="secondary">无</a-typography-text>
        <div v-for="section in extraSections" :key="section.label" class="operate-log-detail__section">
          <div class="operate-log-detail__section-title">{{ section.label }}</div>
          <div v-if="section.code" class="operate-log-detail__code">
            <GiCodeView :code-json="section.code"></GiCodeView>
          </div>
          <a-typography-text v-else type="secondary">无</a-typography-text>
        </div>
      </div>
    </a-spin>
  </a-drawer>
</template>

<script lang="ts" setup>
import type * as T from '@/apis/system/operateLog'
import { getOperateLogDetail } from '@/apis/system/operateLog'
import { GiCodeView } from '@/components/index'

defineOptions({ name: 'OperateLogDetailDrawer' })

const visible = ref(false)
const loading = ref(false)
const log = ref<T.ListItem | null>()

interface ExtraSection {
  label: string
  code: string
}

const toCode = (value: unknown) => (value == null ? '' : JSON.stringify(value, null, 2) ?? '')

/** extra 是 JSON 字符串：before / after 各自成段，剩余键归到「其他字段」 */
const extraSections = computed<ExtraSection[]>(() => {
  const raw = log.value?.extra
  if (!raw) return []
  let parsed: unknown
  try {
    parsed = JSON.parse(raw)
  } catch {
    return [{ label: '原始内容', code: raw }]
  }
  if (parsed === null || typeof parsed !== 'object' || Array.isArray(parsed)) {
    return [{ label: '原始内容', code: toCode(parsed) || raw }]
  }
  const { before, after, ...rest } = parsed as Record<string, unknown>
  const others = Object.keys(rest).length ? [{ label: '其他字段', code: toCode(rest) }] : []
  if (before == null && after == null && !others.length) return []
  return [
    { label: '变更前 before', code: toCode(before) },
    { label: '变更后 after', code: toCode(after) },
    ...others
  ]
})

const open = async (id: number) => {
  visible.value = true
  loading.value = true
  log.value = null
  try {
    const res = await getOperateLogDetail({ id })
    log.value = res.data
  } finally {
    loading.value = false
  }
}

defineExpose({ open })
</script>

<style lang="scss" scoped>
.operate-log-detail__extra {
  margin-top: 16px;
}

.operate-log-detail__extra-title {
  margin-bottom: 8px;
  font-weight: 500;
}

.operate-log-detail__section {
  margin-bottom: 16px;
}

.operate-log-detail__section-title {
  margin-bottom: 6px;
  font-size: 13px;
  color: var(--color-text-2);
}

.operate-log-detail__code {
  max-height: 280px;
  overflow: auto;
  border-radius: var(--border-radius-medium);
}
</style>
