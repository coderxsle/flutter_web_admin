/** 术数类型：与后端 ArtsRecordService.artsTypes 保持一致 */
export const ARTS_TYPE_OPTIONS = [
  { label: '奇门遁甲', value: 'qimen' },
  { label: '八字', value: 'bazi' }
]

export const artsTypeLabel = (value?: string) =>
  ARTS_TYPE_OPTIONS.find((item) => item.value === value)?.label || value || '-'

/** 后端给的是 ISO8601（`2025-01-01T10:00:00.000`），选择器要的是 `2025-01-01 10:00:00` */
export const toDateTimeText = (value?: string) => (value ? value.replace('T', ' ').slice(0, 19) : '')
