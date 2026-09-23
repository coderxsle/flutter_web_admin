import type * as T from '@/apis/system/dept'
import { ref } from 'vue'
import { mapTree } from 'xe-utils'
import { baseAPI } from '@/apis/system/dept'

/**
 * 模块级 in-flight 去重。
 *
 * 多个组件常常在同一时刻各自调用 getDeptList()（典型：页面本体 + 常驻挂载的
 * UserFormModal），此前会重复发出完全相同的请求。并发期间复用同一个 Promise，
 * 请求结束后立即清空，因此增删改之后的刷新仍能拿到最新数据。
 */
let inflight: Promise<T.ListItem[]> | null = null

function fetchDeptList(): Promise<T.ListItem[]> {
  const pending = inflight
  if (pending) return pending

  const request = baseAPI
    .getList()
    .then((res) => mapTree(res.data, (i) => {
      if (i.children?.length) {
        i.children = i.children.filter((i) => i.status === 1)
      }
      return i
    }))
    .finally(() => {
      inflight = null
    })

  inflight = request
  return request
}

/** 部门模块 */
export function useDept(options?: { onSuccess?: () => void }) {
  const loading = ref(false)
  const deptList = ref<T.ListItem[]>([])

  const getDeptList = async () => {
    try {
      loading.value = true
      deptList.value = await fetchDeptList()
      options?.onSuccess && options.onSuccess()
    } finally {
      loading.value = false
    }
  }
  return { deptList, getDeptList, loading }
}
