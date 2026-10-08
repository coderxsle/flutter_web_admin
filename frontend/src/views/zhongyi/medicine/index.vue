<template>
  <GiPageLayout margin>
    <GiTable row-key="id" :data="tableData" :loading="loading" :columns="columns"
      :pagination="pagination" :scroll="{ x: '100%', y: '100%', minWidth: 1400 }"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll" @refresh="refresh">
      <template #custom-title>
        <GiButton type="add" @click="openAdd" />
        <GiButton type="delete" @click="onBatchDelete" />
      </template>
      <template #custom-extra>
        <a-input v-model="query.keyword" placeholder="药品名称 / 编码 / 拼音" allow-clear @press-enter="search" />
        <a-select v-model="query.status" :options="statusOptions" placeholder="状态" allow-clear style="width: 110px" />
        <GiButton type="search" @click="search" />
        <GiButton type="reset" @click="reset" />
      </template>
    </GiTable>

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑药品' : '新增药品'" width="900px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="form" :columns="formColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }" @update:model-value="Object.assign(form, $event)" />
    </a-modal>

    <a-modal v-model:visible="detailVisible" title="药品详情" width="820px">
      <a-descriptions v-if="detail" :column="2" bordered>
        <a-descriptions-item label="药品编码">{{ detail.medicine_code }}</a-descriptions-item>
        <a-descriptions-item label="药品名称">
          <MedicineName :prefix="detail.prefix" :name="detail.name" />
        </a-descriptions-item>
        <a-descriptions-item label="拼音码">{{ detail.pinyin || '-' }}</a-descriptions-item>
        <a-descriptions-item label="分类">{{ detail.category || '-' }}</a-descriptions-item>
        <a-descriptions-item label="子分类">{{ detail.subcategory || '-' }}</a-descriptions-item>
        <a-descriptions-item label="产地">{{ detail.origin_place || '-' }}</a-descriptions-item>
        <a-descriptions-item label="毒性">{{ detail.toxicity || '-' }}</a-descriptions-item>
        <a-descriptions-item label="妊娠用药">{{ detail.pregnancy_category || '-' }}</a-descriptions-item>
        <a-descriptions-item label="特殊管理">{{ detail.is_special_management ? '是' : '否' }}</a-descriptions-item>
        <a-descriptions-item label="状态">{{ detail.status === 1 ? '启用' : '停用' }}</a-descriptions-item>
        <a-descriptions-item label="库存">{{ detail.stock_quantity_g ?? 0 }} {{ detail.retail_sale_unit || 'g' }}</a-descriptions-item>
        <a-descriptions-item label="进货价">{{ detail.latest_purchase_price ?? 0 }}</a-descriptions-item>
        <a-descriptions-item label="零售价">{{ detail.retail_sale_price ?? 0 }} / {{ detail.retail_sale_unit || 'g' }}</a-descriptions-item>
        <a-descriptions-item label="常用剂量">{{ dosageRange }}</a-descriptions-item>
        <a-descriptions-item label="剂量警示(g)">{{ detail.dosage_warning ?? '-' }}</a-descriptions-item>
        <a-descriptions-item label="保质期(月)">{{ detail.shelf_life_months ?? '-' }}</a-descriptions-item>
        <a-descriptions-item label="储存要求" :span="2">{{ detail.storage_requirements || '-' }}</a-descriptions-item>
        <a-descriptions-item label="功效" :span="2">{{ detail.functions || '-' }}</a-descriptions-item>
        <a-descriptions-item label="主治" :span="2">{{ detail.indications || '-' }}</a-descriptions-item>
        <a-descriptions-item label="性味归经" :span="2">{{ propertiesText }}</a-descriptions-item>
        <a-descriptions-item label="描述" :span="2">{{ detail.description || '-' }}</a-descriptions-item>
        <a-descriptions-item label="创建时间">{{ detail.created_time || '-' }}</a-descriptions-item>
        <a-descriptions-item label="更新时间">{{ detail.updated_time || '-' }}</a-descriptions-item>
      </a-descriptions>
    </a-modal>

    <a-modal v-model:visible="priceVisible" title="新增价格" width="520px" @before-ok="savePrice">
      <GiForm :model-value="priceForm" :columns="priceColumns"
        @update:model-value="Object.assign(priceForm, $event)" />
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { Medicine } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Popconfirm, Space, Tag } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

defineOptions({ name: 'ZhongyiMedicine' })

/** 药品名称统一按「前缀 + 基名」呈现，前缀红色，与 App 端一致 */
const MedicineName = (props: { prefix?: string, name?: string }) => (
  <span>
    {props.prefix ? <span style={{ color: 'rgb(var(--danger-6))' }}>{props.prefix}</span> : null}
    {props.name}
  </span>
)

const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const formVisible = ref(false)
const detailVisible = ref(false)
const priceVisible = ref(false)
const editingId = ref<number | null>(null)
const detail = ref<Medicine>()
const priceMedicineId = ref<number | null>(null)

const query = reactive<{ keyword: string, status?: number }>({ keyword: '' })
const statusOptions = [{ label: '启用', value: 1 }, { label: '停用', value: 0 }]
const [form, resetForm] = useResetReactive({
  medicine_code: '',
  name: '',
  prefix: '',
  pinyin: '',
  category: '',
  subcategory: '',
  origin_place: '',
  toxicity: '',
  pregnancy_category: '',
  functions: '',
  indications: '',
  common_dosage_min: undefined as number | undefined,
  common_dosage_max: undefined as number | undefined,
  dosage_warning: undefined as number | undefined,
  properties: '{}',
  storage_requirements: '',
  shelf_life_months: undefined as number | undefined,
  is_special_management: false,
  status: 1,
  description: ''
})
const [priceForm, resetPriceForm] = useResetReactive({
  price_type: 'retail',
  unit: 'g',
  sale_price: 0,
  effective_from: new Date().toISOString().slice(0, 10)
})

const { loading, tableData, pagination, selectedKeys, search, refresh, select, selectAll, onBatchDelete } = useTable({
  listAPI: (page) => zhongyiApi.medicine.list({ ...page, ...query }),
  deleteAPI: (ids) => zhongyiApi.medicine.remove(ids)
})

const dosageRange = computed(() => {
  const min = detail.value?.common_dosage_min
  const max = detail.value?.common_dosage_max
  if (min == null && max == null) return '-'
  return `${min ?? '-'} ~ ${max ?? '-'} g`
})

const propertiesText = computed(() => {
  const properties = detail.value?.properties
  return properties && Object.keys(properties).length ? JSON.stringify(properties) : '-'
})

const formColumns = computed<FormColumnItem[]>(() => [
  { type: 'input', label: '药品编码', field: 'medicine_code', required: true },
  { type: 'input', label: '药品名称', field: 'name', required: true },
  { type: 'input', label: '炮制前缀', field: 'prefix' },
  { type: 'input', label: '拼音码', field: 'pinyin' },
  { type: 'input', label: '分类', field: 'category', required: true },
  { type: 'input', label: '子分类', field: 'subcategory' },
  { type: 'input', label: '产地', field: 'origin_place' },
  { type: 'input', label: '毒性', field: 'toxicity' },
  { type: 'input', label: '妊娠用药', field: 'pregnancy_category' },
  { type: 'input-number', label: '常用最小剂量(g)', field: 'common_dosage_min' },
  { type: 'input-number', label: '常用最大剂量(g)', field: 'common_dosage_max' },
  { type: 'input-number', label: '剂量警示值(g)', field: 'dosage_warning' },
  { type: 'input', label: '储存要求', field: 'storage_requirements' },
  { type: 'input-number', label: '保质期(月)', field: 'shelf_life_months' },
  {
    type: 'switch',
    label: '特殊管理',
    field: 'is_special_management',
    props: { checkedValue: true, uncheckedValue: false, checkedText: '是', uncheckedText: '否' }
  },
  { type: 'switch', label: '状态', field: 'status', props: { checkedValue: 1, uncheckedValue: 0, checkedText: '启用', uncheckedText: '停用' } },
  { type: 'textarea', label: '功效', field: 'functions', span: 24 },
  { type: 'textarea', label: '主治', field: 'indications', span: 24 },
  { type: 'textarea', label: '性味归经(JSON)', field: 'properties', span: 24 },
  { type: 'textarea', label: '描述', field: 'description', span: 24 }
])

const priceColumns: FormColumnItem[] = [
  { type: 'select', label: '价格类型', field: 'price_type', props: { options: [{ label: '零售', value: 'retail' }, { label: '采购', value: 'purchase' }] } },
  { type: 'input', label: '计价单位', field: 'unit', required: true },
  { type: 'input-number', label: '销售价格', field: 'sale_price', required: true },
  { type: 'date-picker', label: '生效日期', field: 'effective_from', props: { valueFormat: 'YYYY-MM-DD' } }
]

const reset = () => {
  query.keyword = ''
  query.status = undefined
  search()
}

const openAdd = () => {
  editingId.value = null
  resetForm()
  formVisible.value = true
}

const openEdit = async (row: Medicine) => {
  const res = await zhongyiApi.medicine.detail(row.id)
  editingId.value = row.id
  Object.assign(form, { ...res.data, properties: JSON.stringify(res.data.properties || {}, null, 2) })
  formVisible.value = true
}

const openDetail = async (row: Medicine) => {
  detail.value = (await zhongyiApi.medicine.detail(row.id)).data
  detailVisible.value = true
}

const openPrice = (row: Medicine) => {
  priceMedicineId.value = row.id
  resetPriceForm()
  priceVisible.value = true
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  let properties: Record<string, unknown> | undefined
  try {
    properties = form.properties ? JSON.parse(form.properties) : undefined
  } catch {
    Message.error('性味归经必须是合法 JSON')
    return false
  }
  const data = { ...form, properties }
  if (editingId.value) await zhongyiApi.medicine.update(editingId.value, data)
  else await zhongyiApi.medicine.create(data)
  Message.success(editingId.value ? '药品已更新' : '药品已创建')
  formVisible.value = false
  search()
  return true
}

const savePrice = async () => {
  if (!priceMedicineId.value) return false
  await zhongyiApi.medicine.addPrice(priceMedicineId.value, priceForm)
  Message.success('价格已保存')
  priceVisible.value = false
  return true
}

const columns: TableColumnData[] = [
  { title: '编码', dataIndex: 'medicine_code', width: 140, ellipsis: true, tooltip: true },
  { title: '药品名称', width: 170, render: ({ record }) => <MedicineName prefix={record.prefix} name={record.name} /> },
  { title: '产地', dataIndex: 'origin_place', width: 110, ellipsis: true, tooltip: true },
  { title: '分类', dataIndex: 'category', width: 100 },
  { title: '子分类', dataIndex: 'subcategory', width: 100 },
  { title: '拼音', dataIndex: 'pinyin', width: 110 },
  {
    title: '库存',
    width: 120,
    align: 'right',
    render: ({ record }) => `${record.stock_quantity_g ?? 0} ${record.retail_sale_unit || 'g'}`
  },
  { title: '进货价', dataIndex: 'latest_purchase_price', width: 100, align: 'right' },
  {
    title: '零售价',
    width: 120,
    align: 'right',
    render: ({ record }) => `${record.retail_sale_price ?? 0} / ${record.retail_sale_unit || 'g'}`
  },
  {
    title: '状态',
    width: 90,
    render: ({ record }) => <Tag color={record.status === 1 ? 'green' : 'gray'}>{record.status === 1 ? '启用' : '停用'}</Tag>
  },
  {
    title: '操作',
    width: 220,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <GiButton type="edit" size="mini" onClick={() => openEdit(record as Medicine)} />
        <a-button size="mini" onClick={() => openDetail(record as Medicine)}>详情</a-button>
        <a-button size="mini" status="success" onClick={() => openPrice(record as Medicine)}>价格</a-button>
        <Popconfirm
          type="warning"
          content="确定删除该药品吗？"
          onBeforeOk={async () => {
            await zhongyiApi.medicine.remove([record.id])
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
</script>

<style lang="scss" scoped>
</style>
