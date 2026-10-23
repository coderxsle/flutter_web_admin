import http from '@/utils/http'

export type AppPlatform = 'android' | 'ios'
export type AppChannel = 'official' | 'huawei' | 'xiaomi' | 'yingyongbao'
export type AppReleaseStatus = 'draft' | 'rolling' | 'published' | 'paused' | 'offline'

export interface AppReleaseItem {
  id: number
  tenantId: number
  platform: AppPlatform
  channel: AppChannel
  versionName: string
  versionCode: number
  releaseNotes: string
  minOsVersion?: string | null
  status: AppReleaseStatus
  rolloutPercent: number
  forceUpdate: boolean
  fileName?: string | null
  fileSize: number
  sha256?: string | null
  storeUrl?: string | null
  hasPackage: boolean
  publishedAt?: string | null
  downloadCount: number
  creator?: string | null
  createTime?: string
  updateTime?: string
}

export interface AppReleaseForm {
  id?: number
  platform: AppPlatform
  channel: AppChannel
  versionName: string
  versionCode: number
  releaseNotes?: string
  minOsVersion?: string | null
  storeUrl?: string | null
  forceUpdate?: boolean
  rolloutPercent?: number
}

export interface AppUpdatePolicy {
  id?: number | null
  tenantId?: number
  platform: AppPlatform
  channel: AppChannel
  minSupportedVersionCode: number
  promptCooldownHours: number
  downloadUrlTtlMinutes: number
  enabled: boolean
}

/** 版本列表：分页结构由后端 PageResponse 提供 */
export function getReleaseList(params: {
  platform?: string
  channel?: string
  status?: string
  keyword?: string
  page?: number
  pageSize?: number
}) {
  return http.get<PageRes<AppReleaseItem[]>>('/app/release/getList', params)
}

export function getReleaseDetail(id: number) {
  return http.get<AppReleaseItem>('/app/release/getDetail', { id })
}

export function createRelease(data: AppReleaseForm) {
  return http.post<AppReleaseItem>('/app/release/create', data)
}

export function updateRelease(data: AppReleaseForm) {
  return http.post<AppReleaseItem>('/app/release/update', data)
}

/** 安装包直传，超时单独放宽到 10 分钟 */
export function uploadPackage(id: number, file: File, onProgress?: (percent: number) => void) {
  return http.post<AppReleaseItem>('/app/release/upload', file, {
    params: { id, name: file.name },
    headers: { 'Content-Type': 'application/octet-stream' },
    timeout: 10 * 60 * 1000,
    onUploadProgress: (event: ProgressEvent) => {
      if (!onProgress || !event.total) return
      onProgress(Math.min(100, Math.round((event.loaded / event.total) * 100)))
    }
  })
}

export function publishRelease(data: {
  id: number
  rolloutPercent: number
  forceUpdate: boolean
  publishAt?: string | null
}) {
  return http.post<AppReleaseItem>('/app/release/publish', data)
}

export function changeReleaseStatus(id: number, status: Exclude<AppReleaseStatus, 'draft'>) {
  return http.post<AppReleaseItem>('/app/release/changeStatus', { id, status })
}

export function deleteRelease(id: number) {
  return http.post('/app/release/delete', { id })
}

export function getPolicy(params: { platform: string, channel: string }) {
  return http.get<AppUpdatePolicy>('/app/policy/get', params)
}

export function updatePolicy(data: AppUpdatePolicy) {
  return http.post<AppUpdatePolicy>('/app/policy/update', data)
}
