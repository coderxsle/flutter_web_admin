<template>
  <GiPageLayout margin>
    <GiTable row-key="id" :data="tableData" :loading="loading" :columns="columns"
      :pagination="pagination" :scroll="{ x: '100%', y: '100%', minWidth: 2800 }"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll" @refresh="refresh">
      <template #custom-title>
        <GiButton type="add" @click="openAdd" />
        <GiButton type="delete" @click="onBatchDelete" />
      </template>
      <template #custom-extra>
        <a-input v-model="query.name" placeholder="模板名称" allow-clear @press-enter="search" />
        <a-select v-model="query.scope" :options="scopeOptions" placeholder="使用范围" allow-clear />
        <GiButton type="search" @click="search" />
        <GiButton type="reset" @click="reset" />
      </template>
    </GiTable>

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑处方模板' : '新增处方模板'" width="1100px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="form" :columns="formColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }" @update:model-value="Object.assign(form, $event)" />
      <a-divider>药品组成</a-divider>
      <a-space direction="vertical" fill>
        <div v-for="(item, index) in form.items" :key="index" class="prescription-template__item">
          <a-row :gutter="[8, 8]">
            <a-col :span="8">
              <a-select v-model="item.medicine_id" :options="medicineOptions" placeholder="选择药品" allow-search />
            </a-col>
            <a-col :span="4"><a-input-number v-model="item.dosage_grams" :min="0.01" placeholder="剂量" /></a-col>
            <a-col :span="3"><a-input v-model="item.dosage_unit" placeholder="单位" /></a-col>
            <a-col :span="5"><a-input v-model="item.dosage_text" placeholder="剂量文本" /></a-col>
            <a-col :span="4"><a-input v-model="item.role" placeholder="药味角色" /></a-col>
          </a-row>
          <a-row :gutter="[8, 8]">
            <a-col :span="7"><a-input v-model="item.usage_method" placeholder="用法" /></a-col>
            <a-col :span="4"><a-switch v-model="item.is_substitute" checked-text="代用品" unchecked-text="原药" /></a-col>
            <a-col :span="6">
              <a-select v-model="item.substitute_for_id" :options="medicineOptions" placeholder="替代药品" allow-search allow-clear />
            </a-col>
            <a-col :span="4"><a-input v-model="item.notes" placeholder="药味备注" /></a-col>
            <a-col :span="3"><a-button status="danger" @click="removeItem(index)">移除</a-button></a-col>
          </a-row>
        </div>
        <a-button type="dashed" long @click="addItem"><template #icon><icon-plus /></template>添加药味</a-button>
      </a-space>
    </a-modal>

    <a-modal v-model:visible="detailVisible" title="处方模板详情" width="1100px">
      <template v-if="detail">
        <a-descriptions :column="2" bordered>
          <a-descriptions-item label="模板ID">{{ detail.id }}</a-descriptions-item>
          <a-descriptions-item label="模板名称">{{ detail.name }}</a-descriptions-item>
          <a-descriptions-item label="使用范围">{{ scopeLabel(detail.scope) }}</a-descriptions-item>
          <a-descriptions-item label="处方分类">{{ displayValue(detail.category) }}</a-descriptions-item>
          <a-descriptions-item label="来源类型">{{ displayValue(detail.source_type) }}</a-descriptions-item>
          <a-descriptions-item label="来源ID">{{ displayValue(detail.source_id) }}</a-descriptions-item>
          <a-descriptions-item label="医生ID">{{ displayValue(detail.doctor_id) }}</a-descriptions-item>
          <a-descriptions-item label="证型">{{ displayValue(detail.syndrome) }}</a-descriptions-item>
          <a-descriptions-item label="功效" :span="2">{{ displayValue(detail.efficacy) }}</a-descriptions-item>
          <a-descriptions-item label="剂数">{{ detail.doses }}</a-descriptions-item>
          <a-descriptions-item label="每日频次">{{ displayValue(detail.daily_frequency) }}</a-descriptions-item>
          <a-descriptions-item label="服用方式">{{ displayValue(detail.administration_method) }}</a-descriptions-item>
          <a-descriptions-item label="状态">
            <Tag :color="detail.is_active ? 'green' : 'gray'">{{ detail.is_active ? '启用' : '停用' }}</Tag>
          </a-descriptions-item>
          <a-descriptions-item label="创建人">{{ displayValue(detail.creator) }}</a-descriptions-item>
          <a-descriptions-item label="更新人">{{ displayValue(detail.updater) }}</a-descriptions-item>
          <a-descriptions-item label="煎煮说明" :span="2">{{ displayValue(detail.decoction_instruction) }}</a-descriptions-item>
          <a-descriptions-item label="饮食禁忌" :span="2">{{ displayValue(detail.diet_restrictions) }}</a-descriptions-item>
          <a-descriptions-item label="备注" :span="2">{{ displayValue(detail.notes) }}</a-descriptions-item>
          <a-descriptions-item label="创建时间">{{ displayValue(detail.create_time) }}</a-descriptions-item>
          <a-descriptions-item label="更新时间">{{ displayValue(detail.update_time) }}</a-descriptions-item>
        </a-descriptions>
        <a-divider>药品组成</a-divider>
        <GiTable row-key="id" :data="detail.items || []" :columns="itemColumns" :pagination="false"
          :scroll="{ x: 1500 }" @refresh="openDetail(detail)" />
      </template>
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { PrescriptionItem, PrescriptionTemplate } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Popconfirm, Space, Switch, Tag } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

defineOptions({ name: 'ZhongyiPrescriptionTemplate' })

const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const formVisible = ref(false)
const detailVisible = ref(false)
const editingId = ref<number | null>(null)
const detail = ref<PrescriptionTemplate>()
const medicines = ref<{ label: string, value: number }[]>([])
const query = reactive<{ name: string, scope?: string }>({ name: '' })
const scopeOptions = [{ label: '个人', value: 'personal' }, { label: '公开', value: 'public' }, { label: '协定', value: 'agreed' }]
const [form, resetForm] = useResetReactive({
  name: '',
  scope: 'personal',
  category: 'herb_decoction',
  source_type: '',
  source_id: undefined as number | undefined,
  doctor_id: undefined as number | undefined,
  syndrome: '',
  efficacy: '',
  doses: 1,
  daily_frequency: '',
  administration_method: '',
  decoction_instruction: '',
  diet_restrictions: '',
  notes: '',
  is_active: true,
  items: [] as PrescriptionItem[]
})

const medicineOptions = computed(() => medicines.value)
const formColumns = computed<FormColumnItem[]>(() => [
  { type: 'input', label: '模板名称', field: 'name', required: true },
  { type: 'select', label: '使用范围', field: 'scope', props: { options: scopeOptions } },
  { type: 'input', label: '处方分类', field: 'category' },
  { type: 'input', label: '来源类型', field: 'source_type' },
  { type: 'input-number', label: '来源ID', field: 'source_id', props: { min: 1 } },
  { type: 'input-number', label: '医生ID', field: 'doctor_id', props: { min: 1 } },
  { type: 'input', label: '证型', field: 'syndrome' },
  { type: 'input', label: '功效', field: 'efficacy' },
  { type: 'input-number', label: '剂数', field: 'doses', props: { min: 1, max: 60 } },
  { type: 'input', label: '每日频次', field: 'daily_frequency' },
  { type: 'input', label: '服用方式', field: 'administration_method' },
  { type: 'textarea', label: '煎煮说明', field: 'decoction_instruction', span: 24 },
  { type: 'textarea', label: '饮食禁忌', field: 'diet_restrictions', span: 24 },
  { type: 'textarea', label: '备注', field: 'notes', span: 24 },
  { type: 'switch', label: '启用状态', field: 'is_active', props: { type: 'round', checkedText: '启用', uncheckedText: '停用' } }
])

const { loading, tableData, pagination, selectedKeys, search, refresh, select, selectAll, onBatchDelete } = useTable({
  listAPI: (page) => zhongyiApi.template.list({ ...page, ...query }),
  deleteAPI: (ids) => zhongyiApi.template.remove(ids)
})

const loadMedicines = async () => {
  try {
    const items = (await zhongyiApi.medicine.options()).data
    medicines.value = items.map((item) => ({ label: `${item.name} (${item.medicine_code})`, value: item.id }))
  } catch {
    Message.error('药品选项加载失败，请稍后重试')
  }
}
loadMedicines()

const reset = () => {
  query.name = ''
  query.scope = undefined
  search()
}

const openAdd = () => {
  editingId.value = null
  resetForm()
  form.items = [{
    medicine_id: 0,
    dosage_grams: 1,
    dosage_unit: 'g',
    dosage_text: '',
    role: '',
    usage_method: '',
    is_substitute: false,
    substitute_for_id: undefined,
    notes: ''
  }]
  formVisible.value = true
}

const openEdit = async (row: PrescriptionTemplate) => {
  editingId.value = row.id
  const data = (await zhongyiApi.template.detail(row.id)).data
  Object.assign(form, data)
  form.items = data.items || []
  formVisible.value = true
}

const addItem = () => {
  form.items.push({
    medicine_id: 0,
    dosage_grams: 1,
    dosage_unit: 'g',
    dosage_text: '',
    role: '',
    usage_method: '',
    is_substitute: false,
    substitute_for_id: undefined,
    notes: ''
  })
}

const removeItem = (index: number) => {
  form.items.splice(index, 1)
}

const displayValue = (value: unknown) => value === undefined || value === null || value === '' ? '-' : String(value)

const scopeLabel = (scope?: string) => scopeOptions.find((item) => item.value === scope)?.label || displayValue(scope)

const medicineLabel = (medicineId?: number) => {
  const option = medicines.value.find((item) => item.value === medicineId)
  return option?.label || displayValue(medicineId)
}

const openDetail = async (row: PrescriptionTemplate) => {
  detail.value = (await zhongyiApi.template.detail(row.id)).data
  detailVisible.value = true
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  if (!form.items.length || form.items.some((item) => !item.medicine_id || !item.dosage_grams)) {
    Message.warning('请至少添加一味药，并填写药品和剂量')
    return false
  }
  const data = { ...form, items: form.items.map((item, index) => ({ ...item, sort_order: index })) }
  if (editingId.value) await zhongyiApi.template.update(editingId.value, data)
  else await zhongyiApi.template.create(data)
  Message.success(editingId.value ? '处方模板已更新' : '处方模板已创建')
  formVisible.value = false
  search()
  return true
}

const toggleStatus = async (row: PrescriptionTemplate, value: boolean) => {
  await zhongyiApi.template.status(row.id, value)
  Message.success(value ? '模板已启用' : '模板已停用')
  search()
}

const columns: TableColumnData[] = [
  { title: '模板ID', dataIndex: 'id', width: 80, align: 'center' },
  { title: '模板名称', dataIndex: 'name', width: 180 },
  { title: '范围', width: 90, render: ({ record }) => <Tag>{scopeLabel(record.scope)}</Tag> },
  { title: '分类', dataIndex: 'category', width: 120 },
  { title: '来源类型', dataIndex: 'source_type', width: 120 },
  { title: '来源ID', dataIndex: 'source_id', width: 90, align: 'center' },
  { title: '医生ID', dataIndex: 'doctor_id', width: 90, align: 'center' },
  { title: '证型', dataIndex: 'syndrome', width: 140 },
  { title: '功效', dataIndex: 'efficacy', width: 180, ellipsis: true, tooltip: true },
  { title: '剂数', dataIndex: 'doses', width: 80, align: 'center' },
  { title: '每日频次', dataIndex: 'daily_frequency', width: 110 },
  { title: '服用方式', dataIndex: 'administration_method', width: 140 },
  { title: '煎煮说明', dataIndex: 'decoction_instruction', width: 180, ellipsis: true, tooltip: true },
  { title: '饮食禁忌', dataIndex: 'diet_restrictions', width: 180, ellipsis: true, tooltip: true },
  { title: '备注', dataIndex: 'notes', width: 180, ellipsis: true, tooltip: true },
  { title: '药味数', width: 90, render: ({ record }) => <span>{record.items?.length || 0}</span> },
  { title: '创建人', dataIndex: 'creator', width: 120 },
  { title: '更新人', dataIndex: 'updater', width: 120 },
  { title: '创建时间', dataIndex: 'create_time', width: 180, ellipsis: true, tooltip: true },
  { title: '更新时间', dataIndex: 'update_time', width: 180, ellipsis: true, tooltip: true },
  {
    title: '状态',
    width: 100,
    render: ({ record }) => <Switch checkedValue={true} uncheckedValue={false} checkedText="启用" uncheckedText="停用" modelValue={record.is_active} onUpdate:modelValue={(value) => toggleStatus(record as PrescriptionTemplate, Boolean(value))} />
  },
  {
    title: '操作',
    width: 230,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <a-button size="mini" onClick={() => openDetail(record as PrescriptionTemplate)}>详情</a-button>
        <GiButton type="edit" size="mini" onClick={() => openEdit(record as PrescriptionTemplate)} />
        <Popconfirm
          type="warning"
          content="确定删除该模板吗？"
          onBeforeOk={async () => {
            await zhongyiApi.template.remove([record.id])
            search()
            return true
          }}
        >
          <GiButton type="delete" size="mini" />
        </Popconfirm>
      </Space>
    )
  }
]

const itemColumns: TableColumnData[] = [
  { title: '明细ID', dataIndex: 'id', width: 80 },
  { title: '模板ID', dataIndex: 'template_id', width: 80 },
  {
    title: '药品',
    width: 220,
    render: ({ record }) => <span>{medicineLabel(record.medicine_id)}</span>
  },
  { title: '药品ID', dataIndex: 'medicine_id', width: 90 },
  { title: '排序', dataIndex: 'sort_order', width: 70 },
  { title: '药味角色', dataIndex: 'role', width: 110 },
  { title: '剂量', dataIndex: 'dosage_grams', width: 90 },
  { title: '剂量单位', dataIndex: 'dosage_unit', width: 90 },
  { title: '剂量文本', dataIndex: 'dosage_text', width: 120 },
  { title: '用法', dataIndex: 'usage_method', width: 140 },
  {
    title: '代用品',
    width: 90,
    render: ({ record }) => <Tag color={record.is_substitute ? 'orange' : 'gray'}>{record.is_substitute ? '是' : '否'}</Tag>
  },
  { title: '替代药品ID', dataIndex: 'substitute_for_id', width: 110 },
  { title: '备注', dataIndex: 'notes', width: 180, ellipsis: true, tooltip: true }
]
</script>

<style lang="scss" scoped>
.prescription-template {
  &__item {
    padding-bottom: 12px;
    border-bottom: 1px solid var(--color-border-2);
  }
}
</style>
