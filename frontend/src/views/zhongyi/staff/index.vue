<template>
  <GiPageLayout margin>
    <a-row justify="space-between" class="g-row-tool">
      <a-space>
        <GiButton type="add" @click="openAdd" />
        <GiButton type="delete" @click="onBatchDelete" />
      </a-space>
      <a-space>
        <a-input v-model="query.employee_code" placeholder="员工编号" allow-clear />
        <a-select v-model="query.department_id" :options="departmentOptions" placeholder="科室" allow-clear />
        <a-select v-model="query.is_doctor" :options="booleanOptions" placeholder="医生" allow-clear />
        <GiButton type="search" @click="search" />
        <GiButton type="reset" @click="reset" />
      </a-space>
    </a-row>
    <a-table class="g-table" row-key="id" :data="tableData" :loading="loading" :columns="columns"
      :pagination="pagination" :bordered="{ cell: true }" :scroll="{ x: '100%', y: '100%', minWidth: 1100 }"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll" />

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑员工' : '新增员工'" width="760px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="form" :columns="formColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }" @update:model-value="Object.assign(form, $event)" />
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { Department, Staff } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Popconfirm, Space, Tag } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

defineOptions({ name: 'ZhongyiStaff' })

const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const formVisible = ref(false)
const editingId = ref<number | null>(null)
const departments = ref<Department[]>([])
const query = reactive<{ employee_code: string, department_id?: number, is_doctor?: boolean }>({ employee_code: '' })
const booleanOptions = [{ label: '是', value: true }, { label: '否', value: false }]
const [form, resetForm] = useResetReactive({
  user_id: undefined as number | undefined,
  department_id: undefined as number | undefined,
  employee_code: '',
  professional_title: '',
  license_number: '',
  specialization: '',
  is_doctor: false,
  is_pharmacist: false,
  consultation_fee: 0,
  introduction: '',
  description: ''
})

const flatten = (nodes: Department[]): Department[] => nodes.flatMap((item) => [item, ...flatten(item.children || [])])
const departmentOptions = computed(() => flatten(departments.value).map((item) => ({ label: item.name, value: item.id })))
const formColumns = computed<FormColumnItem[]>(() => [
  { type: 'input-number', label: '系统用户ID', field: 'user_id', required: true },
  { type: 'select', label: '所属科室', field: 'department_id', props: { options: departmentOptions.value, allowSearch: true } },
  { type: 'input', label: '员工编号', field: 'employee_code', required: true },
  { type: 'input', label: '职称', field: 'professional_title' },
  { type: 'input', label: '执业证号', field: 'license_number' },
  { type: 'input', label: '专长', field: 'specialization' },
  { type: 'switch', label: '医生', field: 'is_doctor', props: { type: 'round', checkedText: '是', uncheckedText: '否' } },
  { type: 'switch', label: '药师', field: 'is_pharmacist', props: { type: 'round', checkedText: '是', uncheckedText: '否' } },
  { type: 'input-number', label: '诊金', field: 'consultation_fee', props: { min: 0 } },
  { type: 'textarea', label: '介绍', field: 'introduction', span: 24 },
  { type: 'textarea', label: '备注', field: 'description', span: 24 }
])

const { loading, tableData, pagination, selectedKeys, search, select, selectAll, onBatchDelete } = useTable({
  listAPI: (page) => zhongyiApi.staff.list({ ...page, ...query }),
  deleteAPI: (ids) => zhongyiApi.staff.remove(ids)
})

const loadDepartments = async () => {
  departments.value = (await zhongyiApi.department.tree()).data
}
loadDepartments()

const reset = () => {
  query.employee_code = ''
  query.department_id = undefined
  query.is_doctor = undefined
  search()
}

const openAdd = () => {
  editingId.value = null
  resetForm()
  formVisible.value = true
}

const openEdit = async (row: Staff) => {
  editingId.value = row.id
  Object.assign(form, (await zhongyiApi.staff.detail(row.id)).data)
  formVisible.value = true
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  if (editingId.value) await zhongyiApi.staff.update(editingId.value, form)
  else await zhongyiApi.staff.create(form)
  Message.success(editingId.value ? '员工已更新' : '员工已创建')
  formVisible.value = false
  search()
  return true
}

const columns: TableColumnData[] = [
  { title: '员工编号', dataIndex: 'employee_code', width: 130 },
  { title: '姓名', dataIndex: 'name', width: 130 },
  { title: '用户名', dataIndex: 'username', width: 140 },
  { title: '职称', dataIndex: 'professional_title', width: 130 },
  { title: '手机号', dataIndex: 'mobile', width: 140 },
  { title: '医生', width: 80, render: ({ record }) => <Tag color={record.is_doctor ? 'green' : 'gray'}>{record.is_doctor ? '是' : '否'}</Tag> },
  { title: '药师', width: 80, render: ({ record }) => <Tag color={record.is_pharmacist ? 'green' : 'gray'}>{record.is_pharmacist ? '是' : '否'}</Tag> },
  { title: '诊金', dataIndex: 'consultation_fee', width: 90 },
  {
    title: '操作',
    width: 140,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <GiButton type="edit" size="mini" onClick={() => openEdit(record as Staff)} />
        <Popconfirm
          type="warning"
          content="确定删除该员工吗？"
          onBeforeOk={async () => {
            await zhongyiApi.staff.remove([record.id])
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
