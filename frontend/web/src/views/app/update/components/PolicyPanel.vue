<template>
  <a-card :bordered="false">
    <a-space wrap style="margin-bottom: 16px">
      <a-select v-model="platform" :options="platformOptions" style="width: 140px" @change="load" />
      <a-select v-model="channel" :options="channelOptions" style="width: 140px" @change="load" />
      <a-tag v-if="latest" color="green">当前线上：{{ latest.versionName }}（{{ latest.versionCode }}）</a-tag>
      <a-tag v-else color="gray">该渠道暂无已发布版本</a-tag>
    </a-space>

    <a-form :model="form" layout="vertical" style="max-width: 560px">
      <a-form-item label="最低支持构建号">
        <a-input-number
          v-model="form.minSupportedVersionCode"
          :min="0"
          :precision="0"
          :controls="false"
          style="width: 100%"
        />
        <div class="tip">客户端构建号低于该值时强制更新；0 表示不强制。</div>
      </a-form-item>
      <a-form-item label="非强制更新提醒冷却（小时）">
        <a-input-number v-model="form.promptCooldownHours" :min="1" :max="720" :precision="0" style="width: 100%" />
      </a-form-item>
      <a-form-item label="下载地址有效期（分钟）">
        <a-input-number v-model="form.downloadUrlTtlMinutes" :min="5" :max="1440" :precision="0" style="width: 100%" />
      </a-form-item>
      <a-form-item label="启用更新检测">
        <a-switch v-model="form.enabled" />
      </a-form-item>
      <a-button type="primary" :loading="saving" @click="save">保存策略</a-button>
    </a-form>

    <a-alert type="info" style="margin-top: 20px; max-width: 560px">
      策略按租户隔离。当前租户没有单独配置时，会回落到平台默认（tenantId=0）的策略。
    </a-alert>
  </a-card>
</template>

<script setup lang="ts">
import type { AppChannel, AppPlatform, AppReleaseItem } from '@/apis/app/update'
import { Message } from '@arco-design/web-vue'
import { getPolicy, getReleaseList, updatePolicy } from '@/apis/app/update'
import { channelOptions, platformOptions } from '../constants'

defineOptions({ name: 'AppUpdatePolicyPanel' })

const platform = ref<AppPlatform>('android')
const channel = ref<AppChannel>('official')
const latest = ref<AppReleaseItem>()
const saving = ref(false)
const form = reactive({
  minSupportedVersionCode: 0,
  promptCooldownHours: 24,
  downloadUrlTtlMinutes: 120,
  enabled: true
})

const load = async () => {
  const res = await getPolicy({ platform: platform.value, channel: channel.value })
  Object.assign(form, {
    minSupportedVersionCode: res.data.minSupportedVersionCode,
    promptCooldownHours: res.data.promptCooldownHours,
    downloadUrlTtlMinutes: res.data.downloadUrlTtlMinutes,
    enabled: res.data.enabled
  })
  const list = await getReleaseList({ platform: platform.value, channel: channel.value, status: 'published', pageSize: 1 })
  latest.value = list.data.records?.[0]
}

const save = async () => {
  saving.value = true
  try {
    await updatePolicy({
      platform: platform.value,
      channel: channel.value,
      minSupportedVersionCode: form.minSupportedVersionCode,
      promptCooldownHours: form.promptCooldownHours,
      downloadUrlTtlMinutes: form.downloadUrlTtlMinutes,
      enabled: form.enabled
    })
    Message.success('策略已保存')
  } finally {
    saving.value = false
  }
}

onMounted(load)
</script>

<style scoped>
.tip {
  margin-top: 4px;
  font-size: 12px;
  color: var(--color-text-3);
}
</style>
