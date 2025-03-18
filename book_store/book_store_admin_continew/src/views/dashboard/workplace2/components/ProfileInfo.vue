<template>
  <div class="profile-container">
    <div class="clinic-title">
      <h2>马庄村卫生室</h2>
      <a-tag>2024-11-27</a-tag>
    </div>
    
    <div class="profile-box">
      <a-avatar :size="64" :style="{ backgroundColor: '#3370ff' }">
        <template #icon><icon-user /></template>
      </a-avatar>
      <div class="user-info">
        <div class="user-name">一对一专属服务</div>
        <div class="user-id">18012345678 专属客服</div>
      </div>
      <div class="qrcode">
        <a-image width="80" src="https://via.placeholder.com/80/eeeeee" />
      </div>
    </div>
    
    <a-divider />
    
    <div class="product-center">
      <h3>产品中心</h3>
      <a-grid :cols="3" :col-gap="8" :row-gap="12">
        <a-grid-item>
          <div class="product-item">
            <icon-apps class="icon" />
            <div class="name">电脑客户端</div>
            <div class="version">版本号：0.0.1</div>
          </div>
        </a-grid-item>
        <a-grid-item>
          <div class="product-item">
            <icon-mobile class="icon" />
            <div class="name">手机APP</div>
            <div class="version">版本号：0.0.1</div>
          </div>
        </a-grid-item>
        <a-grid-item>
          <div class="product-item">
            <icon-wechat class="icon" />
            <div class="name">公众号</div>
            <div class="version">公众号</div>
          </div>
        </a-grid-item>
      </a-grid>
    </div>
    
    <a-card class="promotion-card" :bordered="false">
      <div class="promotion-content">
        <div>
          <div class="promotion-title">推荐使用精医链</div>
          <div class="promotion-desc">获 <span class="highlight">200元</span> 现金红包</div>
        </div>
        <a-button type="primary" size="small">扫码参与</a-button>
      </div>
    </a-card>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'ProfileInfo' })
</script>

<style scoped lang="scss">
.profile-container {
  padding: 16px;
}

.clinic-title {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
  
  h2 {
    margin: 0;
    font-size: 18px;
    font-weight: 500;
  }
}

.profile-box {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
  
  .user-info {
    flex: 1;
    margin-left: 12px;
    
    .user-name {
      font-weight: 500;
      font-size: 16px;
      margin-bottom: 4px;
    }
    
    .user-id {
      font-size: 12px;
      color: var(--color-text-3);
    }
  }
}

.product-center {
  margin-bottom: 16px;
  
  h3 {
    font-size: 16px;
    font-weight: 500;
    margin-bottom: 16px;
  }
  
  .product-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    cursor: pointer;
    
    .icon {
      font-size: 24px;
      margin-bottom: 8px;
      color: rgb(var(--primary-6));
    }
    
    .name {
      font-size: 14px;
      margin-bottom: 4px;
    }
    
    .version {
      font-size: 12px;
      color: var(--color-text-3);
    }
    
    &:hover {
      .icon {
        transform: scale(1.1);
      }
      .name {
        color: rgb(var(--primary-6));
      }
    }
  }
}

.promotion-card {
  margin-top: 16px;
  background: linear-gradient(90deg, #1a6dff 0%, #338bff 100%);
  
  .promotion-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    
    .promotion-title {
      font-size: 16px;
      font-weight: 500;
      margin-bottom: 4px;
    }
    
    .promotion-desc {
      font-size: 14px;
      
      .highlight {
        font-size: 16px;
        font-weight: bold;
        color: #FFD700;
      }
    }
  }
}
</style> 