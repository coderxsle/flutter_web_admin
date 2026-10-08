<template>
  <GiPageLayout margin>
    <GiForm :model-value="form" search :columns="searchColumns"
      :grid-item-props="{ span: { xs: 24, sm: 12, md: 8, lg: 8, xl: 6, xxl: 6 } }"
      @update:model-value="Object.assign(form, $event)" @search="search" @reset="reset">
    </GiForm>

    <GiTable row-key="id" :loading="loading" :columns="columns" :data="tableData"
      :scroll="{ x: '100%', y: '100%', minWidth: 2600 }" :row-selection="{ type: 'checkbox', showCheckedAll: true }"
      :selected-keys="selectedKeys" :pagination="pagination" :disabled-column-keys="['序号', 'name']"
      @select="select" @select-all="selectAll" @refresh="getTableData">
      <template #custom-title>
        <GiButton type="add" @click="openAdd"></GiButton>
        <GiButton type="delete" @click="onBatchDelete"></GiButton>
        <GiButton type="import" @click="onImport"></GiButton>
        <GiCodeButton :code="CodeJson"></GiCodeButton>
      </template>
      <template #action="{ record }">
        <a-space>
          <GiButton type="edit" size="mini" @click="openEdit(record as Patient)"></GiButton>
          <a-button size="mini" @click="openDetail(record as Patient)">详情</a-button>
          <a-popconfirm type="warning" content="您确定要删除该患者档案吗?" @before-ok="onDelete(record as Patient)">
            <GiButton type="delete" size="mini"></GiButton>
          </a-popconfirm>
        </a-space>
      </template>
    </GiTable>

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑患者' : '新增患者'" width="820px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="patientForm" :columns="formColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }"
        @update:model-value="Object.assign(patientForm, $event)" />
    </a-modal>

    <a-modal v-model:visible="detailVisible" title="患者档案详情" width="760px">
      <a-descriptions v-if="detail" :column="2" bordered>
        <a-descriptions-item label="姓名">{{ detail.name }}</a-descriptions-item>
        <a-descriptions-item label="性别">
          <GiCellGender v-if="detail.gender" :gender="genderCode(detail.gender)" />
          <span v-else>-</span>
        </a-descriptions-item>
        <a-descriptions-item label="出生日期">{{ detail.birth_date || '-' }}</a-descriptions-item>
        <a-descriptions-item label="联系电话">{{ detail.phone || '-' }}</a-descriptions-item>
        <a-descriptions-item label="身份证号">{{ detail.id_card || '-' }}</a-descriptions-item>
        <a-descriptions-item label="体质">{{ detail.constitution || '-' }}</a-descriptions-item>
        <a-descriptions-item label="过敏史" :span="2">{{ detail.allergy_history || '-' }}</a-descriptions-item>
        <a-descriptions-item label="既往病史" :span="2">{{ detail.medical_history || '-' }}</a-descriptions-item>
        <a-descriptions-item label="地址" :span="2">{{ detail.address || '-' }}</a-descriptions-item>
      </a-descriptions>
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableInstance } from '@arco-design/web-vue'
import type { Patient } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiCellGender, GiForm } from '@/components/index'
import { useDict, useResetReactive, useTable } from '@/hooks'

import CodeJson from './index.vue?raw'

defineOptions({ name: 'ZhongyiPatient' })

const { dictData } = useDict(['gender', 'GENDER'] as const)
const form = reactive<{ name: string, phone: string, gender?: number }>({
  name: '',
  phone: ''
})
const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const formVisible = ref(false)
const detailVisible = ref(false)
const editingId = ref<number | null>(null)
const detail = ref<Patient>()

const genderCode = (value?: number | string) => {
  const code = String(value)
  if (code === '1' || code === '2' || code === '3') return code
  if (code === 'male') return '1'
  if (code === 'female') return '2'
  if (code === 'other') return '3'
  return code
}

const genderValue = (value: unknown) => {
  const code = String(value)
  if (code === '1' || code === '2' || code === '3') return Number(code)
  if (code === 'male') return 1
  if (code === 'female') return 2
  if (code === 'other') return 3
  return Number(code)
}

const genderOptions = computed(() => {
  const options = dictData.value.gender.length ? dictData.value.gender : dictData.value.GENDER
  return options.map((item) => ({ ...item, value: genderValue(item.value) }))
})

const [patientForm, resetForm] = useResetReactive({
  name: '',
  gender: 3,
  birth_date: '',
  phone: '',
  id_card: '',
  address: '',
  occupation: '',
  blood_type: '',
  emergency_contact: '',
  emergency_phone: '',
  allergy_history: '',
  medical_history: '',
  family_history: '',
  constitution: '',
  source: 'manual'
})

const searchColumns = computed<FormColumnItem[]>(() => [
  { type: 'input', label: '姓名', field: 'name' },
  { type: 'input', label: '手机', field: 'phone', props: { maxLength: 11 } },
  { type: 'select', label: '性别', field: 'gender', props: { options: genderOptions.value } }
])

const { loading, tableData, pagination, selectedKeys, search, select, selectAll, getTableData, onDelete, onBatchDelete, onImport } = useTable({
  listAPI: (page) => zhongyiApi.patient.list({
    ...page,
    name: form.name || undefined,
    phone: form.phone || undefined,
    gender: form.gender || undefined
  }),
  deleteAPI: (ids) => zhongyiApi.patient.remove(ids)
})

const formColumns = computed<FormColumnItem[]>(() => [
  { type: 'input', label: '姓名', field: 'name', required: true },
  { type: 'select', label: '性别', field: 'gender', props: { options: genderOptions.value } },
  { type: 'date-picker', label: '出生日期', field: 'birth_date', props: { valueFormat: 'YYYY-MM-DD' } },
  { type: 'input', label: '联系电话', field: 'phone' },
  { type: 'input', label: '身份证号', field: 'id_card' },
  { type: 'input', label: '职业', field: 'occupation' },
  { type: 'input', label: '血型', field: 'blood_type' },
  { type: 'input', label: '体质类型', field: 'constitution' },
  { type: 'input', label: '紧急联系人', field: 'emergency_contact' },
  { type: 'input', label: '紧急联系电话', field: 'emergency_phone' },
  { type: 'input', label: '来源', field: 'source' },
  { type: 'textarea', label: '地址', field: 'address', span: 24 },
  { type: 'textarea', label: '过敏史', field: 'allergy_history', span: 24 },
  { type: 'textarea', label: '既往病史', field: 'medical_history', span: 24 },
  { type: 'textarea', label: '家族病史', field: 'family_history', span: 24 }
])

const openDetail = async (row: Patient) => {
  detail.value = (await zhongyiApi.patient.detail(row.id)).data
  detailVisible.value = true
}

const columns: TableInstance['columns'] = [
  { title: '序号', width: 66, align: 'center', render: ({ rowIndex }) => h('span', {}, rowIndex + 1) },
  {
    title: '姓名',
    dataIndex: 'name',
    width: 140,
    render: ({ record }) => h('a', {
      class: 'arco-link',
      onClick: () => openDetail(record as Patient)
    }, record.name)
  },
  { title: '手机号', dataIndex: 'phone', width: 150 },
  {
    title: '性别',
    dataIndex: 'gender',
    width: 100,
    align: 'center',
    render: ({ record }) => record.gender ? h(GiCellGender, { gender: genderCode(record.gender) }) : h('span', {}, '-')
  },
  { title: '出生日期', dataIndex: 'birth_date', width: 130 },
  { title: '身份证号', dataIndex: 'id_card', width: 180 },
  { title: '地址', dataIndex: 'address', width: 220, ellipsis: true, tooltip: true },
  { title: '职业', dataIndex: 'occupation', width: 120 },
  { title: '血型', dataIndex: 'blood_type', width: 80, align: 'center' },
  { title: '紧急联系人', dataIndex: 'emergency_contact', width: 130 },
  { title: '紧急联系电话', dataIndex: 'emergency_phone', width: 150 },
  { title: '过敏史', dataIndex: 'allergy_history', width: 220, ellipsis: true, tooltip: true },
  { title: '既往病史', dataIndex: 'medical_history', width: 220, ellipsis: true, tooltip: true },
  { title: '家族病史', dataIndex: 'family_history', width: 220, ellipsis: true, tooltip: true },
  { title: '体质', dataIndex: 'constitution', width: 120 },
  { title: '来源', dataIndex: 'source', width: 110 },
  {
    title: '建档时间',
    dataIndex: 'create_time',
    width: 180,
    ellipsis: true,
    tooltip: true,
    sortable: { sortDirections: ['ascend', 'descend'] }
  },
  { title: '更新时间', dataIndex: 'update_time', width: 180, ellipsis: true, tooltip: true },
  { title: '操作', width: 200, slotName: 'action', align: 'center', fixed: 'right' }
]

const reset = () => {
  form.name = ''
  form.phone = ''
  form.gender = undefined
  search()
}

const openAdd = () => {
  editingId.value = null
  resetForm()
  formVisible.value = true
}

const openEdit = async (row: Patient) => {
  editingId.value = row.id
  Object.assign(patientForm, (await zhongyiApi.patient.detail(row.id)).data)
  formVisible.value = true
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  if (editingId.value) await zhongyiApi.patient.update(editingId.value, patientForm)
  else await zhongyiApi.patient.create(patientForm)
  Message.success(editingId.value ? '患者档案已更新' : '患者档案已创建')
  formVisible.value = false
  search()
  return true
}
</script>

<style lang="scss" scoped></style>
