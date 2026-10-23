import type { AppChannel, AppPlatform, AppReleaseStatus } from '@/apis/app/update'

export const platformOptions = [
  { label: 'Android', value: 'android' },
  { label: 'iOS', value: 'ios' }
]

export const channelOptions = [
  { label: '官方', value: 'official' },
  { label: '华为', value: 'huawei' },
  { label: '小米', value: 'xiaomi' },
  { label: '应用宝', value: 'yingyongbao' }
]

export const statusMap: Record<AppReleaseStatus, { label: string, color: string }> = {
  draft: { label: '草稿', color: 'gray' },
  rolling: { label: '灰度中', color: 'orange' },
  published: { label: '已发布', color: 'green' },
  paused: { label: '已暂停', color: 'gold' },
  offline: { label: '已下架', color: 'gray' }
}

export const platformLabel = (value: AppPlatform) => platformOptions.find(i => i.value === value)?.label ?? value

export const channelLabel = (value: AppChannel) => channelOptions.find(i => i.value === value)?.label ?? value

export function formatSize(bytes?: number | null) {
  if (!bytes) return '-'
  const mb = bytes / 1024 / 1024
  return `${mb.toFixed(1)} MB`
}
