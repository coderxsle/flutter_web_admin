// import type * as T from '@/apis/system/role'
// import { ref } from 'vue'
// import { baseAPI } from '@/apis/system/role'

// /** 角色模块 */
// export function useRole() {
//   const loading = ref(false)
//   const roleList = ref<T.ListItem[]>([])
//   const total = ref(0)
//   const getRoleList = async () => {
//     try {
//       loading.value = true
//       const res = await baseAPI.getList({ page: 1, size: 99 })
//       roleList.value = res.data.filter((i) => i.status === '1')
//       total.value = res.data.total
//     } finally {
//       loading.value = false
//     }
//   }
//   return { roleList, getRoleList, loading, total }
// }


import type * as T from '@/apis/system/role'
import { ref } from 'vue'
import { baseAPI } from '@/apis/system/role'

/** 角色模块 */
export function useRole() {
  const loading = ref(false)
  const roleList = ref<T.ListItem[]>([])
  const total = ref(0)
  const getRoleList = async () => {
    try {
      loading.value = true
      const res = await baseAPI.getList({ page: 1, size: 99 })
      // ⚠️ 角色的 getList 是**非分页**的（后端返回平铺数组），而分页资源
      // （user）返回的是 `data: { records, total, … }`。两种形状都要认。
      roleList.value = (Array.isArray(res.data) ? res.data : res.data.records)
        .filter((i) => i.status === 1)
      total.value = Array.isArray(res.data) ? res.data.length : res.data.total
    } finally {
      loading.value = false
    }
  }
  return { roleList, getRoleList, loading, total }
}
