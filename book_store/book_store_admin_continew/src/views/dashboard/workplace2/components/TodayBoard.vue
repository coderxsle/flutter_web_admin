<template>
  <a-card class="card" :bordered="false">
    <template #title>
      <div class="title">今日看板</div>
    </template>
    
    <a-row class="search-bar">
      <a-col :span="8">
        <a-input-search placeholder="搜索患者" allow-clear />
      </a-col>
    </a-row>
    
    <a-tabs>
      <a-tab-pane key="patient" title="患者">
        <GiTable
          :data="[]"
          :columns="columns"
          :loading="false"
          :pagination="{ current: 1, pageSize: 10, total: 0 }"
          :scroll="{ x: '100%', y: '300px' }"
        >
          <template #empty>
            <div class="empty-data">
              <a-empty description="今日暂无患者数据" />
            </div>
          </template>
        </GiTable>
      </a-tab-pane>
      <a-tab-pane key="appointment" title="预约"></a-tab-pane>
      <a-tab-pane key="schedule" title="预计就诊"></a-tab-pane>
      <a-tab-pane key="realtime" title="实时列表"></a-tab-pane>
      <a-tab-pane key="department" title="科室"></a-tab-pane>
      <a-tab-pane key="treatment" title="治疗"></a-tab-pane>
      <a-tab-pane key="pharmacy" title="收费"></a-tab-pane>
      <a-tab-pane key="doctor" title="医生"></a-tab-pane>
    </a-tabs>
  </a-card>
</template>

<script setup lang="ts">
import type { TableColumnData } from '@arco-design/web-vue'

defineOptions({ name: 'TodayBoard' })

// 表格列定义
const columns: TableColumnData[] = [
  {
    title: '姓名',
    dataIndex: 'name',
    width: 100,
  },
  {
    title: '年龄',
    dataIndex: 'age',
    width: 80,
  },
  {
    title: '性别',
    dataIndex: 'gender',
    width: 80,
  },
  {
    title: '联系电话',
    dataIndex: 'phone',
    width: 120,
  },
  {
    title: '预约时间',
    dataIndex: 'appointmentTime',
    width: 180,
  },
  {
    title: '医生',
    dataIndex: 'doctor',
    width: 100,
  },
  {
    title: '状态',
    dataIndex: 'status',
    width: 100,
  },
  {
    title: '操作',
    dataIndex: 'operation',
    width: 120,
    fixed: 'right',
  }
]
</script>

<style scoped lang="scss">
.title {
  font-size: 16px;
  font-weight: 500;
}

.search-bar {
  margin-bottom: 16px;
}

.empty-data {
  padding: 20px 0;
}
</style> 