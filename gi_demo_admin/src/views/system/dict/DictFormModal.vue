<template>
  <a-modal v-model:visible="visible" :title="title" width="calc(100% - 20px)" :mask-closable="false"
    :modal-style="{ maxWidth: '520px' }" @before-ok="save" @close="close">
    <GiForm ref="GiFormRef" :model-value="form" :columns="formColumns"
      :grid-item-props="{ span: 24 }"
      @update:model-value="Object.assign(form, $event)" />
  </a-modal>
</template>

<script setup lang="ts">
import type { FormColumnItem } from '@/components/index'
import { Message } from '@arco-design/web-vue'
import { addDictCode, getDictCodeDetail, updateDictCode } from '@/apis/system/dict'
import { GiForm } from '@/components/index'
import { useResetReactive } from '@/hooks'
import * as Regexp from '@/utils/regexp'

const emit = defineEmits<{
  (e: 'save-success'): void
}>()

const GiFormRef = useTemplateRef<InstanceType<typeof GiForm>>('GiFormRef')
const dictId = ref(0)
const isEdit = computed(() => !!dictId.value)
const title = computed(() => (isEdit.value ? '编辑字典' : '新增字典'))
const visible = ref(false)

const [form, resetForm] = useResetReactive({
  name: '',
  code: '',
  status: 1 as Status,
  description: ''
})

const formColumns = computed<FormColumnItem[]>(() => [
  {
    type: 'input',
    label: '字典名称',
    field: 'name',
    required: true,
    rules: [{ required: true, message: '请输入字典名称' }],
    props: { maxLength: 10 }
  },
  {
    type: 'input',
    label: '字典编码',
    field: 'code',
    required: true,
    rules: [
      { match: Regexp.OnlyEnUnderline, message: '格式不对！只能是英文驼峰或英文下划线组合' }
    ],
    props: { maxLength: 10 }
  },
  {
    type: 'textarea',
    label: '描述',
    field: 'description',
    props: {
      maxLength: 200,
      autoSize: { minRows: 3, maxRows: 5 },
      showWordLimit: true
    }
  },
  {
    type: 'switch',
    label: '状态',
    field: 'status',
    required: true,
    props: {
      type: 'round',
      checkedValue: 1,
      uncheckedValue: 0,
      checkedText: '正常',
      uncheckedText: '禁用'
    }
  }
])

const add = () => {
  dictId.value = 0
  visible.value = true
}

const edit = async (item: { id: number; code: string }) => {
  dictId.value = item.id
  visible.value = true
  const res = await getDictCodeDetail({ id: item.id, code: item.code })
  Object.assign(form, res.data)
}

const close = () => {
  GiFormRef.value?.formRef?.resetFields()
  resetForm()
}

const save = async () => {
  try {
    const valid = await GiFormRef.value?.formRef?.validate()
    if (valid) return false
    if (isEdit.value) {
      await updateDictCode({ req: { ...form, id: dictId.value } })
    } else {
      await addDictCode({ req: { ...form } })
    }
    Message.success('保存成功')
    emit('save-success')
    return true
  } catch {
    return false
  }
}

defineExpose({ add, edit })
</script>
