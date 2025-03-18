<template>
  <div class="container">
    <a-card class="sponsor-card">
      <template #title>
        <div class="card-title">
          <icon-gift style="margin-right: 8px; color: rgb(var(--primary-6))" />
          赞助支持
        </div>
      </template>
      <div class="sponsor-content">
        <div class="sponsor-section">
          <h3>前言</h3>
          <p>
            ContiNew Admin 是一个持续迭代优化的前后端分离中后台管理框架。自 2022 年底开始，我们一直致力于保持 <strong>持续迭代优化</strong>，为此，我们投入了大量的时间和无限的热爱。
          </p>
          <p>
            ContiNew Admin 基于 Apache 2.0 开源协议，任何个人、企业和机构都可以免费商用。然而，ContiNew Admin 的开发、维护和网站服务器的开支对我们的热爱造成了许多阻碍，因此，我们寻求赞助支持！💖
          </p>
        </div>

        <div class="sponsor-section">
          <h3>展位赞助</h3>
          <p>
            本站通过提供展示位的形式，为您的产品或品牌提供一个通过 ContiNew Admin 进行宣传展示的通道，通过展位赞助（赞助额根据总站点PV情况浮动）在本站对应的展示位置放置您的 LOGO 及跳转链接。
          </p>
          
          <a-table :columns="exhibitionColumns" :data="exhibitionData" :pagination="false" :bordered="true" stripe />
          
          <p style="margin-top: 16px;">
            您可以 <a-link href="javascript:void(0);">添加微信</a-link> 就展示位的详细事宜进行沟通。
          </p>
          
          <div class="sponsor-notes">
            <h4>展位赞助说明</h4>
            <p>
              选择档位 1、2 赞助，可帮助您的产品在 ContiNew Admin 交流群艾特全体成员推广一次。ContiNew Admin 交流群为了保障良好的交流效果，超过 200+ 则裂变新群，群内成员大部分为 Java 开发工程师/PM，可有效推广您的产品。
            </p>
            <ul>
              <li>优先推广和程序员相关的互联网产品，比如：低代码开发平台、网课、开发软件、云服务器、个人博客等等，实体产品如键盘、显示器、耳机等等，如果是和程序员无关的产品，可酌情考虑是否推广。</li>
              <li>拒绝接受违反法律法规、以及灰色相关的产品推广，为避免不必要的麻烦，目前也拒绝推广IP代理、上网工具等等。</li>
              <li>为避免过多打扰群友，目前一天内至多在群里推广两次，超过次数的可顺延到第二天。</li>
            </ul>
            <p>群发消息类似于以下：</p>
            <pre>感谢 xxx 老板对 ContiNew 系列开源项目的特别赞助，以下是老板的产品，大家感兴趣的可以关注一下：
Xxx 商品名称
链接：https://xxx.com</pre>
          </div>
        </div>
        
        <div class="sponsor-section">
          <h3>无偿赞助</h3>
          <p>
            您可以通过下方二维码为 ContiNew Admin 的维护成员送上一杯咖啡。☕ 如果您使用支付宝支付，不妨先扫码领取一下支付宝红包再进行赞助。
          </p>
          
          <div class="qrcode-container">
            <div class="qrcode-item">
              <div class="qrcode-title">微信二维码</div>
              <img 
                src="https://continew.top/sponsor.jpg" 
                alt="微信二维码" 
                @click="openSponsorPage"
                style="cursor: pointer;"
              />
            </div>
            <div class="qrcode-item">
              <div class="qrcode-title">支付宝二维码</div>
              <img 
                src="https://continew.top/sponsor.jpg" 
                alt="支付宝二维码" 
                @click="openSponsorPage"
                style="cursor: pointer;"
              />
            </div>
            <div class="qrcode-item">
              <div class="qrcode-title">支付宝红包二维码</div>
              <img 
                src="https://continew.top/sponsor.jpg" 
                alt="支付宝红包二维码" 
                @click="openSponsorPage"
                style="cursor: pointer;"
              />
            </div>
          </div>
        </div>
      </div>
    </a-card>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'AboutSponsor' })

const exhibitionColumns = [
  {
    title: '序号',
    dataIndex: 'id',
    width: 60,
  },
  {
    title: '位置',
    dataIndex: 'position',
    width: 200,
  },
  {
    title: '素材',
    dataIndex: 'material',
    width: 100,
  },
  {
    title: '宽*高',
    dataIndex: 'size',
    width: 120,
  },
  {
    title: '赞助额',
    dataIndex: 'price',
    width: 100,
  },
  {
    title: '名额',
    dataIndex: 'quota',
    width: 60,
  },
]

const exhibitionData = [
  {
    id: 1,
    position: '演示站首页轮播图',
    material: '图片+链接',
    size: '340*160px',
    price: '￥99/月',
    quota: 3,
  },
  {
    id: 2,
    position: '文档站左导航栏顶部',
    material: '图片+链接',
    size: '220*70px',
    price: '￥99/月',
    quota: 3,
  },
  {
    id: 3,
    position: '文档站右侧边栏 1',
    material: '图片+链接',
    size: '220*70px',
    price: '￥59/月',
    quota: 3,
  },
  {
    id: 4,
    position: '文档站右侧边栏 2',
    material: '图片+链接',
    size: '110*60px',
    price: '￥29/月',
    quota: 6,
  },
]

// 打开赞助页面
const openSponsorPage = () => {
  window.open('/sponsor.html', '_blank')
}
</script>

<style scoped lang="scss">
.container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.sponsor-card {
  border-radius: 4px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.card-title {
  display: flex;
  align-items: center;
  font-size: 16px;
  font-weight: 500;
}

.sponsor-content {
  padding: 0 24px;
}

.sponsor-section {
  margin-bottom: 32px;
  
  h3 {
    font-size: 18px;
    margin-bottom: 16px;
    color: var(--color-text-1);
    font-weight: 500;
    position: relative;
    padding-left: 12px;
    
    &::before {
      content: "";
      position: absolute;
      left: 0;
      top: 5px;
      height: 16px;
      width: 4px;
      background-color: rgb(var(--primary-6));
      border-radius: 2px;
    }
  }
  
  h4 {
    font-size: 16px;
    color: var(--color-text-1);
    margin: 16px 0 12px 0;
    font-weight: 500;
  }
  
  p {
    color: var(--color-text-2);
    margin-bottom: 12px;
    line-height: 1.6;
  }
  
  pre {
    background-color: var(--color-fill-2);
    padding: 12px;
    border-radius: 4px;
    margin: 12px 0;
    overflow-x: auto;
    font-family: monospace;
    color: var(--color-text-2);
  }
  
  ul, ol {
    padding-left: 24px;
    margin-bottom: 16px;
    
    li {
      margin-bottom: 8px;
      color: var(--color-text-2);
      line-height: 1.6;
    }
  }
}

.sponsor-notes {
  background-color: var(--color-fill-1);
  padding: 16px;
  border-radius: 4px;
  margin-top: 16px;
  
  h4 {
    margin-top: 0;
  }
}

.qrcode-container {
  display: flex;
  flex-wrap: wrap;
  gap: 24px;
  margin-top: 20px;
  
  @media (max-width: 768px) {
    flex-direction: column;
    align-items: center;
  }
}

.qrcode-item {
  text-align: center;
  
  img {
    width: 180px;
    height: 180px;
    border-radius: 4px;
    margin-top: 8px;
    border: 1px solid var(--color-border-2);
  }
  
  .qrcode-title {
    color: var(--color-text-2);
    margin-bottom: 8px;
    font-weight: 500;
  }
}

:deep(.arco-table) {
  .arco-table-th {
    background-color: var(--color-fill-2);
    color: var(--color-text-1);
    font-weight: 500;
  }
  
  .arco-table-tr:nth-child(even) {
    background-color: var(--color-fill-1);
  }
}
</style> 