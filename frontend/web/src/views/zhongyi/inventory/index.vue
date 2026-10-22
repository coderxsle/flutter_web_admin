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
            <a-input v-model="query.medicineKeyword" placeholder="药品名称 / 拼音" allow-clear />
            <a-input v-model="query.batchNumber" placeholder="批号" allow-clear />
            <a-select v-model="query.qualityStatus" :options="qualityOptions" placeholder="质量状态" allow-clear />
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
const query = reactive<{ medicineKeyword: string, batchNumber: string, qualityStatus?: string }>({
  medicineKeyword: '',
  batchNumber: ''
})
const qualityOptions = [{ label: '合格', value: 'qualified' }, { label: '待检', value: 'pending' }, { label: '不合格', value: 'unqualified' }]
const [stockInForm, resetStockIn] = useResetReactive({
  medicineId: undefined as number | undefined,
  batchNumber: '',
  supplierId: undefined as number | undefined,
  quantityG: 0,
  unit: 'g',
  purchasePrice: 0,
  productionDate: undefined as string | undefined,
  expiryDate: undefined as string | undefined,
  qualityStatus: 'qualified',
  storageLocation: '',
  remark: ''
})
const [adjustForm, resetAdjust] = useResetReactive({
  inventoryId: 0,
  quantityChange: 0,
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
    field: 'medicineId',
    required: true,
    props: {
      options: medicineOptions.value.map((item) => ({ label: `${item.prefix ?? ''}${item.name} (${item.medicineCode})`, value: item.id })),
      allowSearch: true
    }
  },
  { type: 'input', label: '批号', field: 'batchNumber', required: true },
  { type: 'input-number', label: '供应商ID', field: 'supplierId', props: { min: 1, precision: 0 } },
  { type: 'input-number', label: '入库数量(g)', field: 'quantityG', required: true, props: { min: 0.01 } },
  { type: 'input', label: '单位', field: 'unit', required: true },
  { type: 'input-number', label: '采购价', field: 'purchasePrice', props: { min: 0, precision: 2 } },
  { type: 'date-picker', label: '生产日期', field: 'productionDate', props: { valueFormat: 'YYYY-MM-DD' } },
  { type: 'date-picker', label: '有效期', field: 'expiryDate', props: { valueFormat: 'YYYY-MM-DD' } },
  { type: 'select', label: '质量状态', field: 'qualityStatus', props: { options: qualityOptions } },
  { type: 'input', label: '库位', field: 'storageLocation' },
  { type: 'textarea', label: '备注', field: 'remark', span: 24 }
])

const adjustColumns: FormColumnItem[] = [
  { type: 'input-number', label: '库存ID', field: 'inventoryId', required: true, props: { disabled: true } },
  { type: 'input-number', label: '调整数量(g)', field: 'quantityChange', required: true },
  { type: 'textarea', label: '调整原因', field: 'remark', required: true, span: 24 }
]

const reset = () => {
  query.medicineKeyword = ''
  query.batchNumber = ''
  query.qualityStatus = undefined
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
  adjustForm.inventoryId = row.id
  adjustVisible.value = true
}

const saveAdjust = async () => {
  const valid = await adjustFormRef.value?.formRef?.validate()
  if (valid) return false
  if (!adjustForm.quantityChange) {
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
  { title: '药品', dataIndex: 'medicineName', width: 170 },
  { title: '批号', dataIndex: 'batchNumber', width: 150 },
  { title: '库存(g)', dataIndex: 'quantityG', width: 110, align: 'right' },
  { title: '采购价', dataIndex: 'purchasePrice', width: 110, align: 'right', render: ({ record }) => formatMoney(record.purchasePrice) },
  { title: '供应商ID', dataIndex: 'supplierId', width: 100, render: ({ record }) => record.supplierId ?? '-' },
  { title: '生产日期', dataIndex: 'productionDate', width: 120, render: ({ record }) => formatDate(record.productionDate) },
  { title: '有效期', dataIndex: 'expiryDate', width: 120, render: ({ record }) => formatDate(record.expiryDate) },
  { title: '库位', dataIndex: 'storageLocation', width: 120, render: ({ record }) => record.storageLocation || '-' },
  { title: '质量状态', width: 100, render: ({ record }) => <Tag color={record.qualityStatus === 'qualified' ? 'green' : 'orange'}>{record.qualityStatus || '-'}</Tag> },
  { title: '是否耗尽', dataIndex: 'isExhausted', width: 100, render: ({ record }) => <Tag color={record.isExhausted ? 'gray' : 'arcoblue'}>{record.isExhausted ? '已耗尽' : '在库'}</Tag> },
  { title: '状态', dataIndex: 'status', width: 90, render: ({ record }) => <Tag color={record.status === 1 ? 'green' : 'red'}>{record.status === 1 ? '启用' : '停用'}</Tag> },
  { title: '操作', width: 110, render: ({ record }) => <Space><a-button size="mini" onClick={() => openAdjust(record as Inventory)}>调整</a-button></Space> }
]

const transactionColumns: TableColumnData[] = [
  { title: '药品ID', dataIndex: 'medicineId', width: 100 },
  { title: '批号', dataIndex: 'batchNumber', width: 150 },
  { title: '交易类型', dataIndex: 'transactionType', width: 120 },
  { title: '变动前(g)', dataIndex: 'quantityBefore', width: 110 },
  { title: '变动量(g)', dataIndex: 'quantityChange', width: 110 },
  { title: '变动后(g)', dataIndex: 'quantityAfter', width: 110 },
  { title: '操作时间', dataIndex: 'transactionTime', width: 180 },
  { title: '备注', dataIndex: 'remark', ellipsis: true }
]
</script>

<style lang="scss" scoped>
</style>
