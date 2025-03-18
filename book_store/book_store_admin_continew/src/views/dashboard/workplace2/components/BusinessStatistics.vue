<template>
  <a-card class="card" :bordered="false">
    <template #title>
      <div class="title">经营概况</div>
    </template>
    <template #extra>
      <a-radio-group type="button" v-model="timeRange">
        <a-radio value="today">今天</a-radio>
        <a-radio value="yesterday">昨天</a-radio>
        <a-radio value="week">本周</a-radio>
        <a-radio value="month">本月</a-radio>
      </a-radio-group>
    </template>
    
    <a-divider style="margin: 8px 0 16px 0" />
    
    <!-- 收入数据 -->
    <a-row class="section">
      <a-col :span="24">
        <h3 class="section-title">收入</h3>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="商业收入" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="门诊收入" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="零售收入" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="充值金额" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
    </a-row>
    
    <a-divider style="margin: 16px 0" />
    
    <!-- 客流数据 -->
    <a-row class="section">
      <a-col :span="24">
        <h3 class="section-title">客流</h3>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="门诊复诊量" :value="0" />
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="零售客流量" :value="0" />
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="门诊客单价" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
      <a-col :span="6" :xs="12" :sm="12" :md="6">
        <a-statistic title="零售客单价" :value="0.00" :precision="2">
          <template #suffix>元</template>
        </a-statistic>
      </a-col>
    </a-row>
  </a-card>
</template>

<script setup lang="ts">
defineOptions({ name: 'BusinessStatistics' })

const timeRange = ref('today')
</script>

<style scoped lang="scss">
.title {
  font-size: 16px;
  font-weight: 500;
}

.section {
  &-title {
    font-size: 14px;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: var(--color-text-2);
  }
}

:deep(.arco-statistic-title) {
  font-size: 14px;
  margin-bottom: 4px;
}

:deep(.arco-statistic-value) {
  font-size: 18px;
  color: rgb(var(--primary-6));
}
</style> 