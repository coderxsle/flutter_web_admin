<template>
  <div class="permission-content">
    <div class="permission-toolbar">
      
      <a-space>
        <a-radio-group v-model="nodeModeValue" type="button" :disabled="readonly">
          <a-radio value="link">节点关联</a-radio>
          <a-radio value="independent">节点独立</a-radio>
        </a-radio-group>
        <a-button type="primary" status="success" @click="$emit('toggle-collapse')">
          <template #icon>
            <icon-list v-if="isCollapsed" />
            <icon-mind-mapping v-else />
          </template>
          {{ isCollapsed ? '展开' : '折叠' }}
        </a-button>
        <a-button type="text" @click="$emit('refresh')">
          <template #icon><icon-refresh /></template>
        </a-button>
      </a-space>
      <a-button type="primary" :disabled="readonly" @click="$emit('save')">
        <template #icon><icon-save /></template>
        <template #default>保存权限</template>
      </a-button>
    </div>

    <div class="permission-table-wrapper">
      <a-table
        class="gi-table permission-table"
        row-key="id"
        :data="permissionTreeData"
        :pagination="false"
        :bordered="{ cell: false }"
        :scroll="{ x: '100%', y: '100%', minWidth: 800 }"
        v-model:expandedKeys="expandedPermissionKeysValue"
      >
        <template #expand-icon="{ expanded, record }">
          <template v-if="record.type === 1 && record.children?.length">
            <IconDown v-if="expanded" />
            <IconRight v-else />
          </template>
        </template>
        <template #columns>
          <a-table-column :width="220">
            <template #title>
              <div class="permission-menu-header">
                <a-checkbox
                  :model-value="allMenuChecked"
                  :indeterminate="menuIndeterminate"
                  :disabled="readonly"
                  @change="(val) => $emit('menu-check-all', val)"
                />
                <span>菜单</span>
              </div>
            </template>
            <template #cell="{ record }">
              <div class="permission-menu-cell">
                <a-checkbox
                  class="permission-menu-checkbox"
                  :model-value="isMenuChecked(record.id)"
                  :indeterminate="isMenuIndeterminate(record.id)"
                  :disabled="readonly"
                  @change="(val) => $emit('menu-check', record.id, val)"
                />
                <span class="permission-menu-name">{{ record.title }}</span>
              </div>
            </template>
          </a-table-column>
          <a-table-column title="权限">
            <template #cell="{ record }">
              <div class="permission-actions" v-if="record.permissions?.length">
                <a-checkbox
                  v-for="perm in record.permissions"
                  :key="perm.id"
                  :model-value="isPermissionChecked(perm.id)"
                  :disabled="readonly"
                  @change="(val) => $emit('permission-change', record.id, perm.id, val)"
                  class="permission-checkbox"
                >
                  {{ perm.title }}
                </a-checkbox>
              </div>
            </template>
          </a-table-column>
        </template>
      </a-table>
    </div>
  </div>
</template>

<script setup lang="ts">
interface PermissionItem {
  id: number
  title: string
  permission: string
}

interface PermissionNode {
  id: number
  type: number
  title: string
  children?: PermissionNode[]
  permissions?: PermissionItem[]
}

interface Props {
  nodeMode: 'link' | 'independent'
  isCollapsed: boolean
  permissionTreeData: PermissionNode[]
  expandedPermissionKeys: number[]
  allMenuChecked: boolean
  menuIndeterminate: boolean
  isMenuChecked: (menuId: number) => boolean
  isMenuIndeterminate: (menuId: number) => boolean
  isPermissionChecked: (buttonId: number) => boolean
  readonly?: boolean
}

const props = defineProps<Props>()

const emit = defineEmits<{
  (e: 'update:nodeMode', value: 'link' | 'independent'): void
  (e: 'update:expandedPermissionKeys', value: number[]): void
  (e: 'save'): void
  (e: 'toggle-collapse'): void
  (e: 'refresh'): void
  (e: 'menu-check-all', checked: boolean | (string | number | boolean)[]): void
  (e: 'menu-check', menuId: number, checked: boolean | (string | number | boolean)[]): void
  (e: 'permission-change', menuId: number, buttonId: number, checked: boolean | (string | number | boolean)[]): void
}>()

const nodeModeValue = computed({
  get: () => props.nodeMode,
  set: (val: 'link' | 'independent') => emit('update:nodeMode', val)
})

const expandedPermissionKeysValue = computed({
  get: () => props.expandedPermissionKeys,
  set: (val: number[]) => emit('update:expandedPermissionKeys', val)
})
</script>

<style scoped lang="scss">
.permission-content {
  height: 100%;
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;
}

.permission-toolbar {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  gap: 12px;
  margin-top: 12px;
  padding: 0px;
  flex-shrink: 0;
}

.permission-table-wrapper {
  flex: 1;
  min-height: 0;
  padding: 12px 0px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.permission-table {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
  overflow: hidden;

  :deep(.arco-spin) {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }

  :deep(.arco-table) {
    flex: 1;
    min-height: 0;
    overflow: hidden;
  }

  :deep(.arco-table-container) {
    flex: 1;
    min-height: 0;
    overflow: hidden;
  }
}

.permission-menu-header,
.permission-menu-cell {
  display: flex;
  align-items: center;
  gap: 8px;
}

.permission-menu-cell {
  .permission-menu-checkbox {
    order: 1;
    margin-right: 8px;
  }

  .permission-menu-name {
    order: 3;
  }
}

.permission-table {
  :deep(.arco-table-cell-expand-icon) {
    display: inline-flex;
    align-items: center;
  }

  :deep(.arco-table-cell-inline-icon) {
    order: 2;
    margin-left: 8px;
    margin-right: 0;
  }

  :deep(.permission-menu-cell) {
    order: 1;
  }
}

.permission-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}
</style>
