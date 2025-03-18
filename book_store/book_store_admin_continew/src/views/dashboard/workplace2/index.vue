<template>
  <div class="gi_page container">
    <div class="left-side">
      <div class="panel">
        <Welcome />
      </div>
      <div style="margin-top: 14px">
        <a-grid :cols="24" :col-gap="14" :row-gap="14">
          <a-grid-item :span="24">
            <TodayTasks />
          </a-grid-item>
          <a-grid-item :span="24">
            <BusinessStatistics />
          </a-grid-item>
          <a-grid-item :span="24">
            <TodayBoard />
          </a-grid-item>
          <a-grid-item :span="24">
            <ClinicSchedule />
          </a-grid-item>
        </a-grid>
      </div>
    </div>
    <div class="right-side">
      <a-grid :cols="24" :row-gap="14">
        <a-grid-item :span="24">
          <div class="panel">
            <ProfileInfo />
          </div>
        </a-grid-item>
      </a-grid>
    </div>
  </div>
</template>

<script setup lang="ts">
import Welcome from './components/Welcome.vue'
import TodayTasks from './components/TodayTasks.vue'
import BusinessStatistics from './components/BusinessStatistics.vue'
import TodayBoard from './components/TodayBoard.vue'
import ClinicSchedule from './components/ClinicSchedule.vue'
import ProfileInfo from './components/ProfileInfo.vue'

defineOptions({ name: 'Workplace2' })
</script>

<style scoped lang="scss">
.container {
  display: flex;
}

.left-side {
  flex: 1;
}

.right-side {
  width: 280px;
  margin-left: 14px;
}

.panel {
  background-color: var(--color-bg-2);
  border-radius: 4px;
  overflow: auto;
}

// 响应式
@media (max-width: 768px) {
  .container {
    display: block;
  }
  .right-side {
    width: 100%;
    margin-left: 0;
    margin-top: 16px;
  }
}
</style> 