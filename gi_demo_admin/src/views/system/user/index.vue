<template>
  <GiPageLayout margin collapsed>
    <template #left>
      <a-input v-model="treeInputValue" placeholder="输入部门名称搜索" allow-clear :style="{ marginBottom: '8px' }">
        <template #prefix><icon-search /></template>
      </a-input>
      <div class="gi-full-column">
        <a-scrollbar style="height: 100%; overflow: auto" outer-style="height: 100%">
          <a-tree ref="treeRef" block-node show-line default-expand-all :data="deptList" :field-names="{
            key: 'id',
            title: 'name',
            children: 'children',
          }" @select="onDeptSelect">
          </a-tree>
        </a-scrollbar>
      </div>
    </template>

    <a-row justify="space-between" class="gi-row-tool">
      <a-space wrap>
        <GiButton type="add" @click="onAdd"></GiButton>
        <GiButton type="delete" @click="onBatchDelete"></GiButton>
        <!-- <GiButton type="reset" @click="onResetPassword">重置密码</GiButton> -->
        <!-- <a-button status="warning" @click="onResetPassword">重置密码</a-button> -->
        <a-button type="primary" status="warning" @click="onResetPassword">重置密码</a-button>
      </a-space>
      <a-space wrap>
        <a-input-group>
          <a-select v-model="queryParams.status" :options="dictData.common_status" placeholder="用户状态" allow-clear
            style="width: 150px"></a-select>
          <a-input v-model="queryParams.username" placeholder="输入用户名搜索" allow-clear style="max-width: 250px">
          </a-input>
        </a-input-group>
        <GiButton type="search" @click="search"></GiButton>
        <GiButton type="reset" @click="reset"></GiButton>
      </a-space>
    </a-row>

    <a-table class="gi-table" row-key="id" :loading="loading" :data="userList" :columns="tableColumns"
      :bordered="{ cell: true }" :scroll="{ x: '100%', y: '100%', minWidth: 1700 }" :pagination="pagination"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll">
    </a-table>

    <UserFormModal ref="UserFormModalRef" @save-success="search"></UserFormModal>
    <UserDetailDrawer ref="UserDetailDrawerRef"></UserDetailDrawer>
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type * as T from '@/apis/system/user'
import { Link, Popconfirm, Space, Tag, Message, Modal } from '@arco-design/web-vue'
import { baseAPI, getUserList, resetPassword } from '@/apis/system/user'
import { useDict, useTable } from '@/hooks'
import { useDept } from '@/hooks/app'
import UserDetailDrawer from './UserDetailDrawer.vue'
import UserFormModal from './UserFormModal.vue'

defineOptions({ name: 'SystemUser' })

const { dictData } = useDict(['common_status'])
const treeRef = useTemplateRef('treeRef')
const UserFormModalRef = useTemplateRef('UserFormModalRef')
const UserDetailDrawerRef = useTemplateRef('UserDetailDrawerRef')
const treeInputValue = ref('')

const selectedDeptId = ref<number | undefined>(undefined)

const { deptList, getDeptList } = useDept({
  onSuccess: () => {
    nextTick(() => {
      treeRef.value?.expandAll(true)
      // 自动选中第一个部门
      if (deptList.value && deptList.value.length > 0) {
        const firstDeptId = deptList.value[0].id
        treeRef.value?.selectNode(firstDeptId)
        selectedDeptId.value = firstDeptId
        queryParams.deptId = firstDeptId
        search()
      }
    })
  }
})
getDeptList()
const queryParams = reactive<{ status?: string, username?: string, deptId?: number }>({ status: '' })

const { loading, tableData: userList, pagination, selectedKeys, search, refresh, select, selectAll, fixed, handleDelete } = useTable({
  listAPI: (page) => getUserList({ query: { ...page, ...queryParams } }),
  immediate: true
})

const onDeptSelect = (selectedKeys: (string | number)[]) => {
  const selectedId = selectedKeys?.[0]
  if (selectedId === undefined || selectedId === null || selectedId === '') {
    delete queryParams.deptId
    selectedDeptId.value = undefined
  } else {
    const deptId = Number(selectedId)
    queryParams.deptId = deptId
    selectedDeptId.value = deptId
  }
  search()
}

const reset = () => {
  queryParams.deptId = selectedDeptId.value ?? undefined
  queryParams.status = '1'
  queryParams.username = ''
  search()
}

const onAdd = () => {
  UserFormModalRef.value?.add(selectedDeptId.value)
}

const onEdit = (item: T.ListItem) => {
  UserFormModalRef.value?.edit(item.id)
}

// 单条删除
const onDelete = (item?: T.ListItem) => {
  return handleDelete(() => baseAPI.delete(item!.id), { showModal: false })
}

// 批量删除
const onBatchDelete = async () => {
  if (!selectedKeys.value.length) {
    return Message.warning('请选择用户！')
  }

  const ids = selectedKeys.value
    .map((id) => Number(id))
    .filter((id) => Number.isInteger(id) && id > 0)

  if (!ids.length) {
    return Message.warning('所选用户ID无效')
  }

  Modal.warning({
    title: '提示',
    content: `确定删除已选中的 ${ids.length} 个用户吗？`,
    hideCancel: false,
    maskClosable: false,
    onBeforeOk: async () => {
      const res = await baseAPI.deleteBatch(ids)
      if (!res.success) return false

      const { successCount = 0, failedIds = [], notFoundCount = 0 } = res.data || {}
      
      let message = `成功删除 ${successCount} 个用户`
      if (notFoundCount > 0) {
        message += `，${notFoundCount} 个用户不存在`
      }
      if (failedIds.length > 0) {
        message += `，${failedIds.length} 个用户删除失败`
      }

      selectedKeys.value = []
      refresh()
      Message.success(message)
      return true
    }
  })
}



const onResetPassword = async () => {
  if (!selectedKeys.value.length) {
    return Message.warning('请选择用户！')
  }

  const ids = selectedKeys.value
    .map((id) => Number(id))
    .filter((id) => Number.isInteger(id) && id > 0)

  if (!ids.length) {
    return Message.warning('所选用户ID无效')
  }

  Modal.warning({
    title: '提示',
    content: `确定重置已选中的 ${ids.length} 个用户密码吗？`,
    hideCancel: false,
    maskClosable: false,
    onBeforeOk: async () => {
      const res = await resetPassword({ ids })
      if (!res.success) return false

      selectedKeys.value = []
      refresh()
      Message.success('重置密码成功')
      return true
    }
  })
}


const tableColumns: TableColumnData[] = [
  {
    title: '序号',
    width: 68,
    align: 'center',
    render: ({ rowIndex }) => (<span>{rowIndex + 1}</span>)
  },
  {
    title: '用户名',
    dataIndex: 'username',
    width: 120,
    render: ({ record }) => (
      <Link onClick={() => UserDetailDrawerRef.value?.open(record.id)}>{record.username}</Link>
    )
  },
  {
    title: '昵称',
    dataIndex: 'nickname',
    width: 150,
    render: ({ record }) => (
      <GiCellAvatar avatar={record.avatar} name={record.nickname} />
    )
  },
  {
    title: '状态',
    width: 100,
    align: 'center',
    render: ({ record }) => <GiCellStatus status={record.status} />
  },
  {
    title: '性别',
    dataIndex: 'gender',
    width: 80,
    align: 'center',
    render: ({ record }) => <GiCellGender gender={record.gender} />
  },
  { title: '联系方式', dataIndex: 'phone', width: 110 },
  { title: '部门', dataIndex: 'name', width: 180 },
  {
    title: '类型',
    width: 100,
    align: 'center',
    render: ({ record }) => (
      <>
        {record.type === 1 && <Tag>系统内置 </Tag>}
        {record.type === 2 && <Tag>自定义 </Tag>}
      </>
    )
  },
  { title: '描述', dataIndex: 'description', width: 200, ellipsis: true, tooltip: true },
  { title: '创建时间', dataIndex: 'createTime', width: 160 },
  {
    title: '操作',
    width: 180,
    align: 'center',
    fixed: fixed.value,
    render: ({ record }) => (
      <Space>
        <GiButton
          type="edit"
          size="mini"
          disabled={record.disabled}
          onClick={() => onEdit(record as T.ListItem)}
        />
        <Popconfirm type="warning" content="确定删除该用户吗?" onBeforeOk={() => onDelete(record as T.ListItem)}>
          <GiButton type="delete" size="mini" disabled={record.disabled} />
        </Popconfirm>
      </Space>
    )
  }
]
</script>

<style lang="scss" scoped></style>
