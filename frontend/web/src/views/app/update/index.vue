<template>
  <GiPageLayout margin>
    <div class="update-page">
      <div class="page-head">
        <a-radio-group v-model="view" type="button">
          <a-radio value="release">版本发布</a-radio>
          <a-radio value="policy">更新策略</a-radio>
        </a-radio-group>
        <span class="head-tip">配置按当前登录租户隔离；未配置时回落到平台默认。</span>
      </div>

      <PolicyPanel v-if="view === 'policy'" />

      <GiTable
        v-else
        row-key="id"
        :data="tableData"
        :loading="loading"
        :columns="columns"
        :pagination="pagination"
        :scroll="{ x: '100%', y: '100%', minWidth: 1280 }"
        @refresh="refresh"
      >
        <template #custom-title>
          <GiButton type="add" text="上传新版本" @click="openCreate" />
        </template>
        <template #custom-extra>
          <a-select v-model="query.platform" :options="platformOptions" placeholder="平台" allow-clear style="width: 120px" />
          <a-select v-model="query.channel" :options="channelOptions" placeholder="渠道" allow-clear style="width: 120px" />
          <a-select v-model="query.status" :options="statusOptions" placeholder="状态" allow-clear style="width: 120px" />
          <a-input v-model="query.keyword" placeholder="版本名 / 更新说明" allow-clear style="width: 200px" @press-enter="search" />
          <GiButton type="search" @click="search" />
          <GiButton type="reset" @click="reset" />
        </template>
      </GiTable>
    </div>

    <ReleaseFormModal v-model:visible="formVisible" :record="editing" @saved="refresh" />
    <PublishModal v-model:visible="publishVisible" :record="publishing" @saved="refresh" />
  </GiPageLayout>
</template>

<script setup lang="tsx">
import type { TableColumnData } from '@arco-design/web-vue'
import type { AppReleaseItem } from '@/apis/app/update'
import { Message, Popconfirm, Space, Tag } from '@arco-design/web-vue'
import { changeReleaseStatus, deleteRelease, getReleaseList } from '@/apis/app/update'
import { GiButton, GiTable } from '@/components/index'
import { useTable } from '@/hooks'
import PublishModal from './components/PublishModal.vue'
import PolicyPanel from './components/PolicyPanel.vue'
import ReleaseFormModal from './components/ReleaseFormModal.vue'
import { channelLabel, channelOptions, formatSize, platformLabel, platformOptions, statusMap } from './constants'

defineOptions({ name: 'AppUpdateIndex' })

const view = ref<'release' | 'policy'>('release')
const formVisible = ref(false)
const publishVisible = ref(false)
const editing = ref<AppReleaseItem | null>(null)
const publishing = ref<AppReleaseItem | null>(null)

const query = reactive<{ platform?: string, channel?: string, status?: string, keyword: string }>({ keyword: '' })
const statusOptions = (Object.keys(statusMap) as (keyof typeof statusMap)[])
  .map(value => ({ label: statusMap[value].label, value }))

const { loading, tableData, pagination, search, refresh } = useTable<AppReleaseItem>({
  listAPI: page => getReleaseList({ ...page, ...query }),
  immediate: true
})

const openCreate = () => {
  editing.value = null
  formVisible.value = true
}

const openEdit = (record: AppReleaseItem) => {
  editing.value = record
  formVisible.value = true
}

const openPublish = (record: AppReleaseItem) => {
  publishing.value = record
  publishVisible.value = true
}

const reset = () => {
  query.platform = undefined
  query.channel = undefined
  query.status = undefined
  query.keyword = ''
  search()
}

const changeStatus = async (record: AppReleaseItem, status: 'rolling' | 'published' | 'paused' | 'offline') => {
  await changeReleaseStatus(record.id, status)
  Message.success('状态已更新')
  refresh()
}

const columns: TableColumnData[] = [
  {
    title: '版本',
    width: 170,
    render: ({ record }) => (
      <div>
        <div class="version-name">{record.versionName}</div>
        <div class="version-build">build {record.versionCode}</div>
      </div>
    )
  },
  { title: '平台', width: 90, render: ({ record }) => platformLabel(record.platform) },
  { title: '渠道', width: 90, render: ({ record }) => channelLabel(record.channel) },
  {
    title: '状态',
    width: 100,
    render: ({ record }) => {
      const meta = statusMap[record.status as keyof typeof statusMap]
      return <Tag color={meta?.color ?? 'gray'}>{meta?.label ?? record.status}</Tag>
    }
  },
  {
    title: '投放',
    width: 110,
    render: ({ record }) => record.status === 'published'
      ? '全量'
      : record.status === 'rolling'
        ? `灰度 ${record.rolloutPercent}%`
        : '-'
  },
  {
    title: '强制',
    width: 80,
    render: ({ record }) => record.forceUpdate ? <Tag color="red">强制</Tag> : '-'
  },
  { title: '包大小', width: 100, render: ({ record }) => formatSize(record.fileSize) },
  { title: '下载量', width: 90, dataIndex: 'downloadCount' },
  {
    title: '发布时间',
    width: 170,
    render: ({ record }) => record.publishedAt || '-'
  },
  { title: '更新说明', dataIndex: 'releaseNotes', ellipsis: true, tooltip: true },
  {
    title: '操作',
    width: 320,
    fixed: 'right',
    render: ({ record }) => {
      const row = record as AppReleaseItem
      const canPublish = row.status === 'draft' || row.status === 'paused'
      const canPause = row.status === 'rolling' || row.status === 'published'
      const canResume = row.status === 'paused'
      const canOffline = row.status !== 'draft' && row.status !== 'offline'
      const canDelete = row.status === 'draft' || row.status === 'offline'
      return (
        <Space size={4}>
          {canPublish && (
            <a-button type="primary" size="mini" onClick={() => openPublish(row)}>发布</a-button>
          )}
          {canResume && (
            <a-button size="mini" status="success" onClick={() => changeStatus(row, 'rolling')}>恢复</a-button>
          )}
          {canPause && (
            <a-button size="mini" onClick={() => changeStatus(row, 'paused')}>暂停</a-button>
          )}
          <a-button size="mini" onClick={() => openEdit(row)}>编辑</a-button>
          {canOffline && (
            <Popconfirm
              type="warning"
              content="下架后不再向新设备投放，已安装用户不受影响。确认下架？"
              onBeforeOk={async () => {
                await changeStatus(row, 'offline')
                return true
              }}
            >
              <a-button size="mini" status="warning">下架</a-button>
            </Popconfirm>
          )}
          {canDelete && (
            <Popconfirm
              type="warning"
              content="删除后不可恢复，确认删除该版本？"
              onBeforeOk={async () => {
                await deleteRelease(row.id)
                Message.success('已删除')
                refresh()
                return true
              }}
            >
              <a-button size="mini" status="danger">删除</a-button>
            </Popconfirm>
          )}
        </Space>
      )
    }
  }
]
</script>

<style scoped>
.update-page {
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow: hidden;
}

.page-head {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}

.head-tip {
  font-size: 12px;
  color: var(--color-text-3);
}

.version-name {
  font-weight: 500;
}

.version-build {
  font-size: 12px;
  color: var(--color-text-3);
}
</style>
