<template>
  <GiPageLayout margin>
    <a-row justify="space-between" class="g-row-tool">
      <a-space wrap>
        <a-button type="secondary" @click="refresh">
          <template #icon><icon-refresh /></template>
          刷新
        </a-button>
      </a-space>

      <a-space wrap>
        <a-range-picker v-model="queryParams.dateRange" show-time value-format="YYYY-MM-DD HH:mm:ss"
          :time-picker-props="{ format: 'HH:mm:ss' }" style="width: 380px"></a-range-picker>
        <a-input-group>
          <a-select v-model="queryParams.success" :options="resultOptions" placeholder="操作结果" allow-clear
            style="width: 120px"></a-select>
          <a-input v-model="queryParams.type" placeholder="操作模块" allow-clear style="width: 130px"></a-input>
          <a-input v-model="queryParams.keyword" placeholder="操作名 / 操作人 / IP / 链路编号" allow-clear
            style="width: 250px" @press-enter="search"></a-input>
        </a-input-group>
        <GiButton type="search" @click="search"></GiButton>
        <GiButton type="reset" @click="reset"></GiButton>
      </a-space>
    </a-row>

    <a-table class="g-table" row-key="id" :loading="loading" :data="logList" :columns="tableColumns"
      :bordered="{ cell: true }" :scroll="{ x: '100%', y: '100%', minWidth: 1500 }" :pagination="pagination">
    </a-table>

    <OperateLogDetailDrawer ref="OperateLogDetailDrawerRef" />
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type * as T from '@/apis/system/operateLog'
import { Link, Tag } from '@arco-design/web-vue'
import { getOperateLogList } from '@/apis/system/operateLog'
import { useTable } from '@/hooks'

import OperateLogDetailDrawer from './OperateLogDetailDrawer.vue'

defineOptions({ name: 'SystemOperateLog' })

const OperateLogDetailDrawerRef = useTemplateRef('OperateLogDetailDrawerRef')

const resultOptions = [
  { label: '成功', value: 'true' },
  { label: '失败', value: 'false' }
]

const queryParams = reactive<{ success: string, type: string, keyword: string, dateRange: string[] }>({
  success: '',
  type: '',
  keyword: '',
  dateRange: []
})

/** 空串和空数组不传给后端，避免拼出 `?type=` 这种脏参数 */
const buildParams = () => {
  const [startTime, endTime] = queryParams.dateRange ?? []
  return {
    success: queryParams.success || undefined,
    type: queryParams.type.trim() || undefined,
    keyword: queryParams.keyword.trim() || undefined,
    startTime: startTime || undefined,
    endTime: endTime || undefined
  }
}

const { loading, tableData: logList, pagination, search, refresh } = useTable({
  listAPI: (page) => getOperateLogList({ ...page, ...buildParams() }),
  immediate: true
})

const reset = () => {
  queryParams.success = ''
  queryParams.type = ''
  queryParams.keyword = ''
  queryParams.dateRange = []
  search()
}

const onDetail = (item: T.ListItem) => {
  OperateLogDetailDrawerRef.value?.open(item.id)
}

const tableColumns: TableColumnData[] = [
  {
    title: '序号',
    width: 68,
    align: 'center',
    render: ({ rowIndex }) => <span>{rowIndex + 1}</span>
  },
  { title: '操作人', dataIndex: 'creator', width: 110, ellipsis: true, tooltip: true },
  { title: '操作模块', dataIndex: 'type', width: 110, ellipsis: true, tooltip: true },
  { title: '操作内容', dataIndex: 'action', width: 110, ellipsis: true, tooltip: true },
  { title: '操作名', dataIndex: 'subType', width: 110, ellipsis: true, tooltip: true },
  {
    title: '操作结果',
    width: 100,
    align: 'center',
    render: ({ record }) => (
      record.success ? <Tag color="green">成功</Tag> : <Tag color="red">失败</Tag>
    )
  },
  { title: '请求方法', dataIndex: 'requestMethod', width: 100, align: 'center' },
  { title: '请求地址', dataIndex: 'requestUrl', width: 280, ellipsis: true, tooltip: true },
  { title: '用户 IP', dataIndex: 'userIp', width: 140 },
  { title: '创建时间', dataIndex: 'createTime', width: 170 },
  {
    title: '操作',
    width: 90,
    align: 'center',
    fixed: 'right',
    render: ({ record }) => <Link onClick={() => onDetail(record as T.ListItem)}>详情</Link>
  }
]
</script>

<style lang="scss" scoped></style>
