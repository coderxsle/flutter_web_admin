<template>
  <GiPageLayout margin collapsed>
    <a-row justify="space-between" class="g-row-tool">
      <a-space wrap>
        <GiButton type="add" @click="onAdd"></GiButton>
        <GiButton type="delete" @click="onBatchDelete"></GiButton>
      </a-space>
      <a-space wrap>
        <a-input v-model="queryParams.keyword" placeholder="书名 / ISBN / 作者 / 出版社" allow-clear
          style="max-width: 260px" @press-enter="search">
        </a-input>
        <GiButton type="search" @click="search"></GiButton>
        <GiButton type="reset" @click="reset"></GiButton>
      </a-space>
    </a-row>

    <a-table class="g-table" row-key="id" :loading="loading" :data="bookList" :columns="tableColumns"
      :bordered="{ cell: true }" :scroll="{ x: '100%', y: '100%', minWidth: 1500 }" :pagination="pagination"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }" :selected-keys="selectedKeys" @select="select"
      @select-all="selectAll">
    </a-table>

    <BookFormModal ref="BookFormModalRef" @save-success="search" />
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type * as T from '@/apis/book'
import { Image, Message, Modal, Popconfirm, Space } from '@arco-design/web-vue'
import dayjs from 'dayjs'
import { baseAPI, deleteBook, getBookList } from '@/apis/book'
import { useTable } from '@/hooks'
import BookFormModal from './BookFormModal.vue'

defineOptions({ name: 'BookList' })

const BookFormModalRef = useTemplateRef('BookFormModalRef')

const queryParams = reactive<{ keyword: string }>({ keyword: '' })

const {
  loading,
  tableData: bookList,
  pagination,
  selectedKeys,
  search,
  refresh,
  select,
  selectAll,
  fixed,
  handleDelete
} = useTable<T.ListItem>({
  listAPI: ({ page, pageSize }) => getBookList({ page, pageSize, keyword: queryParams.keyword }),
  deleteAPI: (ids) => baseAPI.deleteBatch({ ids })
})

const reset = () => {
  queryParams.keyword = ''
  search()
}

const onAdd = () => {
  BookFormModalRef.value?.add()
}

const onEdit = (item: T.ListItem) => {
  BookFormModalRef.value?.edit(item.id)
}

// 单条删除走 `POST /api/book/delete`，与批量的 `deleteBatch` 分开
const onDelete = (item: T.ListItem) => {
  return handleDelete(() => deleteBook(item.id), { showModal: false })
}

const onBatchDelete = async () => {
  if (!selectedKeys.value.length) {
    return Message.warning('请选择图书！')
  }

  const ids = selectedKeys.value
    .map((id) => Number(id))
    .filter((id) => Number.isInteger(id) && id > 0)

  if (!ids.length) {
    return Message.warning('所选图书 ID 无效')
  }

  Modal.warning({
    title: '提示',
    content: `确定删除已选中的 ${ids.length} 本图书吗？`,
    hideCancel: false,
    maskClosable: false,
    onBeforeOk: async () => {
      // 异常已由 http 拦截器提示，这里只拦下关闭弹窗
      const res = await baseAPI.deleteBatch(ids).catch(() => null)
      if (!res?.success) return false

      const { successCount = 0, failedIds = [], notFoundCount = 0 } = res.data || {}
      let message = `成功删除 ${successCount} 本图书`
      if (notFoundCount > 0) message += `，${notFoundCount} 本不存在`
      if (failedIds.length > 0) message += `，${failedIds.length} 本删除失败`

      selectedKeys.value = []
      refresh()
      Message.success(message)
      return true
    }
  })
}

const formatTime = (value?: string | null) => (value ? dayjs(value).format('YYYY-MM-DD HH:mm:ss') : '-')

const tableColumns: TableColumnData[] = [
  {
    title: '序号',
    width: 68,
    align: 'center',
    render: ({ rowIndex }) => <span>{rowIndex + 1}</span>
  },
  {
    title: '封面',
    dataIndex: 'image',
    width: 90,
    align: 'center',
    render: ({ record }) => (record.image ? <Image src={record.image} width={48} height={64} /> : <span>-</span>)
  },
  { title: '书名', dataIndex: 'name', ellipsis: true, tooltip: true, minWidth: 200 },
  { title: 'ISBN', dataIndex: 'isbn', width: 150 },
  { title: '作者', dataIndex: 'author', width: 140, ellipsis: true, tooltip: true },
  { title: '出版社', dataIndex: 'publisher', width: 180, ellipsis: true, tooltip: true },
  {
    title: '定价',
    dataIndex: 'originalPrice',
    width: 110,
    align: 'right',
    render: ({ record }) => <span>¥ {Number(record.originalPrice ?? 0).toFixed(2)}</span>
  },
  { title: '分类 ID', dataIndex: 'categoryId', width: 90, align: 'center' },
  {
    title: '更新时间',
    dataIndex: 'updateTime',
    width: 180,
    render: ({ record }) => <span>{formatTime(record.updateTime)}</span>
  },
  {
    title: '操作',
    width: 160,
    align: 'center',
    fixed: fixed.value,
    render: ({ record }) => (
      <Space>
        <GiButton type="edit" size="mini" onClick={() => onEdit(record as T.ListItem)} />
        <Popconfirm content="确定删除该图书？" onBeforeOk={() => onDelete(record as T.ListItem)}>
          <GiButton type="delete" size="mini" />
        </Popconfirm>
      </Space>
    )
  }
]
</script>
