<template>
  <div class="role-search-bar">
    <a-input v-model="keywordValue" placeholder="搜索名称/编码" allow-clear>
      <template #prefix><icon-search /></template>
    </a-input>
    <a-button type="primary" style="margin-top: 8px; width: 100%" @click="$emit('add')">
      <template #icon><icon-plus /></template>
      <template #default>新增</template>
    </a-button>
  </div>

  <div class="gi-full-column">
    <a-scrollbar style="height: 100%; overflow: auto" outer-style="height: 100%">
      <a-list class="role-list" size="small" :split="false" :bordered="false" :data="filteredRoleList" :loading="loading">
        <template #item="{ item }">
          <a-list-item
            :class="{ 'role-item-active': selectedRoleId === item.id }"
            class="role-list-item"
            @click="$emit('select', item)"
          >
            <a-list-item-meta>
              <template #title>
                <div class="role-item-title">
                  <span class="role-item-name">{{ item.name }}</span>
                  <a-dropdown @select="(key) => key && onAction(key as string, item)" trigger="click" position="br">
                    <a-button type="text" size="mini" class="role-item-action">
                      <template #icon><icon-more /></template>
                    </a-button>
                    <template #content>
                      <a-doption value="edit">
                        <template #icon><icon-edit /></template>
                        <template #default>编辑</template>
                      </a-doption>
                      <a-doption value="delete" class="danger-option">
                        <template #icon><icon-delete /></template>
                        <template #default>删除</template>
                      </a-doption>
                    </template>
                  </a-dropdown>
                </div>
              </template>
            </a-list-item-meta>
          </a-list-item>
        </template>
      </a-list>
    </a-scrollbar>
  </div>
</template>

<script setup lang="ts">
import type * as T from '@/apis/system/role'

interface Props {
  keyword: string
  roleList: T.ListItem[]
  selectedRoleId: number | null
  loading: boolean
}

const props = defineProps<Props>()

const emit = defineEmits<{
  (e: 'update:keyword', value: string): void
  (e: 'add'): void
  (e: 'select', item: T.ListItem): void
  (e: 'edit', item: T.ListItem): void
  (e: 'delete', item: T.ListItem): void
}>()

const keywordValue = computed({
  get: () => props.keyword,
  set: (val: string) => emit('update:keyword', val)
})

const filteredRoleList = computed(() => {
  if (!props.keyword) return props.roleList
  const keyword = props.keyword.toLowerCase()
  return props.roleList.filter((item) => item.title.toLowerCase().includes(keyword) || item.code.toLowerCase().includes(keyword))
})

const onAction = (key: string, item: T.ListItem) => {
  if (key === 'edit') emit('edit', item)
  if (key === 'delete') emit('delete', item)
}
</script>

<style lang="scss" scoped>
.role-search-bar { margin-bottom: 8px; }

.role-list-item {
  cursor: pointer;
  padding: 0 8px !important;
  min-height: 40px !important;
  border-radius: 4px;
  transition: all 0.2s;
  display: flex;
  align-items: center;

  &:hover { background-color: var(--color-fill-2); }
  &.role-item-active {
    background-color: var(--color-primary-light-1);
    color: rgb(var(--primary-6));

    .role-item-name {
      font-weight: 600;
      color: rgb(var(--primary-6));
    }
  }

  :deep(.arco-list-item-content) {
    padding: 0 !important;
    width: 100%;
  }

  :deep(.arco-list-item-meta) {
    align-items: center;
    margin: 0 !important;
    padding: 0 !important;
  }

  :deep(.arco-list-item-meta-content) {
    width: 100%;
  }

  :deep(.arco-list-item-meta-title) {
    margin: 0 !important;
    font-size: 14px;
    line-height: 22px;
    font-weight: 400;
  }
}

.role-item-title {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  gap: 8px;
}

.role-item-name {
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 14px;
  line-height: 22px;
}

.role-item-action {
  opacity: 0;
  flex-shrink: 0;
  color: var(--color-text-2);
  border-radius: 4px;
  transition: all 0.2s;
}

.role-list-item:hover .role-item-action,
.role-list-item.role-item-active .role-item-action {
  opacity: 1;
  color: var(--color-text-1);
  background-color: var(--color-fill-2);
}

.danger-option { color: var(--color-danger); }
</style>
