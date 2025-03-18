<template>
  <a-card class="card" :bordered="false">
    <template #title>
      <div class="title">门诊排班</div>
    </template>
    <template #extra>
      <a-button size="small" type="text">
        <template #icon>
          <icon-refresh />
        </template>
        刷新上一周
      </a-button>
    </template>
    
    <a-row class="date-selector" align="center" justify="space-between">
      <a-col>
        <a-button shape="circle" size="mini">
          <template #icon>
            <icon-left />
          </template>
        </a-button>
      </a-col>
      <a-col>
        <span class="date-range">2025-03-17 ~ 2025-03-23</span>
      </a-col>
      <a-col>
        <a-button shape="circle" size="mini">
          <template #icon>
            <icon-right />
          </template>
        </a-button>
      </a-col>
    </a-row>
    
    <a-divider style="margin: 16px 0" />
    
    <a-table
      :columns="columns"
      :data="scheduleData"
      :pagination="false"
      :bordered="{ cell: true }"
      :scroll="{ x: '100%' }"
    >
      <template #empty>
        <div class="empty-data">
          <a-empty description="暂无排班数据" />
        </div>
      </template>
    </a-table>
  </a-card>
</template>

<script setup lang="ts">
import type { TableColumnData } from '@arco-design/web-vue'

defineOptions({ name: 'ClinicSchedule' })

interface ScheduleData {
  key: string
  name: string
  mon: string
  tue: string
  wed: string
  thu: string
  fri: string
  sat: string
  sun: string
}

// 表格列定义
const columns: TableColumnData[] = [
  {
    title: '医生',
    dataIndex: 'name',
    width: 100,
    fixed: 'left',
  },
  { title: '周一 03-17', dataIndex: 'mon', width: 100 },
  { title: '周二 03-18', dataIndex: 'tue', width: 100 },
  { title: '周三 03-19', dataIndex: 'wed', width: 100 },
  { title: '周四 03-20', dataIndex: 'thu', width: 100 },
  { title: '周五 03-21', dataIndex: 'fri', width: 100 },
  { title: '周六 03-22', dataIndex: 'sat', width: 100 },
  { title: '周日 03-23', dataIndex: 'sun', width: 100 },
]

// 模拟排班数据
const scheduleData: ScheduleData[] = [
  {
    key: '1',
    name: '张雷松',
    mon: '全天',
    tue: '上午',
    wed: '全天',
    thu: '-',
    fri: '下午',
    sat: '全天',
    sun: '-',
  },
  {
    key: '2',
    name: '李赫衡',
    mon: '-',
    tue: '全天',
    wed: '上午',
    thu: '全天',
    fri: '全天',
    sat: '-',
    sun: '-',
  },
  {
    key: '3',
    name: '王锐',
    mon: '上午',
    tue: '-',
    wed: '全天',
    thu: '上午',
    fri: '下午',
    sat: '上午',
    sun: '-',
  },
  {
    key: '4',
    name: '朱明轩',
    mon: '下午',
    tue: '全天',
    wed: '-',
    thu: '全天',
    fri: '-',
    sat: '全天',
    sun: '上午',
  },
]
</script>

<style scoped lang="scss">
.title {
  font-size: 16px;
  font-weight: 500;
}

.date-selector {
  margin-top: 16px;
  .date-range {
    font-size: 14px;
    font-weight: 500;
  }
}

.empty-data {
  padding: 20px 0;
}
</style> 