// 文件
export interface FileItem {
  id: number
  parentId: number | null
  type: string
  name: string
  extendName: string
  src: string
  updateTime: string
  isDir: boolean
  filePath: string
  size: number
  mimeType?: string
  storageKey?: string | null
  creator?: string | null
  createTime?: string
  [propName: string]: any // 一个 interface 中任意属性只能有一个
}

export interface FileListData {
  records: FileItem[]
  total: number
}

export interface FileTreeNode {
  id: number
  key: string
  title: string
  parentId: number | null
  children?: FileTreeNode[]
}

export interface FileUsage {
  capacity: number
  used: number
  remaining: number
  byType: Record<string, number>
}
