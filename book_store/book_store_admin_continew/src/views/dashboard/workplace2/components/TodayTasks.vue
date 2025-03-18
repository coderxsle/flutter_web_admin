<template>
  <a-card class="card" :bordered="false">
    <template #title>
      <div class="title">今日待办</div>
    </template>
    
    <a-row :gutter="16">
      <a-col :span="8">
        <a-button type="primary" long status="success">
          <template #icon>
            <icon-calendar-clock />
          </template>
          今日工作记录 <a-badge :count="0" />
        </a-button>
      </a-col>
    </a-row>

    <a-divider style="margin: 16px 0" />

    <a-row :gutter="[16, 16]">
      <a-col :span="4" :xs="12" :sm="8" :md="6" :lg="4">
        <a-card class="task-card" :bordered="false">
          <a-statistic title="待诊断" :value="0" />
        </a-card>
      </a-col>
      <a-col :span="4" :xs="12" :sm="8" :md="6" :lg="4">
        <a-card class="task-card" :bordered="false">
          <a-statistic title="待收费" :value="1" />
        </a-card>
      </a-col>
      <a-col :span="4" :xs="12" :sm="8" :md="6" :lg="4">
        <a-card class="task-card" :bordered="false">
          <a-statistic title="药品复核待办" :value="2" />
        </a-card>
      </a-col>
      <a-col :span="4" :xs="12" :sm="8" :md="6" :lg="4">
        <a-card class="task-card" :bordered="false">
          <a-statistic title="项目复核待办" :value="38" />
        </a-card>
      </a-col>
      <a-col :span="4" :xs="12" :sm="8" :md="6" :lg="4">
        <a-card class="task-card" :bordered="false">
          <a-statistic title="未完成接诊" :value="46" />
        </a-card>
      </a-col>
    </a-row>
  </a-card>
</template>

<script setup lang="ts">
defineOptions({ name: 'TodayTasks' })
</script>

<style scoped lang="scss">
.title {
  font-size: 16px;
  font-weight: 500;
}

.task-card {
  text-align: center;
  cursor: pointer;
  transition: all 0.3s;

  &:hover {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.09);
    transform: translateY(-2px);
  }
}
</style> 