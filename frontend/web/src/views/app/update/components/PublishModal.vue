<template>
  <a-modal :visible="visible" title="发布版本" width="520px" :mask-closable="false" @cancel="close">
    <a-descriptions v-if="record" :column="1" bordered size="small">
      <a-descriptions-item label="版本">{{ record.versionName }}（{{ record.versionCode }}）</a-descriptions-item>
      <a-descriptions-item label="平台 / 渠道">
        {{ platformLabel(record.platform) }} / {{ channelLabel(record.channel) }}
      </a-descriptions-item>
      <a-descriptions-item label="安装包">
        {{ record.hasPackage ? `${record.fileName}（${formatSize(record.fileSize)}）` : '无（iOS 走商店）' }}
      </a-descriptions-item>
    </a-descriptions>

    <div class="publish-form">
      <a-form :model="formState" layout="vertical">
      <a-form-item label="投放范围">
        <a-radio-group v-model="scope" type="button">
          <a-radio value="full">全量</a-radio>
          <a-radio value="gray">灰度</a-radio>
        </a-radio-group>
      </a-form-item>
      <a-form-item v-if="scope === 'gray'" label="灰度比例">
        <a-slider v-model="rolloutPercent" :min="1" :max="99" :step="1" show-input />
      </a-form-item>
      <a-form-item label="强制更新">
        <a-switch v-model="forceUpdate" />
        <span class="tip">开启后灰度范围内用户不可跳过；门槛优先由「更新策略」的最低支持版本控制</span>
      </a-form-item>
      <a-alert v-if="forceUpdate" type="warning">
        强制更新会阻断用户进入 App，确认该版本已充分验证。
      </a-alert>
      </a-form>
    </div>

    <template #footer>
      <a-space>
        <a-button :disabled="submitting" @click="close">取消</a-button>
        <a-button type="primary" :loading="submitting" @click="submit">确认发布</a-button>
      </a-space>
    </template>
  </a-modal>
</template>

<script setup lang="ts">
import type { AppReleaseItem } from '@/apis/app/update'
import { Message } from '@arco-design/web-vue'
import { publishRelease } from '@/apis/app/update'
import { channelLabel, formatSize, platformLabel } from '../constants'

defineOptions({ name: 'AppReleasePublishModal' })

const props = withDefaults(defineProps<{
  visible: boolean
  record?: AppReleaseItem | null
}>(), { record: null })

const emit = defineEmits<{
  'update:visible': [value: boolean]
  saved: []
}>()

const submitting = ref(false)
const formState = reactive({})
const scope = ref<'full' | 'gray'>('full')
const rolloutPercent = ref(30)
const forceUpdate = ref(false)

watch(() => props.visible, (visible) => {
  if (!visible) return
  scope.value = 'full'
  rolloutPercent.value = 30
  forceUpdate.value = props.record?.forceUpdate ?? false
})

const close = () => {
  if (submitting.value) return
  emit('update:visible', false)
}

const submit = async () => {
  const record = props.record
  if (!record) return
  submitting.value = true
  try {
    await publishRelease({
      id: record.id,
      rolloutPercent: scope.value === 'full' ? 100 : rolloutPercent.value,
      forceUpdate: forceUpdate.value
    })
    Message.success(scope.value === 'full' ? '已全量发布' : `已灰度发布 ${rolloutPercent.value}%`)
    emit('saved')
    emit('update:visible', false)
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.publish-form {
  margin-top: 16px;
}

.tip {
  margin-left: 10px;
  font-size: 12px;
  color: var(--color-text-3);
}
</style>
