<template>
  <a-modal
    :visible="visible"
    :title="isEdit ? '编辑版本' : '上传新版本'"
    width="640px"
    :mask-closable="false"
    :closable="!submitting"
    @cancel="close"
  >
    <a-form :model="form" layout="vertical">
      <a-row :gutter="16">
        <a-col :span="12">
          <a-form-item label="平台" required>
            <a-select v-model="form.platform" :options="platformOptions" :disabled="lockIdentity" />
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="渠道" required>
            <a-select v-model="form.channel" :options="channelOptions" :disabled="lockIdentity" />
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="版本名（展示用）" required>
            <a-input v-model="form.versionName" placeholder="如 1.2.0" :disabled="lockIdentity" />
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="构建号 versionCode" required>
            <a-input-number
              v-model="form.versionCode"
              :precision="0"
              :min="1"
              :controls="false"
              placeholder="如 1024101025"
              style="width: 100%"
              :disabled="lockIdentity"
            />
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="最低系统版本">
            <a-input v-model="form.minOsVersion" placeholder="留空表示不限制，如 8.0" />
          </a-form-item>
        </a-col>
        <a-col v-if="form.platform === 'ios'" :span="12">
          <a-form-item label="App Store 地址">
            <a-input v-model="form.storeUrl" placeholder="https://apps.apple.com/app/id..." />
          </a-form-item>
        </a-col>
        <a-col :span="24">
          <a-form-item label="更新说明">
            <a-textarea v-model="form.releaseNotes" :auto-size="{ minRows: 3, maxRows: 6 }" placeholder="客户端弹窗展示的更新内容" />
          </a-form-item>
        </a-col>
        <a-col v-if="form.platform === 'android'" :span="24">
          <a-form-item label="安装包">
            <a-upload
              :file-list="fileList"
              :auto-upload="false"
              :limit="1"
              accept=".apk"
              :disabled="submitting || !canUpload"
              @change="onFileChange"
            />
            <div class="upload-hint">
              <template v-if="record?.hasPackage">当前包：{{ record.fileName }}（{{ formatSize(record.fileSize) }}），重新选择将覆盖</template>
              <template v-else>仅支持 .apk，不超过 300MB；保存后需在列表点「发布」才对外生效</template>
            </div>
            <a-progress v-if="submitting && percent > 0" :percent="percent" size="small" style="margin-top: 8px" />
          </a-form-item>
        </a-col>
      </a-row>
      <a-alert v-if="lockIdentity" type="info">
        已投放的版本只能修改更新说明、最低系统版本与灰度配置，版本号不可改。
      </a-alert>
    </a-form>

    <template #footer>
      <a-space>
        <a-button :disabled="submitting" @click="close">取消</a-button>
        <a-button type="primary" :loading="submitting" @click="submit">保存</a-button>
      </a-space>
    </template>
  </a-modal>
</template>

<script setup lang="ts">
import type { AppReleaseItem } from '@/apis/app/update'
import { Message } from '@arco-design/web-vue'
import { createRelease, updateRelease, uploadPackage } from '@/apis/app/update'
import { channelOptions, formatSize, platformOptions } from '../constants'

defineOptions({ name: 'AppReleaseFormModal' })

const props = withDefaults(defineProps<{
  visible: boolean
  record?: AppReleaseItem | null
}>(), { record: null })

const emit = defineEmits<{
  'update:visible': [value: boolean]
  saved: []
}>()

const isEdit = computed(() => Boolean(props.record?.id))
const lockIdentity = computed(() => Boolean(props.record && props.record.status !== 'draft'))
const canUpload = computed(() => !props.record || props.record.status === 'draft')

const submitting = ref(false)
const percent = ref(0)
const fileList = ref<any[]>([])
const selectedFile = ref<File>()
const form = reactive({
  platform: 'android' as 'android' | 'ios',
  channel: 'official' as 'official' | 'huawei' | 'xiaomi' | 'yingyongbao',
  versionName: '',
  versionCode: undefined as number | undefined,
  minOsVersion: '',
  storeUrl: '',
  releaseNotes: ''
})

watch(() => props.visible, (visible) => {
  if (!visible) return
  percent.value = 0
  fileList.value = []
  selectedFile.value = undefined
  const record = props.record
  form.platform = record?.platform ?? 'android'
  form.channel = record?.channel ?? 'official'
  form.versionName = record?.versionName ?? ''
  form.versionCode = record?.versionCode
  form.minOsVersion = record?.minOsVersion ?? ''
  form.storeUrl = record?.storeUrl ?? ''
  form.releaseNotes = record?.releaseNotes ?? ''
})

const onFileChange = (list: any[]) => {
  fileList.value = list.slice(-1)
  selectedFile.value = fileList.value[0]?.file
}

const close = () => {
  if (submitting.value) return
  emit('update:visible', false)
}

const validate = () => {
  if (!form.versionName.trim()) return '请填写版本名'
  if (!form.versionCode || form.versionCode <= 0) return '请填写构建号'
  if (form.platform === 'android' && !props.record?.hasPackage && !selectedFile.value) {
    return '请选择要上传的 APK'
  }
  if (form.platform === 'ios' && !form.storeUrl.trim()) return '请填写 App Store 地址'
  if (selectedFile.value && selectedFile.value.size > 300 * 1024 * 1024) return '安装包不能超过 300MB'
  return ''
}

const submit = async () => {
  const error = validate()
  if (error) {
    Message.warning(error)
    return
  }
  submitting.value = true
  percent.value = 0
  try {
    let id = props.record?.id
    if (id) {
      await updateRelease({
        id,
        platform: form.platform,
        channel: form.channel,
        versionName: form.versionName.trim(),
        versionCode: form.versionCode!,
        minOsVersion: form.minOsVersion.trim() || null,
        storeUrl: form.platform === 'ios' ? form.storeUrl.trim() : null,
        releaseNotes: form.releaseNotes
      })
    } else {
      const created = await createRelease({
        platform: form.platform,
        channel: form.channel,
        versionName: form.versionName.trim(),
        versionCode: form.versionCode!,
        minOsVersion: form.minOsVersion.trim() || null,
        storeUrl: form.platform === 'ios' ? form.storeUrl.trim() : null,
        releaseNotes: form.releaseNotes
      })
      id = created.data.id
    }
    if (id && form.platform === 'android' && selectedFile.value) {
      await uploadPackage(id, selectedFile.value, value => { percent.value = value })
    }
    Message.success('已保存，请在列表点「发布」')
    emit('saved')
    emit('update:visible', false)
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.upload-hint {
  margin-top: 6px;
  font-size: 12px;
  color: var(--color-text-3);
  line-height: 1.5;
}
</style>
