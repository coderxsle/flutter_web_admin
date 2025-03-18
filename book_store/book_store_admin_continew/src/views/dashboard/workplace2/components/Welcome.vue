<template>
  <a-card class="card" :bordered="false">
    <a-row align="center" wrap :gutter="[{ xs: 0, sm: 14, md: 14, lg: 14, xl: 14, xxl: 14 }, 16]" class="content">
      <a-space size="medium">
        <Avatar :src="userStore.avatar" :name="userStore.nickname" :size="68" />
        <div class="welcome">
          <p class="hello">{{ goodTimeText() }}，{{ userStore.nickname }}</p>
          <p v-for="(notice, index) in notices" :key="index">
            <icon-quote-left /> {{ notice }}
          </p>
        </div>
      </a-space>
    </a-row>
  </a-card>
</template>

<script setup lang="ts">
import { useUserStore } from '@/stores'
import { goodTimeText } from '@/utils'

const userStore = useUserStore()

// 模拟通知数据
const notices = ref([
  '医保药品规则智能审核功能，提升医保结算准确率',
  '支持药店药品设备管理及智能补货，增强各环节流程优化'
])
</script>

<style scoped lang="scss">
:deep(.arco-statistic-title) {
  margin-bottom: 0;
}

.card {
  .content {
    padding: 8px 20px;
    .welcome {
      margin: 8px 0;
      color: $color-text-3;
      .hello {
        font-size: 1.25rem;
        color: $color-text-1;
        margin-bottom: 10px;
      }
    }
  }
}
</style> 