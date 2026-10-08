<template>
  <GiPageLayout margin>
    <GiTable row-key="id" title="会员列表" :loading="loading" :columns="columns" :data="tableData"
      :scroll="{ x: '100%', y: '100%', minWidth: 1200 }" :row-selection="{ type: 'checkbox', showCheckedAll: true }"
      :pagination="pagination" :disabled-column-keys="['序号', 'name']" @refresh="getTableData">
      <template #custom-extra>
        <GiButton type="add" @click="onAdd"></GiButton>
        <GiButton type="delete" @click="onBatchDelete"></GiButton>
        <GiButton type="import" @click="onImport"></GiButton>
        <GiCodeButton :code="CodeJson"></GiCodeButton>
      </template>
      <template #action="{ record }">
        <a-space>
          <template #split>
            <a-divider direction="vertical" :margin="0" />
          </template>
          <a-link>编辑</a-link>
          <a-link>详情</a-link>
          <a-popconfirm type="warning" content="您确定要删除该项吗?" :ok-button-props="{ status: 'danger' }"
            @before-ok="onDelete(record)">
            <a-link status="danger">删除</a-link>
          </a-popconfirm>
        </a-space>
      </template>
    </GiTable>

    <GiFooter></GiFooter>
  </GiPageLayout>
</template>

<script setup lang="ts">
import type { TableInstance } from '@arco-design/web-vue'
import type * as T from '@/apis/person'
import { Message, Tag } from '@arco-design/web-vue'
import { baseAPI } from '@/apis/person'
import { GiCellAvatar, GiCellGender, GiCellStatus } from '@/components/GiCell'
import { useTable } from '@/hooks'
import CodeJson from './index.vue?raw'

defineOptions({ name: 'TableCustom' })

const onClickName = (record: T.ListItem) => {
  Message.success(`点击了${record.name}`)
}

const columns: TableInstance['columns'] = [
  { title: '序号', width: 66, align: 'center', render: ({ rowIndex }) => h('span', {}, rowIndex + 1) },
  {
    title: '姓名',
    dataIndex: 'name',
    width: 120,
    render: ({ record }) => h(GiCellAvatar, {
      isLink: true,
      avatar: record.avatar,
      name: record.name,
      onClick: () => onClickName(record as T.ListItem)
    })
  },
  { title: '手机号', dataIndex: 'phone', width: 150 },
  { title: '性别', dataIndex: 'gender', width: 100, align: 'center', render: ({ record }) => h(GiCellGender, { gender: record.gender }) },
  { title: '角色', width: 100, align: 'center', render: () => h(Tag, { color: '#7816ff' }, () => '普通用户') },
  { title: '状态', width: 100, align: 'center', render: ({ record }) => h(GiCellStatus, { status: record.status }) },
  { title: '创建时间', dataIndex: 'createTime', width: 180, ellipsis: true, tooltip: true, sortable: { sortDirections: ['ascend', 'descend'] } },
  { title: '地址', dataIndex: 'address', ellipsis: true, tooltip: true },
  { title: '操作', width: 180, slotName: 'action', align: 'center' }
]

const { tableData, getTableData, pagination, loading, onDelete, onBatchDelete, onImport } = useTable({
  listAPI: (p) => baseAPI.getList(p),
  deleteAPI: (ids) => baseAPI.deleteBatch(ids),
  immediate: true
})

const onAdd = () => {
  Message.info('点击了新增')
}
</script>

<style lang="scss" scoped></style>
