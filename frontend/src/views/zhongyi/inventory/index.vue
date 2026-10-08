<template>
  <GiPageLayout margin>
    <a-tabs v-model:active-key="activeTab" @change="onTabChange">
      <a-tab-pane key="inventory" title="库存列表">
        <GiTable row-key="id" :data="tableData" :loading="loading" :columns="columns"
          :pagination="pagination" :scroll="{ x: '100%', y: '100%', minWidth: 1600 }" @refresh="refresh">
          <template #custom-title>
            <a-button type="primary" @click="stockInVisible = true"><template #icon><icon-plus /></template>入库</a-button>
          </template>
          <template #custom-extra>
            <a-input v-model="query.medicine_keyword" placeholder="药品名称 / 拼音" allow-clear />
            <a-input v-model="query.batch_number" placeholder="批号" allow-clear />
            <a-select v-model="query.quality_status" :options="qualityOptions" placeholder="质量状态" allow-clear />
            <GiButton type="search" @click="search" />
            <GiButton type="reset" @click="reset" />
          </template>
        </GiTable>
      </a-tab-pane>
      <a-tab-pane key="transactions" title="库存流水">
        <GiTable row-key="id" :data="transactionData" :loading="transactionLoading"
          :columns="transactionColumns" :pagination="transactionPagination"
          :scroll="{ x: '100%', y: '100%', minWidth: 900 }" @refresh="transactionRefresh" />
      </a-tab-pane>
    </a-tabs>

    <a-modal v-model:visible="stockInVisible" title="药品入库" width="650px" :mask-closable="false"
      @before-ok="saveStockIn" @close="resetStockIn">
      <GiForm ref="stockInFormRef" :model-value="stockInForm" :columns="stockInColumns"
        @update:model-value="Object.assign(stockInForm, $event)" />
    </a-modal>

    <a-modal v-model:visible="adjustVisible" title="库存调整" width="520px" @before-ok="saveAdjust">
      <GiForm ref="adjustFormRef" :model-value="adjustForm" :columns="adjustColumns"
        @update:model-value="Object.assign(adjustForm, $event)" />
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { Inventory, Medicine } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Space, Tag } from '@arco-design/web-vue'
import dayjs from 'dayjs'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

defineOptions({ name: 'ZhongyiInventory' })

const activeTab = ref('inventory')
const stockInVisible = ref(false)
const adjustVisible = ref(false)
const stockInFormRef = useTemplateRef<InstanceType<typeof GiForm>>('stockInFormRef')
const adjustFormRef = useTemplateRef<InstanceType<typeof GiForm>>('adjustFormRef')
const medicineOptions = ref<Medicine[]>([])
const query = reactive<{ medicine_keyword: string, batch_number: string, quality_status?: string }>({
  medicine_keyword: '',
  batch_number: ''
})
const qualityOptions = [{ label: '合格', value: 'qualified' }, { label: '待检', value: 'pending' }, { label: '不合格', value: 'unqualified' }]
const [stockInForm, resetStockIn] = useResetReactive({
  medicine_id: undefined as number | undefined,
  batch_number: '',
  supplier_id: undefined as number | undefined,
  quantity_g: 0,
  unit: 'g',
  purchase_price: 0,
  production_date: undefined as string | undefined,
  expiry_date: undefined as string | undefined,
  quality_status: 'qualified',
  storage_location: '',
  remark: ''
})
const [adjustForm, resetAdjust] = useResetReactive({
  inventory_id: 0,
  quantity_change: 0,
  remark: ''
})

const { loading, tableData, pagination, search, refresh } = useTable({
  listAPI: (page) => zhongyiApi.inventory.list({ ...page, ...query })
})
const {
  loading: transactionLoading,
  tableData: transactionData,
  pagination: transactionPagination,
  search: transactionSearch,
  refresh: transactionRefresh
} = useTable({
  listAPI: (page) => zhongyiApi.inventory.transactions(page),
  immediate: false
})

const loadMedicineOptions = async () => {
  medicineOptions.value = (await zhongyiApi.medicine.options()).data
}
loadMedicineOptions()

const stockInColumns = computed<FormColumnItem[]>(() => [
  {
    type: 'select',
    label: '药品',
    field: 'medicine_id',
    required: true,
    props: {
      options: medicineOptions.value.map((item) => ({ label: `${item.prefix ?? ''}${item.name} (${item.medicine_code})`, value: item.id })),
      allowSearch: true
    }
  },
  { type: 'input', label: '批号', field: 'batch_number', required: true },
  { type: 'input-number', label: '供应商ID', field: 'supplier_id', props: { min: 1, precision: 0 } },
  { type: 'input-number', label: '入库数量(g)', field: 'quantity_g', required: true, props: { min: 0.01 } },
  { type: 'input', label: '单位', field: 'unit', required: true },
  { type: 'input-number', label: '采购价', field: 'purchase_price', props: { min: 0, precision: 2 } },
  { type: 'date-picker', label: '生产日期', field: 'production_date', props: { valueFormat: 'YYYY-MM-DD' } },
  { type: 'date-picker', label: '有效期', field: 'expiry_date', props: { valueFormat: 'YYYY-MM-DD' } },
  { type: 'select', label: '质量状态', field: 'quality_status', props: { options: qualityOptions } },
  { type: 'input', label: '库位', field: 'storage_location' },
  { type: 'textarea', label: '备注', field: 'remark', span: 24 }
])

const adjustColumns: FormColumnItem[] = [
  { type: 'input-number', label: '库存ID', field: 'inventory_id', required: true, props: { disabled: true } },
  { type: 'input-number', label: '调整数量(g)', field: 'quantity_change', required: true },
  { type: 'textarea', label: '调整原因', field: 'remark', required: true, span: 24 }
]

const reset = () => {
  query.medicine_keyword = ''
  query.batch_number = ''
  query.quality_status = undefined
  search()
}

const saveStockIn = async () => {
  const valid = await stockInFormRef.value?.formRef?.validate()
  if (valid) return false
  await zhongyiApi.inventory.stockIn(stockInForm)
  Message.success('入库成功')
  stockInVisible.value = false
  resetStockIn()
  search()
  return true
}

const openAdjust = (row: Inventory) => {
  resetAdjust()
  adjustForm.inventory_id = row.id
  adjustVisible.value = true
}

const saveAdjust = async () => {
  const valid = await adjustFormRef.value?.formRef?.validate()
  if (valid) return false
  if (!adjustForm.quantity_change) {
    Message.warning('调整数量不能为 0')
    return false
  }
  await zhongyiApi.inventory.adjust(adjustForm)
  Message.success('库存已调整')
  adjustVisible.value = false
  search()
  return true
}

const onTabChange = (key: string | number) => {
  if (key === 'transactions') transactionSearch()
}

const formatDate = (value?: string) => (value ? dayjs(value).format('YYYY-MM-DD') : '-')
const formatMoney = (value?: number) => (value == null ? '-' : `¥${Number(value).toFixed(2)}`)

const columns: TableColumnData[] = [
  { title: '药品', dataIndex: 'medicine_name', width: 170 },
  { title: '批号', dataIndex: 'batch_number', width: 150 },
  { title: '库存(g)', dataIndex: 'quantity_g', width: 110, align: 'right' },
  { title: '采购价', dataIndex: 'purchase_price', width: 110, align: 'right', render: ({ record }) => formatMoney(record.purchase_price) },
  { title: '供应商ID', dataIndex: 'supplier_id', width: 100, render: ({ record }) => record.supplier_id ?? '-' },
  { title: '生产日期', dataIndex: 'production_date', width: 120, render: ({ record }) => formatDate(record.production_date) },
  { title: '有效期', dataIndex: 'expiry_date', width: 120, render: ({ record }) => formatDate(record.expiry_date) },
  { title: '库位', dataIndex: 'storage_location', width: 120, render: ({ record }) => record.storage_location || '-' },
  { title: '质量状态', width: 100, render: ({ record }) => <Tag color={record.quality_status === 'qualified' ? 'green' : 'orange'}>{record.quality_status || '-'}</Tag> },
  { title: '是否耗尽', dataIndex: 'is_exhausted', width: 100, render: ({ record }) => <Tag color={record.is_exhausted ? 'gray' : 'arcoblue'}>{record.is_exhausted ? '已耗尽' : '在库'}</Tag> },
  { title: '状态', dataIndex: 'status', width: 90, render: ({ record }) => <Tag color={record.status === 1 ? 'green' : 'red'}>{record.status === 1 ? '启用' : '停用'}</Tag> },
  { title: '操作', width: 110, render: ({ record }) => <Space><a-button size="mini" onClick={() => openAdjust(record as Inventory)}>调整</a-button></Space> }
]

const transactionColumns: TableColumnData[] = [
  { title: '药品ID', dataIndex: 'medicine_id', width: 100 },
  { title: '批号', dataIndex: 'batch_number', width: 150 },
  { title: '交易类型', dataIndex: 'transaction_type', width: 120 },
  { title: '变动前(g)', dataIndex: 'quantity_before', width: 110 },
  { title: '变动量(g)', dataIndex: 'quantity_change', width: 110 },
  { title: '变动后(g)', dataIndex: 'quantity_after', width: 110 },
  { title: '操作时间', dataIndex: 'transaction_time', width: 180 },
  { title: '备注', dataIndex: 'remark', ellipsis: true }
]
</script>

<style lang="scss" scoped>
</style>
