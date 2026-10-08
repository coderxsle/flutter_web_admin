<template>
  <GiPageLayout margin>
    <GiTable row-key="id" :data="treeData" :columns="columns" :loading="loading"
      :pagination="false" :scroll="{ x: '100%', y: '100%', minWidth: 900 }"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="onSelect"
      @select-all="onSelectAll" @refresh="loadTree">
      <template #custom-title>
        <GiButton type="add" @click="openAdd()" />
        <GiButton type="delete" @click="batchDelete" />
      </template>
      <template #custom-extra>
        <a-input v-model="keyword" placeholder="科室名称 / 编码" allow-clear @press-enter="loadTree" />
        <GiButton type="search" @click="loadTree" />
      </template>
    </GiTable>

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑科室' : '新增科室'" width="560px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="form" :columns="formColumns"
        @update:model-value="Object.assign(form, $event)" />
    </a-modal>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { Department } from '@/apis/zhongyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Popconfirm, Space, Tag } from '@arco-design/web-vue'
import { zhongyiApi } from '@/apis/zhongyi'
import { GiForm } from '@/components/index'
import { useResetReactive } from '@/hooks'

defineOptions({ name: 'ZhongyiDepartment' })

const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const loading = ref(false)
const keyword = ref('')
const treeData = ref<Department[]>([])
const selectedKeys = ref<(string | number)[]>([])
const formVisible = ref(false)
const editingId = ref<number | null>(null)
const [form, resetForm] = useResetReactive({
  name: '',
  code: '',
  parent_id: 0,
  sort_order: 0,
  is_active: true,
  phone: '',
  description: ''
})

const flatten = (nodes: Department[]): Department[] => nodes.flatMap((item) => [item, ...flatten(item.children || [])])
const allDepartments = computed(() => flatten(treeData.value))

const formColumns = computed<FormColumnItem[]>(() => [
  { type: 'tree-select', label: '上级科室', field: 'parent_id', props: { data: treeData.value, fieldNames: { key: 'id', title: 'name', children: 'children' }, allowClear: true } },
  { type: 'input', label: '科室名称', field: 'name', required: true },
  { type: 'input', label: '科室编码', field: 'code', required: true },
  { type: 'input-number', label: '排序', field: 'sort_order' },
  { type: 'input', label: '联系电话', field: 'phone' },
  { type: 'switch', label: '启用状态', field: 'is_active', props: { type: 'round', checkedText: '启用', uncheckedText: '停用' } },
  { type: 'textarea', label: '描述', field: 'description', span: 24 }
])

const loadTree = async () => {
  loading.value = true
  try {
    treeData.value = (await zhongyiApi.department.tree(keyword.value ? { name: keyword.value } : undefined)).data
    selectedKeys.value = []
  } finally {
    loading.value = false
  }
}
loadTree()

const openAdd = (parentId = 0) => {
  editingId.value = null
  resetForm()
  form.parent_id = parentId
  formVisible.value = true
}

const openEdit = async (row: Department) => {
  editingId.value = row.id
  Object.assign(form, (await zhongyiApi.department.detail(row.id)).data)
  formVisible.value = true
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  if (editingId.value) await zhongyiApi.department.update(editingId.value, form)
  else await zhongyiApi.department.create(form)
  Message.success(editingId.value ? '科室已更新' : '科室已创建')
  formVisible.value = false
  loadTree()
  return true
}

const remove = async (id: number) => {
  await zhongyiApi.department.remove([id])
  Message.success('科室已删除')
  loadTree()
  return true
}

const batchDelete = async () => {
  if (!selectedKeys.value.length) {
    Message.warning('请选择要删除的科室')
    return
  }
  await zhongyiApi.department.remove(selectedKeys.value.map(Number))
  selectedKeys.value = []
  Message.success('科室已删除')
  loadTree()
}

const onSelect = (keys: (string | number)[]) => {
  selectedKeys.value = keys
}
const onSelectAll = (checked: boolean) => {
  selectedKeys.value = checked ? allDepartments.value.map((item) => item.id) : []
}

const columns: TableColumnData[] = [
  { title: '科室名称', dataIndex: 'name', width: 220 },
  { title: '编码', dataIndex: 'code', width: 150 },
  { title: '排序', dataIndex: 'sort_order', width: 90, align: 'center' },
  { title: '联系电话', dataIndex: 'phone', width: 140 },
  { title: '状态', width: 90, render: ({ record }) => <Tag color={record.is_active ? 'green' : 'gray'}>{record.is_active ? '启用' : '停用'}</Tag> },
  { title: '描述', dataIndex: 'description', ellipsis: true },
  {
    title: '操作',
    width: 210,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <GiButton type="add" size="mini" status="success" onClick={() => openAdd(record.id)} />
        <GiButton type="edit" size="mini" onClick={() => openEdit(record as Department)} />
        <Popconfirm type="warning" content="确定删除该科室吗？" onBeforeOk={() => remove(record.id)}>
          <GiButton type="delete" size="mini" />
        </Popconfirm>
      </Space>
    )
  }
]
</script>

<style lang="scss" scoped>
</style>
