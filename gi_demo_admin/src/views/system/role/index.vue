<template>
  <GiPageLayout margin collapsed size="200px">
    <template #left>
      <RoleSidebar
        v-model:keyword="searchKeyword"
        :role-list="roleList"
        :selected-role-id="selectedRoleId"
        :loading="loading"
        @add="onAdd"
        @select="onRoleSelect"
        @edit="onEdit"
        @delete="onDelete"
      />
    </template>

    <a-tabs v-model:active-key="activeTab" type="line" class="role-tabs gi-full-tabs">
      <a-tab-pane key="permission" title="功能权限">
        <PermissionPanel
          v-if="selectedRoleId"
          v-model:node-mode="nodeMode"
          v-model:expanded-permission-keys="expandedPermissionKeys"
          :is-collapsed="isPermissionTreeCollapsed"
          :permission-tree-data="permissionTreeData"
          :all-menu-checked="allMenuChecked"
          :menu-indeterminate="menuIndeterminate"
          :is-menu-checked="isMenuChecked"
          :is-menu-indeterminate="isMenuIndeterminate"
          :is-permission-checked="isPermissionChecked"
          :readonly="isBuiltinRole"
          @save="onSavePermission"
          @toggle-collapse="onCollapse"
          @refresh="onRefreshPermission"
          @menu-check-all="onMenuCheckAll"
          @menu-check="onMenuCheck"
          @permission-change="onPermissionChange"
        />
        <div v-else class="empty-selection">
          <a-empty description="请从左侧选择一个角色" />
        </div>
      </a-tab-pane>

      <a-tab-pane key="users" title="角色用户">
        <RoleUserPanel
          v-if="selectedRoleId"
          v-model:username="userQueryParams.nickname"
          :role-user-list="roleUserList"
          :user-loading="userLoading"
          :user-pagination="userPagination"
          :selected-user-keys="selectedUserKeys"
          :user-fixed="userFixed"
          :readonly="isBuiltinRole"
          @add-user="onAddUser"
          @mul-delete-user="onMulDeleteUser"
          @search-users="searchUsers"
          @reset-user-query="resetUserQuery"
          @select-user="selectUser"
          @select-all-users="selectAllUsers"
          @remove-user="onRemoveUser"
          @user-detail="onUserDetail"
        />
        <div v-else class="empty-selection">
          <a-empty description="请从左侧选择一个角色" />
        </div>
      </a-tab-pane>
    </a-tabs>

    <RoleFormModal ref="RoleFormModalRef" @save-success="onRoleSaveSuccess" />
  </GiPageLayout>
</template>

<script setup lang="ts">
import type * as T from '@/apis/system/role'
import type { MenuOptionsItem } from '@/apis/system/menu'
import { Message, Modal } from '@arco-design/web-vue'
import { baseAPI, cancelUserRoles, getRoleMenuIds, getRoleUsers, saveRolePermissions } from '@/apis/system/role'
import { getMenuOptions } from '@/apis/system/menu'
import { useTable } from '@/hooks'
import RoleFormModal from './RoleFormModal.vue'
import RoleSidebar from './components/RoleSidebar.vue'
import PermissionPanel from './components/PermissionPanel.vue'
import RoleUserPanel from './components/RoleUserPanel.vue'

defineOptions({ title: 'SystemRole' })

const RoleFormModalRef = useTemplateRef('RoleFormModalRef')

const searchKeyword = ref('')
const selectedRoleId = ref<number | null>(null)
const selectedRole = ref<T.ListItem | null>(null)
const activeTab = ref('permission')

const {
  loading,
  tableData: roleList,
  search: searchRoles,
  handleDelete
} = useTable<T.ListItem>({
  listAPI: () => baseAPI.getList({ page: 1, pageSize: 1000 }),
  immediate: true
})

interface PermissionItem {
  id: number
  title: string
  permission: string
}

type PermissionNode = Omit<MenuOptionsItem, 'children'> & {
  permissions?: PermissionItem[]
  children?: PermissionNode[]
}

const permissionTreeData = ref<PermissionNode[]>([])
const checkedMenuIds = ref<number[]>([])
const checkStrictly = ref(false)
const nodeMode = ref<'link' | 'independent'>('link')
const expandedPermissionKeys = ref<number[]>([])
const isPermissionTreeCollapsed = computed(() => expandedPermissionKeys.value.length === 0)
const checkedButtonIds = ref<number[]>([])

const isBuiltinRole = computed(() => selectedRole.value?.type === 1)

const buildPermissionRows = (nodes: MenuOptionsItem[]): PermissionNode[] => {
  return (nodes || [])
    .filter((node) => node.type === 1 || node.type === 2)
    .map((node) => {
      // 仅目录(type=1)参与树形展开；菜单(type=2)不作为可展开节点
      const childrenRows = node.type === 1 ? buildPermissionRows(node.children || []) : []
      const buttonPermissions: PermissionItem[] = (node.children || [])
        .filter((child) => child.type === 3)
        .map((child) => ({
          id: Number(child.id),
          title: child.title,
          permission: child.permission
        }))

      return {
        ...node,
        id: Number(node.id),
        children: node.type === 1 && childrenRows.length ? childrenRows : undefined,
        permissions: buttonPermissions
      }
    })
}

const collectParentKeys = (nodes: PermissionNode[], keys: number[] = []) => {
  nodes.forEach((node) => {
    if (node.children?.length) {
      keys.push(node.id)
      collectParentKeys(node.children, keys)
    }
  })
  return keys
}

const collectDescendantMenuIds = (node: PermissionNode): number[] => {
  const ids: number[] = []
  const walk = (current: PermissionNode) => {
    current.children?.forEach((child) => {
      ids.push(child.id)
      walk(child)
    })
  }
  walk(node)
  return ids
}

const collectDescendantButtonIds = (node: PermissionNode): number[] => {
  const ids: number[] = []
  const walk = (current: PermissionNode) => {
    current.permissions?.forEach((perm) => ids.push(perm.id))
    current.children?.forEach((child) => walk(child))
  }
  walk(node)
  return ids
}

const findNodeById = (nodes: PermissionNode[], id: number): PermissionNode | null => {
  for (const node of nodes) {
    if (node.id === id) return node
    if (node.children?.length) {
      const found = findNodeById(node.children, id)
      if (found) return found
    }
  }
  return null
}

const loadPermissionTree = async () => {
  const res = await getMenuOptions()
  permissionTreeData.value = buildPermissionRows(res.data || [])
  expandedPermissionKeys.value = collectParentKeys(permissionTreeData.value)
}

const loadRolePermissions = async (roleId: number) => {
  if (!permissionTreeData.value.length) {
    await loadPermissionTree()
  }

  const res = await getRoleMenuIds({ roleId })
  const checkedIds = (res.data || []).map(Number)
  const allMenuNodeIds = new Set<number>()
  const allButtonNodeIds = new Set<number>()

  const walk = (nodes: PermissionNode[]) => {
    nodes.forEach((node) => {
      allMenuNodeIds.add(node.id)
      node.permissions?.forEach((perm) => allButtonNodeIds.add(perm.id))
      if (node.children?.length) walk(node.children)
    })
  }
  walk(permissionTreeData.value)

  checkedMenuIds.value = checkedIds.filter((id) => allMenuNodeIds.has(id))
  checkedButtonIds.value = checkedIds.filter((id) => allButtonNodeIds.has(id))
  normalizeLinkModeCheckedState()
}

const getAllMenuAndButtonIds = (nodes: PermissionNode[]) => {
  const menuIds: number[] = []
  const buttonIds: number[] = []

  const walk = (list: PermissionNode[]) => {
    list.forEach((node) => {
      menuIds.push(node.id)
      node.permissions?.forEach((perm) => buttonIds.push(perm.id))
      if (node.children?.length) {
        walk(node.children)
      }
    })
  }

  walk(nodes)
  return { menuIds, buttonIds }
}

const parentMenuMap = computed(() => {
  const map = new Map<number, number>()
  const walk = (nodes: PermissionNode[], parentId?: number) => {
    nodes.forEach((node) => {
      if (parentId !== undefined) {
        map.set(node.id, parentId)
      }
      if (node.children?.length) {
        walk(node.children, node.id)
      }
    })
  }
  walk(permissionTreeData.value)
  return map
})

const hasAnyCheckedInNode = (node: PermissionNode) => {
  const descendantMenuIds = collectDescendantMenuIds(node)
  const descendantButtonIds = collectDescendantButtonIds(node)
  const selfButtonIds = node.permissions?.map((perm) => perm.id) || []

  return (
    // selfButtonIds.some((id) => checkedButtonIds.value.includes(id))
    checkedMenuIds.value.includes(node.id)
    || selfButtonIds.some((id) => checkedButtonIds.value.includes(id))
    || descendantMenuIds.some((id) => checkedMenuIds.value.includes(id))
    || descendantButtonIds.some((id) => checkedButtonIds.value.includes(id))
  )
}

const syncCurrentAndParentMenuChecked = (menuId: number) => {
  if (checkStrictly.value) return

  const currentNode = findNodeById(permissionTreeData.value, menuId)
  if (currentNode) {
    if (hasAnyCheckedInNode(currentNode)) {
      if (!checkedMenuIds.value.includes(menuId)) {
        checkedMenuIds.value.push(menuId)
      }
    } else {
      checkedMenuIds.value = checkedMenuIds.value.filter((id) => id !== menuId)
    }
  }

  let currentParentId = parentMenuMap.value.get(menuId)
  while (currentParentId !== undefined) {
    const parentNode = findNodeById(permissionTreeData.value, currentParentId)
    if (!parentNode) break

    if (hasAnyCheckedInNode(parentNode)) {
      if (!checkedMenuIds.value.includes(parentNode.id)) {
        checkedMenuIds.value.push(parentNode.id)
      }
    } else {
      checkedMenuIds.value = checkedMenuIds.value.filter((id) => id !== parentNode.id)
    }

    currentParentId = parentMenuMap.value.get(parentNode.id)
  }
}

const normalizeLinkModeCheckedState = () => {
  if (checkStrictly.value) return
  const { menuIds } = getAllMenuAndButtonIds(permissionTreeData.value)
  menuIds.forEach((id) => syncCurrentAndParentMenuChecked(id))
}

const allMenuChecked = computed(() => {
  const { menuIds } = getAllMenuAndButtonIds(permissionTreeData.value)
  if (!menuIds.length) return false
  return menuIds.every((id) => checkedMenuIds.value.includes(id))
})

const menuIndeterminate = computed(() => {
  const { menuIds } = getAllMenuAndButtonIds(permissionTreeData.value)
  if (!menuIds.length) return false
  const checkedCount = menuIds.filter((id) => checkedMenuIds.value.includes(id)).length
  return checkedCount > 0 && checkedCount < menuIds.length
})

const isMenuChecked = (menuId: number) => checkedMenuIds.value.includes(menuId)

const isMenuIndeterminate = (menuId: number) => {
  if (checkStrictly.value) return false
  const node = findNodeById(permissionTreeData.value, menuId)
  if (!node) return false

  const selfButtonIds = node.permissions?.map((perm) => perm.id) || []
  const descendantMenuIds = collectDescendantMenuIds(node)
  const descendantButtonIds = collectDescendantButtonIds(node)

  const totalCount = 1 + selfButtonIds.length + descendantMenuIds.length + descendantButtonIds.length
  const checkedCount =
    (checkedMenuIds.value.includes(menuId) ? 1 : 0)
    + selfButtonIds.filter((id) => checkedButtonIds.value.includes(id)).length
    + descendantMenuIds.filter((id) => checkedMenuIds.value.includes(id)).length
    + descendantButtonIds.filter((id) => checkedButtonIds.value.includes(id)).length

  return checkedCount > 0 && checkedCount < totalCount
}

const isPermissionChecked = (buttonId: number) => checkedButtonIds.value.includes(buttonId)

const onMenuCheckAll = (checked: boolean | (string | number | boolean)[]) => {
  if (isBuiltinRole.value) return
  const isChecked = typeof checked === 'boolean' ? checked : checked.includes(true)
  const { menuIds, buttonIds } = getAllMenuAndButtonIds(permissionTreeData.value)

  if (isChecked) {
    checkedMenuIds.value = Array.from(new Set([...checkedMenuIds.value, ...menuIds]))
    checkedButtonIds.value = Array.from(new Set([...checkedButtonIds.value, ...buttonIds]))
    return
  }

  checkedMenuIds.value = checkedMenuIds.value.filter((id) => !menuIds.includes(id))
  checkedButtonIds.value = checkedButtonIds.value.filter((id) => !buttonIds.includes(id))
}

const onMenuCheck = (menuId: number, checked: boolean | (string | number | boolean)[]) => {
  if (isBuiltinRole.value) return
  const isChecked = typeof checked === 'boolean' ? checked : checked.includes(true)
  const currentNode = findNodeById(permissionTreeData.value, menuId)
  if (!currentNode) return

  const childMenuIds = checkStrictly.value ? [] : collectDescendantMenuIds(currentNode)
  const childButtonIds = checkStrictly.value ? [] : collectDescendantButtonIds(currentNode)
  const selfButtonIds = currentNode.permissions?.map((perm) => perm.id) || []

  if (isChecked) {
    checkedMenuIds.value = Array.from(new Set([...checkedMenuIds.value, menuId, ...childMenuIds]))
    checkedButtonIds.value = Array.from(new Set([...checkedButtonIds.value, ...selfButtonIds, ...childButtonIds]))
  } else {
    checkedMenuIds.value = checkedMenuIds.value.filter((id) => id !== menuId && !childMenuIds.includes(id))
    checkedButtonIds.value = checkedButtonIds.value.filter((id) => !selfButtonIds.includes(id) && !childButtonIds.includes(id))
  }

  syncCurrentAndParentMenuChecked(menuId)
}

const onPermissionChange = (menuId: number, buttonId: number, checked: boolean | (string | number | boolean)[]) => {
  if (isBuiltinRole.value) return
  const isChecked = typeof checked === 'boolean' ? checked : checked.includes(true)

  if (isChecked) {
    if (!checkedButtonIds.value.includes(buttonId)) checkedButtonIds.value.push(buttonId)
    if (!checkedMenuIds.value.includes(menuId)) checkedMenuIds.value.push(menuId)
  } else {
    checkedButtonIds.value = checkedButtonIds.value.filter((id) => id !== buttonId)
  }

  syncCurrentAndParentMenuChecked(menuId)
}

const userQueryParams = reactive({ nickname: '' })

const {
  loading: userLoading,
  tableData: roleUserList,
  pagination: userPagination,
  selectedKeys: selectedUserKeysRaw,
  search: searchUsers,
  refresh: refreshUsers,
  select: selectUser,
  selectAll: selectAllUsers,
  fixed: userFixed
} = useTable<T.RoleUserItem>({
  listAPI: ({ page, size }) => {
    if (!selectedRoleId.value) {
      return Promise.resolve({ code: 200, data: [], message: 'success', success: true, total: 0 }) as any
    }
    return getRoleUsers({
      roleId: selectedRoleId.value,
      pageNum: page,
      pageSize: size,
      nickname: userQueryParams.nickname || undefined
    }) as any
  },
  immediate: false
})

const selectedUserKeys = computed<number[]>(() =>
  selectedUserKeysRaw.value.map((key) => Number(key)).filter((key) => !Number.isNaN(key))
)

const onRoleSelect = (item: T.ListItem) => {
  selectedRole.value = item
  selectedRoleId.value = item.id
  loadRolePermissions(item.id)
  if (activeTab.value === 'users') {
    searchUsers()
  }
}

watch(activeTab, (newTab) => {
  if (newTab === 'users' && selectedRoleId.value) searchUsers()
})

watch(
  roleList,
  (list) => {
    if (!list.length) {
      selectedRoleId.value = null
      selectedRole.value = null
      return
    }

    const hasSelected = selectedRoleId.value !== null && list.some((item) => item.id === selectedRoleId.value)
    if (!hasSelected) {
      onRoleSelect(list[0])
      return
    }

    selectedRole.value = list.find((item) => item.id === selectedRoleId.value) || null
  },
  { immediate: true }
)

const onRoleSaveSuccess = () => searchRoles()

watch(nodeMode, (val) => {
  checkStrictly.value = val === 'independent'
  if (val === 'link') {
    normalizeLinkModeCheckedState()
  }
  Message.info(val === 'link' ? '已切换为节点关联模式' : '已切换为节点独立模式')
})

const onCollapse = () => {
  expandedPermissionKeys.value = expandedPermissionKeys.value.length ? [] : collectParentKeys(permissionTreeData.value)
}

const onRefreshPermission = () => {
  if (!selectedRoleId.value) return
  loadRolePermissions(selectedRoleId.value)
  Message.success('刷新成功')
}

const onSavePermission = async () => {
  if (!selectedRoleId.value) return Message.warning('请先选择角色')
  if (isBuiltinRole.value) return Message.warning('系统内置角色不允许修改权限')

  const roleId = selectedRoleId.value
  const menuIds = Array.from(new Set([...checkedMenuIds.value, ...checkedButtonIds.value]))

  const res = await saveRolePermissions({ roleId, menuIds })
  if (res?.success) {
    Message.success('保存权限成功')
    return
  }
  Message.error(res?.message || '保存权限失败')
}

const onAddUser = () => {
  if (isBuiltinRole.value) return Message.warning('系统内置角色不允许修改用户分配')
  Message.info('分配用户功能待实现')
}

const onMulDeleteUser = async () => {
  if (isBuiltinRole.value) return Message.warning('系统内置角色不允许修改用户分配')
  if (!selectedRoleId.value) return Message.warning('请先选择角色')
  if (!selectedUserKeys.value.length) return Message.warning('请选择用户！')

  Modal.warning({
    title: '提示',
    content: `确定取消分配已选中的 ${selectedUserKeys.value.length} 个用户吗？`,
    hideCancel: false,
    maskClosable: false,
    onBeforeOk: async () => {
      const userIds = selectedUserKeys.value.map(Number).filter((id) => !Number.isNaN(id))
      if (!userIds.length) {
        Message.warning('无有效用户可取消分配')
        return false
      }

      const res = await cancelUserRoles({ roleId: selectedRoleId.value!, userIds })
      if (!res.success) return false

      Message.success('取消分配成功')

      const currentPage = userPagination.current
      const currentPageSelectedCount = roleUserList.value.filter((item) => selectedUserKeys.value.includes(item.id)).length

      selectedUserKeysRaw.value = []

      const remainCount = roleUserList.value.length - currentPageSelectedCount
      if (remainCount <= 0 && currentPage > 1) {
        userPagination.onChange(currentPage - 1)
      } else {
        refreshUsers()
      }

      return true
    }
  })
}
const onRemoveUser = async (item: T.RoleUserItem) => {
  if (isBuiltinRole.value) {
    Message.warning('系统内置角色不允许修改用户分配')
    return false
  }
  if (!selectedRoleId.value) {
    Message.warning('请先选择角色')
    return false
  }

  const userId = Number(item.id)
  if (Number.isNaN(userId)) {
    Message.warning('用户ID无效，无法取消分配')
    return false
  }

  const res = await cancelUserRoles({ roleId: selectedRoleId.value, userIds: [userId] })
  if (res.success) {
    Message.success('取消分配成功')
    refreshUsers()
    return true
  }
  return false
}
const onUserDetail = (_item: T.RoleUserItem) => Message.info('用户详情功能待实现')

const resetUserQuery = () => {
  userQueryParams.nickname = ''
  searchUsers()
}

const onAdd = () => RoleFormModalRef.value?.add()
const onEdit = (item: T.ListItem) => RoleFormModalRef.value?.edit(item.id)
const onDelete = (item: T.ListItem) => handleDelete(() => baseAPI.delete({ ids: [item.id] }), { showModal: false })

onMounted(async () => {
  await loadPermissionTree()
  if (selectedRoleId.value) {
    await loadRolePermissions(selectedRoleId.value)
  }
})
</script>

<style lang="scss" scoped>
.role-tabs {
  height: 100%;
  display: flex;
  flex-direction: column;
  min-height: 0;

  :deep(.arco-tabs-header) { flex-shrink: 0; }

  :deep(.arco-tabs-content) {
    flex: 1;
    min-height: 0;
    overflow: hidden;
  }

  :deep(.arco-tabs-content-list) {
    height: 100%;
    min-height: 0;
  }

  :deep(.arco-tabs-content-item),
  :deep(.arco-tabs-pane) {
    height: 100%;
    min-height: 0;
    overflow: hidden;
    display: flex;
    flex-direction: column;
  }
}

.empty-selection {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  min-height: 400px;
  flex: 1;
}
</style>
