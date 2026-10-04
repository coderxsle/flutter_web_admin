import type * as T from './type'
import http from '@/utils/http'

export type * from './type'

/** 获取文件列表 */
export function getFileList(params: { fileType: string | number, parentId?: number | null, keyword?: string }) {
  return http.get<T.FileListData>('/file/getFileList', params)
}

/** 获取文件详情 */
export function getFileDetail(id: number) {
  return http.get<T.FileItem>('/file/getDetail', { id })
}

/** 获取目录树 */
export function getFileTree() {
  return http.get<T.FileTreeNode[]>('/file/getTree')
}

/** 获取容量使用情况 */
export function getFileUsage() {
  return http.get<T.FileUsage>('/file/getUsage')
}

/** 上传文件 */
export function uploadFile(file: File, params: { parentId?: number | null }) {
  return http.post<T.FileItem>('/file/upload', file, {
    params: { ...params, name: file.name },
    headers: { 'Content-Type': file.type || 'application/octet-stream' }
  })
}

/** 创建文件夹 */
export function createFolder(params: { parentId?: number | null, name: string }) {
  return http.post<T.FileItem>('/file/createFolder', params)
}

/** 重命名文件或文件夹 */
export function renameFile(params: { id: number, name: string }) {
  return http.post<T.FileItem>('/file/rename', params)
}

/** 移动文件或文件夹 */
export function moveFile(params: { id: number, targetParentId?: number | null }) {
  return http.post<T.FileItem>('/file/move', params)
}

/** 删除单个文件或文件夹 */
export function deleteFile(id: number) {
  return http.post('/file/delete', { id })
}

/** 批量删除文件或文件夹 */
export function deleteFiles(ids: number[]) {
  return http.post('/file/deleteBatch', { ids })
}

/** 获取需要鉴权的文件二进制内容 */
export function getFileContent(id: number, download = false) {
  return http.requestRaw<Blob>({
    method: 'get',
    url: download ? '/file/download' : '/file/preview',
    params: { id },
    responseType: 'blob'
  })
}
