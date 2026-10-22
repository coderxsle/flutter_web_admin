<template>
  <GiPageLayout margin>
    <GiForm :model-value="query" search :columns="searchColumns"
      :grid-item-props="{ span: { xs: 24, sm: 12, md: 8, lg: 8, xl: 6, xxl: 6 } }"
      @update:model-value="Object.assign(query, $event)" @search="search" @reset="reset" />
    <GiTable row-key="id" :data="tableData" :loading="loading" :columns="columns" :pagination="pagination"
      :scroll="{ x: '100%', y: '100%', minWidth: 1600 }"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll" @refresh="refresh">
      <template #custom-title>
        <GiButton type="add" @click="openAdd" />
        <GiButton type="delete" @click="onBatchDelete" />
      </template>
    </GiTable>

    <a-modal v-model:visible="formVisible" :title="editingId ? '编辑排盘记录' : '新增排盘记录'" width="860px"
      :mask-closable="false" @before-ok="save" @close="resetForm">
      <GiForm ref="formRef" :model-value="form" :columns="formColumns"
        :grid-item-props="{ span: { xs: 24, sm: 12 } }" @update:model-value="Object.assign(form, $event)" />
    </a-modal>

    <ArtsRecordDetailDrawer ref="detailDrawerRef" />
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { ArtsRecord } from '@/apis/zhouyi'
import type { FormColumnItem } from '@/components/index'
import { Message, Popconfirm, Space, Switch, Tag } from '@arco-design/web-vue'
import { zhouyiApi } from '@/apis/zhouyi'
import { GiForm } from '@/components/index'
import { useResetReactive, useTable } from '@/hooks'

import ArtsRecordDetailDrawer from './ArtsRecordDetailDrawer.vue'
import { ARTS_TYPE_OPTIONS, artsTypeLabel, toDateTimeText } from './utils'

defineOptions({ name: 'ZhouyiArtsRecord' })

const formRef = useTemplateRef<InstanceType<typeof GiForm>>('formRef')
const detailDrawerRef = useTemplateRef('detailDrawerRef')
const formVisible = ref(false)
const editingId = ref<number | null>(null)

const query = reactive<{ arts_type?: string, keyword: string, chart_time: string[], user_id?: number }>({
  keyword: '',
  chart_time: []
})

const searchColumns = computed<FormColumnItem[]>(() => [
  { type: 'select', label: '术数类型', field: 'arts_type', props: { options: ARTS_TYPE_OPTIONS } },
  { type: 'input', label: '关键词', field: 'keyword', props: { placeholder: '标题 / 问题 / 解读 / 反馈', maxLength: 50 } },
  {
    type: 'range-picker',
    label: '起盘时间',
    field: 'chart_time',
    props: { showTime: true, valueFormat: 'YYYY-MM-DD HH:mm:ss', style: { width: '100%' } }
  },
  { type: 'input-number', label: '用户ID', field: 'user_id', props: { min: 1, placeholder: '空白即全部' } }
])

/** 空串和空数组不传，避免拼出 `?keyword=` 这种脏参数 */
const buildParams = () => {
  const [startTime, endTime] = query.chart_time ?? []
  return {
    arts_type: query.arts_type || undefined,
    keyword: query.keyword.trim() || undefined,
    start_time: startTime || undefined,
    end_time: endTime || undefined,
    user_id: query.user_id || undefined
  }
}

const { loading, tableData, pagination, selectedKeys, search, refresh, select, selectAll, onDelete, onBatchDelete } = useTable({
  listAPI: (page) => zhouyiApi.artsRecord.list({ ...page, ...buildParams() }),
  deleteAPI: (ids) => zhouyiApi.artsRecord.remove(ids)
})

const [form, resetForm] = useResetReactive({
  arts_type: '奇门',
  client_key: '',
  title: '',
  question: '',
  chart_time: '',
  interpretation: '',
  feedback: '',
  tags: [] as string[],
  status: 1
})

/** 类型与起盘时间只在新增时能改：update 接口不接收这两个字段 */
const formColumns = computed<FormColumnItem[]>(() => {
  const readonly = Boolean(editingId.value)
  return [
    { type: 'select', label: '术数类型', field: 'arts_type', required: true, disabled: readonly, props: { options: ARTS_TYPE_OPTIONS, allowClear: false } },
    {
      type: 'date-picker',
      label: '起盘时间',
      field: 'chart_time',
      disabled: readonly,
      props: { showTime: true, valueFormat: 'YYYY-MM-DD HH:mm:ss' }
    },
    { type: 'input', label: '标题', field: 'title', required: true, span: 24, props: { maxLength: 100 } },
    { type: 'textarea', label: '问题', field: 'question', span: 24, props: { maxLength: 500 } },
    { type: 'textarea', label: '解读', field: 'interpretation', span: 24, props: { maxLength: 5000 } },
    { type: 'textarea', label: '反馈', field: 'feedback', span: 24, props: { maxLength: 1000 } },
    { type: 'input-tag', label: '标签', field: 'tags', span: 24 },
    {
      type: 'switch',
      label: '状态',
      field: 'status',
      props: { type: 'round', checkedValue: 1, uncheckedValue: 0, checkedText: '启用', uncheckedText: '停用' }
    }
  ]
})

/** 新增按 client_key 幂等，同一次排盘重复提交不会多出一行 */
const newClientKey = () => `web-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`

const reset = () => {
  query.arts_type = undefined
  query.keyword = ''
  query.chart_time = []
  query.user_id = undefined
  search()
}

const openAdd = () => {
  editingId.value = null
  resetForm()
  form.client_key = newClientKey()
  formVisible.value = true
}

const openEdit = async (row: ArtsRecord) => {
  editingId.value = row.id
  const data = (await zhouyiApi.artsRecord.detail(row.id)).data
  Object.assign(form, {
    arts_type: data.arts_type,
    client_key: data.client_key,
    title: data.title,
    question: data.question,
    chart_time: toDateTimeText(data.chart_time),
    interpretation: data.interpretation,
    feedback: data.feedback,
    tags: data.tags ?? [],
    status: data.status
  })
  formVisible.value = true
}

const openDetail = (row: ArtsRecord) => {
  detailDrawerRef.value?.open(row.id)
}

const save = async () => {
  const valid = await formRef.value?.formRef?.validate()
  if (valid) return false
  if (editingId.value) {
    await zhouyiApi.artsRecord.update(editingId.value, {
      title: form.title,
      question: form.question,
      interpretation: form.interpretation,
      feedback: form.feedback,
      tags: form.tags,
      status: form.status
    })
  } else {
    await zhouyiApi.artsRecord.save({
      arts_type: form.arts_type,
      client_key: form.client_key || newClientKey(),
      title: form.title,
      question: form.question,
      chart_time: form.chart_time,
      interpretation: form.interpretation,
      feedback: form.feedback,
      tags: form.tags
    })
  }
  Message.success(editingId.value ? '排盘记录已更新' : '排盘记录已创建')
  formVisible.value = false
  search()
  return true
}

const toggleStatus = async (row: ArtsRecord, value: unknown) => {
  const status = Number(value)
  await zhouyiApi.artsRecord.status(row.id, status)
  Message.success(status === 1 ? '已启用' : '已停用')
  refresh()
}

const columns: TableColumnData[] = [
  { title: '序号', width: 66, align: 'center', render: ({ rowIndex }) => <span>{rowIndex + 1}</span> },
  {
    title: '术数类型',
    width: 110,
    render: ({ record }) => <Tag color={record.arts_type === '奇门' ? 'arcoblue' : 'purple'}>{artsTypeLabel(record.arts_type)}</Tag>
  },
  {
    title: '标题',
    width: 220,
    ellipsis: true,
    tooltip: true,
    render: ({ record }) => (
      <a class="arco-link" onClick={() => openDetail(record as ArtsRecord)}>{record.title || '-'}</a>
    )
  },
  { title: '问题', dataIndex: 'question', width: 240, ellipsis: true, tooltip: true },
  {
    title: '标签',
    width: 180,
    render: ({ record }) => {
      const tags = (record.tags ?? []) as string[]
      if (!tags.length) return <span>-</span>
      return <Space wrap size={4}>{tags.map((tag) => <Tag key={tag}>{tag}</Tag>)}</Space>
    }
  },
  { title: '用户ID', dataIndex: 'user_id', width: 90, align: 'center' },
  { title: '起盘时间', width: 170, render: ({ record }) => <span>{toDateTimeText(record.chart_time) || '-'}</span> },
  {
    title: '状态',
    width: 100,
    render: ({ record }) => (
      <Switch
        modelValue={record.status}
        checkedValue={1}
        uncheckedValue={0}
        checkedText="启用"
        uncheckedText="停用"
        onUpdate:modelValue={(value) => toggleStatus(record as ArtsRecord, value)}
      />
    )
  },
  { title: '创建时间', dataIndex: 'create_time', width: 170, ellipsis: true, tooltip: true },
  { title: '更新时间', dataIndex: 'update_time', width: 170, ellipsis: true, tooltip: true },
  {
    title: '操作',
    width: 190,
    fixed: 'right',
    render: ({ record }) => (
      <Space>
        <a-button size="mini" onClick={() => openDetail(record as ArtsRecord)}>详情</a-button>
        <GiButton type="edit" size="mini" onClick={() => openEdit(record as ArtsRecord)} />
        <Popconfirm
          type="warning"
          content="确定删除该排盘记录吗？"
          onBeforeOk={() => onDelete(record as ArtsRecord)}
        >
          <GiButton type="delete" size="mini" />
        </Popconfirm>
      </Space>
    )
  }
]
</script>

<style lang="scss" scoped></style>
