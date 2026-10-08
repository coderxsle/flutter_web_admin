<template>
  <GiPageLayout margin>
    <GiTable row-key="id" :data="tableData" :loading="loading" :columns="columns"
      :pagination="pagination" :scroll="{ x: '100%', y: '100%', minWidth: 1150 }" @refresh="refresh">
      <template #custom-title>
        <a-button type="primary" @click="createVisible = true"><template #icon><icon-plus /></template>新建收费单</a-button>
      </template>
      <template #custom-extra>
        <a-input v-model="query.patient_name" placeholder="患者姓名" allow-clear />
        <a-input v-model="query.bill_no" placeholder="账单号" allow-clear @press-enter="search" />
        <GiButton type="search" @click="search" />
        <GiButton type="reset" @click="reset" />
      </template>
    </GiTable>

    <a-modal v-model:visible="detailVisible" title="账单详情" width="820px">
      <a-descriptions v-if="detail" :column="3" bordered>
        <a-descriptions-item label="账单号">{{ detail.bill_no }}</a-descriptions-item>
        <a-descriptions-item label="患者">{{ detail.patient_name }}</a-descriptions-item>
        <a-descriptions-item label="收费阶段">{{ detail.billing_stage }}</a-descriptions-item>
        <a-descriptions-item label="应收">{{ detail.total_amount }}</a-descriptions-item>
        <a-descriptions-item label="已收">{{ detail.paid_amount }}</a-descriptions-item>
        <a-descriptions-item label="已退">{{ detail.refunded_amount }}</a-descriptions-item>
      </a-descriptions>
      <GiTable v-if="detail" row-key="id" :data="detail.items" :pagination="false" :columns="itemColumns"
        @refresh="openDetail(detail)" />
    </a-modal>

    <a-modal v-model:visible="payVisible" title="收款" width="500px" @before-ok="pay">
      <GiForm ref="payFormRef" :model-value="payForm" :columns="payColumns"
        @update:model-value="Object.assign(payForm, $event)" />
    </a-modal>
    <a-modal v-model:visible="refundVisible" title="申请退款" width="500px" @before-ok="refund">
      <GiForm ref="refundFormRef" :model-value="refundForm" :columns="refundColumns"
        @update:model-value="Object.assign(refundForm, $event)" />
    </a-modal>
    <a-modal v-model:visible="createVisible" title="新建收费单" width="780px" :mask-closable="false"
      @before-ok="createBill" @close="resetCreate">
      <GiForm ref="createFormRef" :model-value="createForm" :columns="createColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }" @update:model-value="Object.assign(createForm, $event)" />
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { Billing } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Modal, Space, Tag } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

defineOptions({ name: 'ZhongyiBilling' })

const query = reactive<{ patient_name: string, bill_no: string }>({ patient_name: '', bill_no: '' })
const detailVisible = ref(false)
const payVisible = ref(false)
const refundVisible = ref(false)
const createVisible = ref(false)
const currentId = ref<number | null>(null)
const detail = ref<Billing>()
const payFormRef = useTemplateRef<InstanceType<typeof GiForm>>('payFormRef')
const refundFormRef = useTemplateRef<InstanceType<typeof GiForm>>('refundFormRef')
const createFormRef = useTemplateRef<InstanceType<typeof GiForm>>('createFormRef')
const [payForm, resetPay] = useResetReactive({ channel: 'cash', amount: 0, transaction_no: '' })
const [refundForm, resetRefund] = useResetReactive({ amount: 0, reason: '' })
const [createForm, resetCreate] = useResetReactive({
  patient_id: undefined as number | undefined,
  billing_stage: 'outpatient',
  item_name: '',
  item_type: 'service',
  quantity: 1,
  unit_price: 0,
  unit: '次',
  remark: ''
})

const { loading, tableData, pagination, search, refresh } = useTable({
  listAPI: (page) => zhongyiApi.billing.list({ ...page, ...query })
})

const payColumns: FormColumnItem[] = [
  { type: 'select', label: '支付方式', field: 'channel', props: { options: [{ label: '现金', value: 'cash' }, { label: '微信', value: 'wechat' }, { label: '支付宝', value: 'alipay' }, { label: '银行卡', value: 'bank' }] } },
  { type: 'input-number', label: '收款金额', field: 'amount', required: true, props: { min: 0.01 } },
  { type: 'input', label: '交易流水号', field: 'transaction_no' }
]
const refundColumns: FormColumnItem[] = [
  { type: 'input-number', label: '退款金额', field: 'amount', required: true, props: { min: 0.01 } },
  { type: 'textarea', label: '退款原因', field: 'reason', required: true }
]
const createColumns: FormColumnItem[] = [
  { type: 'input-number', label: '患者ID', field: 'patient_id', required: true },
  { type: 'select', label: '收费阶段', field: 'billing_stage', props: { options: [{ label: '门诊', value: 'outpatient' }, { label: '复诊', value: 'follow_up' }] } },
  { type: 'input', label: '项目名称', field: 'item_name', required: true },
  { type: 'input', label: '项目类型', field: 'item_type', required: true },
  { type: 'input-number', label: '数量', field: 'quantity', required: true, props: { min: 1, step: 1, precision: 0 } },
  { type: 'input-number', label: '单价', field: 'unit_price', required: true, props: { min: 0 } },
  { type: 'input', label: '单位', field: 'unit' },
  { type: 'textarea', label: '备注', field: 'remark', span: 24 }
]

const reset = () => {
  query.patient_name = ''
  query.bill_no = ''
  search()
}

const openDetail = async (row: Billing) => {
  detail.value = (await zhongyiApi.billing.detail(row.id)).data
  detailVisible.value = true
}

const openPay = (row: Billing) => {
  currentId.value = row.id
  resetPay()
  payForm.amount = Math.max(0, Number(row.total_amount) - Number(row.paid_amount))
  payVisible.value = true
}

const openRefund = (row: Billing) => {
  currentId.value = row.id
  resetRefund()
  refundVisible.value = true
}

const pay = async () => {
  const valid = await payFormRef.value?.formRef?.validate()
  if (valid || !currentId.value) return false
  await zhongyiApi.billing.pay(currentId.value, payForm)
  Message.success('收款成功')
  payVisible.value = false
  search()
  return true
}

const refund = async () => {
  const valid = await refundFormRef.value?.formRef?.validate()
  if (valid || !currentId.value) return false
  await zhongyiApi.billing.refund(currentId.value, refundForm)
  Message.success('退款申请已提交')
  refundVisible.value = false
  search()
  return true
}

const cancel = async (row: Billing) => {
  await zhongyiApi.billing.cancel(row.id)
  Message.success('账单已取消')
  search()
  return true
}

const createBill = async () => {
  const valid = await createFormRef.value?.formRef?.validate()
  if (valid) return false
  await zhongyiApi.billing.create({
    patient_id: createForm.patient_id,
    billing_stage: createForm.billing_stage,
    remark: createForm.remark,
    items: [{
      item_type: createForm.item_type,
      item_name: createForm.item_name,
      quantity: createForm.quantity,
      unit_price: createForm.unit_price,
      unit: createForm.unit
    }]
  })
  Message.success('收费单已创建')
  createVisible.value = false
  resetCreate()
  search()
  return true
}

const columns: TableColumnData[] = [
  { title: '账单号', dataIndex: 'bill_no', width: 170 },
  { title: '患者', dataIndex: 'patient_name', width: 130 },
  { title: '收费阶段', dataIndex: 'billing_stage', width: 110 },
  {
    title: '收费项目',
    width: 240,
    ellipsis: true,
    tooltip: true,
    render: ({ record }) => (record as Billing).items.map(item => `${item.item_name} ×${item.quantity}`).join('、')
  },
  { title: '应收', dataIndex: 'total_amount', width: 100, align: 'right' },
  { title: '已收', dataIndex: 'paid_amount', width: 100, align: 'right' },
  { title: '已退', dataIndex: 'refunded_amount', width: 100, align: 'right' },
  { title: '支付状态', width: 110, render: ({ record }) => <Tag color={record.payment_status === 'paid' ? 'green' : 'orange'}>{record.payment_status}</Tag> },
  {
    title: '操作',
    width: 280,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <a-button size="mini" onClick={() => openDetail(record as Billing)}>详情</a-button>
        <a-button size="mini" type="primary" onClick={() => openPay(record as Billing)} disabled={record.payment_status === 'paid'}>收款</a-button>
        <a-button size="mini" status="warning" onClick={() => openRefund(record as Billing)} disabled={record.paid_amount <= record.refunded_amount}>退款</a-button>
        <a-button size="mini" status="danger" onClick={() => Modal.warning({ title: '取消账单', content: '确定取消该账单吗？', onBeforeOk: () => cancel(record as Billing) })} disabled={record.status !== 1}>取消</a-button>
      </Space>
    )
  }
]

const itemColumns: TableColumnData[] = [
  { title: '项目', dataIndex: 'item_name' },
  { title: '数量', dataIndex: 'quantity', width: 90 },
  { title: '单价', dataIndex: 'unit_price', width: 100 },
  { title: '金额', dataIndex: 'amount', width: 100 },
  { title: '退款数量', dataIndex: 'refunded_quantity', width: 100 }
]
</script>

<style lang="scss" scoped>
</style>
