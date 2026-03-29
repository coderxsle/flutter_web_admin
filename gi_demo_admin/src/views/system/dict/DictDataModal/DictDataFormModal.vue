<template>
  <a-modal v-model:visible="visible" :title="title" width="calc(100% - 20px)" :mask-closable="false"
    :modal-style="{ maxWidth: '520px' }" @before-ok="save" @close="close">
    <a-spin :loading="loading" class="w-full">
      <GiForm ref="GiFormRef" :model-value="form" :columns="formColumns" :grid-item-props="{ span: 24 }"
        @update:model-value="Object.assign(form, $event)" />
    </a-spin>
  </a-modal>
</template>

<script setup lang="ts">
import type { FormColumnItem } from '@/components/index'
import { Message, Tag } from '@arco-design/web-vue'
import { h } from 'vue'
import { addDictData, getDictDataDetail, updateDictData } from '@/apis/system/dict'
import { GiForm } from '@/components/index'
import { useResetReactive } from '@/hooks'


const emit = defineEmits<{
  (e: 'save-success'): void
}>()

const GiFormRef = useTemplateRef<InstanceType<typeof GiForm>>('GiFormRef')
  const dictCode = ref('')
const dictDataId = ref(0)
// const isEdit = computed(() => dictDataId.value !== null)
const isEdit = computed(() => !!dictDataId.value)
const title = computed(() => (isEdit.value ? '编辑字典数据' : '新增字典数据'))
const visible = ref(false)
const loading = ref(false)


const colorOptions = [
  { label: '主要（极致蓝）', value: 'arcoblue' },
  { label: '成功（仙野绿）', value: 'green' },
  { label: '警告（活力橙）', value: 'orange' },
  { label: '错误（浪漫红）', value: 'red' },
  { label: '默认（中性灰）', value: 'gray' }
]

const [form, resetForm] = useResetReactive({
  name: '',
  value: '',
  color: '',
  sort: 0,
  status: 1 as Status,
  description: ''
})

const formColumns = computed<FormColumnItem[]>(() => [
  {
    type: 'input',
    label: '字典名',
    field: 'name',
    required: true,
    rules: [{ required: true, message: '请输入字典名' }],
    props: { maxLength: 10 }
  },
  {
    type: 'input',
    label: '字典值',
    field: 'value',
    required: true,
    rules: [
      { required: true, message: '请输入字典值' },
      { match: /^\w*$/, message: '格式不对！只能包含英文数字下划线' }
    ],
    props: { maxLength: 10 }
  },
  {
    type: 'select',
    label: '颜色',
    field: 'color',
    required: true,
    rules: [{ required: true, message: '请输入颜色' }],
    props: {
      options: colorOptions,
      allowClear: true,
      style: { width: '150px' }
    },
    slots: {
      option: ({ data }) => h(Tag, { color: data?.value as string, size: 'small' }, () => data?.label as string),
      label: ({ data }) => h(Tag, { color: data?.value as string, size: 'small' }, () => data?.label as string)
    }
  },
  {
    type: 'input-number',
    label: '排序',
    field: 'sort',
    props: { min: 0, style: { width: '120px' } },
    span: 12
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
    },
    span: 12
  }
])

const add = (code: string) => {
  dictCode.value = code
  dictDataId.value = 0
  visible.value = true
}

const edit = async (data: { id: number, code: string }) => {
  dictCode.value = data.code
  dictDataId.value = data.id
  visible.value = true
  loading.value = true
  const res = await getDictDataDetail(data)
  Object.assign(form, res.data)
  // form.value = res.data.value != null ? String(res.data.value) : ''
  loading.value = false
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
      await updateDictData({
        id: Number(dictDataId.value),
        code: dictCode.value,
        ...form
      })
    } else {
      await addDictData({ req: {code: dictCode.value, ...form}})
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
