<template>
  <div class="role-users-content">
    <a-row justify="space-between" class="gi-row-tool">
      <a-space wrap>
        <GiButton type="add" :disabled="readonly" @click="$emit('add-user')">分配用户</GiButton>
        <GiButton type="delete" :disabled="readonly" @click="$emit('mul-delete-user')">取消分配</GiButton>
      </a-space>
      <a-space wrap>
        <a-input v-model="usernameValue" placeholder="输入用户名搜索" allow-clear style="width: 250px" />
        <GiButton type="search" @click="$emit('search-users')"></GiButton>
        <GiButton type="reset" @click="$emit('reset-user-query')"></GiButton>
      </a-space>
    </a-row>

    <a-table
      class="gi-table"
      row-key="id"
      :data="roleUserList"
      :bordered="{ cell: true }"
      :loading="userLoading"
      :scroll="{ x: '100%', y: '100%', minWidth: 1200 }"
      :pagination="userPagination"
      :row-selection="{ type: 'checkbox', showCheckedAll: true }"
      :selected-keys="selectedUserKeys"
      @select="(...args) => $emit('select-user', ...args)"
      @select-all="(...args) => $emit('select-all-users', ...args)"
    >
      <template #columns>
        <a-table-column title="序号" :width="68" align="center">
          <template #cell="cell">{{ cell.rowIndex + 1 }}</template>
        </a-table-column>
        <a-table-column title="用户名" data-index="username" :width="120">
          <template #cell="{ record }">
            <a-link @click="$emit('user-detail', record)">{{ record.username }}</a-link>
          </template>
        </a-table-column>
        <a-table-column title="昵称" data-index="nickname" :width="150">
          <template #cell="{ record }">
            <GiCellAvatar :avatar="record.avatar" :name="record.nickname" />
          </template>
        </a-table-column>
        <a-table-column title="状态" :width="100" align="center">
          <template #cell="{ record }">
            <GiCellStatus :status="record.status" />
          </template>
        </a-table-column>
        <a-table-column title="联系方式" data-index="phone" :width="120" />
        <a-table-column title="部门" data-index="deptName" :width="180" />
        <a-table-column title="创建时间" data-index="createTime" :width="160" />
        <a-table-column title="操作" :width="100" align="center" :fixed="userFixed">
          <template #cell="{ record }">
            <a-popconfirm type="warning" content="确定取消分配该用户吗?" @ok="$emit('remove-user', record)">
              <GiButton type="delete" size="mini" :disabled="readonly">取消分配</GiButton>
            </a-popconfirm>
          </template>
        </a-table-column>
      </template>
    </a-table>
  </div>
</template>

<script setup lang="ts">
interface RoleUserItem {
  id: number
  username: string
  nickname: string
  avatar?: string
  status: number
  phone?: string
  deptName?: string
  createTime?: string
  disabled?: boolean
}

interface Props {
  username: string
  roleUserList: RoleUserItem[]
  userLoading: boolean
  userPagination: any
  selectedUserKeys: number[]
  userFixed: 'left' | 'right' | undefined
  readonly?: boolean
}

const props = defineProps<Props>()

const emit = defineEmits<{
  (e: 'update:username', value: string): void
  (e: 'add-user'): void
  (e: 'mul-delete-user'): void
  (e: 'search-users'): void
  (e: 'reset-user-query'): void
  (e: 'select-user', ...args: any[]): void
  (e: 'select-all-users', ...args: any[]): void
  (e: 'remove-user', item: RoleUserItem): Promise<boolean>
  (e: 'user-detail', item: RoleUserItem): void
}>()

const usernameValue = computed({
  get: () => props.username,
  set: (val: string) => emit('update:username', val)
})
</script>

<style scoped lang="scss">
.role-users-content {
  height: 100%;
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;

  :deep(.gi-row-tool) {
    margin-top: 12px;
  }
}
</style>
