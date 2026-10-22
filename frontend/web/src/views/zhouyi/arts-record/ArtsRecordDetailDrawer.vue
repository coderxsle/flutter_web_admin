<template>
  <a-drawer v-model:visible="visible" title="排盘记录详情" width="min(880px, 94vw)">
    <a-spin :loading="loading" style="width: 100%">
      <a-descriptions :column="{ xs: 1, sm: 1, md: 2 }" bordered size="large">
        <a-descriptions-item label="记录ID">{{ detail?.id }}</a-descriptions-item>
        <a-descriptions-item label="术数类型">{{ artsTypeLabel(detail?.artsType) }}</a-descriptions-item>
        <a-descriptions-item label="标题">{{ detail?.title || '-' }}</a-descriptions-item>
        <a-descriptions-item label="状态">
          <a-tag v-if="detail" :color="detail.status === 1 ? 'green' : 'gray'">
            {{ detail.status === 1 ? '启用' : '停用' }}
          </a-tag>
          <span v-else>-</span>
        </a-descriptions-item>
        <a-descriptions-item label="用户ID">{{ detail?.userId }}</a-descriptions-item>
        <a-descriptions-item label="起盘时间">{{ toDateTimeText(detail?.chartTime) || '-' }}</a-descriptions-item>
        <a-descriptions-item label="创建时间">{{ toDateTimeText(detail?.createTime) || '-' }}</a-descriptions-item>
        <a-descriptions-item label="更新时间">{{ toDateTimeText(detail?.updateTime) || '-' }}</a-descriptions-item>
        <a-descriptions-item label="标签" :span="2">
          <a-space v-if="detail?.tags?.length" wrap>
            <a-tag v-for="tag in detail.tags" :key="tag">{{ tag }}</a-tag>
          </a-space>
          <span v-else>-</span>
        </a-descriptions-item>
        <a-descriptions-item label="问题" :span="2">{{ detail?.question || '-' }}</a-descriptions-item>
        <a-descriptions-item label="解读" :span="2">{{ detail?.interpretation || '-' }}</a-descriptions-item>
        <a-descriptions-item label="反馈" :span="2">{{ detail?.feedback || '-' }}</a-descriptions-item>
        <a-descriptions-item label="客户端键" :span="2">{{ detail?.clientKey || '-' }}</a-descriptions-item>
      </a-descriptions>

      <div v-for="section in jsonSections" :key="section.label" class="arts-record-detail__section">
        <div class="arts-record-detail__section-title">{{ section.label }}</div>
        <div v-if="section.code" class="arts-record-detail__code">
          <GiCodeView :code-json="section.code"></GiCodeView>
        </div>
        <a-typography-text v-else type="secondary">无</a-typography-text>
      </div>
    </a-spin>
  </a-drawer>
</template>

<script lang="ts" setup>
import type { ArtsRecord } from '@/apis/zhouyi'
import { zhouyiApi } from '@/apis/zhouyi'
import { GiCodeView } from '@/components/index'

import { artsTypeLabel, toDateTimeText } from './utils'

defineOptions({ name: 'ArtsRecordDetailDrawer' })

const visible = ref(false)
const loading = ref(false)
const detail = ref<ArtsRecord | null>()

interface JsonSection {
  label: string
  code: string
}

const toCode = (value: unknown) => {
  if (value == null || value === '') return ''
  return typeof value === 'string' ? value : JSON.stringify(value, null, 2)
}

/** 起盘参数与盘面快照都是 JSON，用代码块看层级比表格清楚 */
const jsonSections = computed<JsonSection[]>(() => [
  { label: '起盘参数 queryParams', code: toCode(detail.value?.queryParams) },
  { label: '盘面快照 chartSnapshot', code: toCode(detail.value?.chartSnapshot) }
])

const open = async (id: number) => {
  visible.value = true
  loading.value = true
  detail.value = null
  try {
    detail.value = (await zhouyiApi.artsRecord.detail(id)).data
  } finally {
    loading.value = false
  }
}

defineExpose({ open })
</script>

<style lang="scss" scoped>
.arts-record-detail__section {
  margin-top: 16px;
}

.arts-record-detail__section-title {
  margin-bottom: 6px;
  font-size: 13px;
  color: var(--color-text-2);
}

.arts-record-detail__code {
  max-height: 300px;
  overflow: auto;
  border-radius: var(--border-radius-medium);
}
</style>
