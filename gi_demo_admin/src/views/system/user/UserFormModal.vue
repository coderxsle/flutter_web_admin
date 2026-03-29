<template>
  <a-modal v-model:visible="visible" :title="title" width="calc(100% - 20px)" :mask-closable="false"
    :modal-style="{ maxWidth: '600px' }" :body-style="{ maxHeight: '70vh' }" @before-ok="save" @close="close">
    <GiForm ref="GiFormRef" :model-value="form" :columns="formColumns"
      :grid-item-props="{ span: { xs: 24, sm: 24, md: 12, lg: 12, xl: 12, xxl: 12 } }"
      @update:model-value="Object.assign(form, $event)" />
  </a-modal>
</template>

<script setup lang="ts">
import type { FormColumnItem } from '@/components/index'
import { Message } from '@arco-design/web-vue'
import { baseAPI, userAdd } from '@/apis/system/user'
import { GiForm } from '@/components/index'
import { useResetReactive } from '@/hooks'
import { useDept, useRole } from '@/hooks/app'
import * as Regexp from '@/utils/regexp'
import { encryptPassword } from '@/utils/crypto'
import { useUserStore } from '@/stores'

const emit = defineEmits<{
  (e: 'save-success'): void
}>()

const { roleList, getRoleList } = useRole()
getRoleList()
const roleOptions = computed(() => roleList.value.map((i) => ({ label: i.name, value: i.id })))

const { deptList, getDeptList } = useDept()
getDeptList()

const userStore = useUserStore()
const GiFormRef = useTemplateRef<InstanceType<typeof GiForm>>('GiFormRef')
const userId = ref(0)
const isEdit = computed(() => userId.value > 0)
const title = computed(() => (isEdit.value ? '编辑用户' : '新增用户'))
const visible = ref(false)

const [form, resetForm] = useResetReactive({
  id: 0,
  username: '', // 用户名
  nickname: '', // 昵称
  password: '', // 密码（仅新增时需要）
  gender: 3 as Gender, // 性别 1男 2女 3 保密
  phone: '', // 手机号
  email: '', // 邮箱
  deptId: 0, // 部门（TreeSelect 的 key: id）
  tenantId: 0, // 租户ID
  roleIds: [] as number[], // 角色(可能多个): id
  description: '', // 描述
  status: 1 as Status, // 状态 0禁用 1启用(正常)
  type: 2 as 1 | 2, // 类型 1系统内置(admin是系统内置) 2自定义
  disabled: false // 如果 type===1 这为 true, 主要作用是列表复选框禁用状态
})

const formColumns = computed<FormColumnItem[]>(() => [
  {
    type: 'input',
    label: '用户名',
    field: 'username',
    required: true,
    rules: [
      { required: true, message: '请输入用户名' },
      { min: 3, max: 20, message: '用户名长度为3-20位' },
      { match: /^[a-zA-Z0-9_]+$/, message: '用户名只能包含字母、数字和下划线' }
    ],
    props: { maxLength: 20, disabled: form.disabled }
  },
  {
    type: 'input',
    label: '昵称',
    field: 'nickname',
    required: true,
    rules: [
      { required: true, message: '请输入昵称' },
      { max: 50, message: '昵称最大50个字符' }
    ],
    props: { maxLength: 50 }
  },
  {
    type: 'input',
    label: '密码',
    field: 'password',
    required: !isEdit.value,
    rules: [
      { required: !isEdit.value, message: '请输入密码' },
      { min: 8, message: '密码长度至少8位' },
      { match: /[a-zA-Z]/, message: '密码需包含字母' },
      { match: /[0-9]/, message: '密码需包含数字' }
    ],
    props: { type: 'password', maxLength: 50, autocomplete: 'new-password' },
    hide: isEdit.value
  },
  {
    type: 'input',
    label: '手机号码',
    field: 'phone',
    rules: [{ match: Regexp.Phone, message: '手机号格式不正确' }],
    props: { maxLength: 11 }
  },
  {
    type: 'input',
    label: '邮箱',
    field: 'email',
    required: true,
    rules: [
      { required: true, message: '请输入邮箱' },
      { match: Regexp.Email, message: '邮箱格式不正确' }
    ],
    props: { maxLength: 30 }
  },
  {
    type: 'radio-group',
    label: '性别',
    field: 'gender',
    props: {
      options: [
        { label: '男', value: 1 },
        { label: '女', value: 2 }
      ]
    }
  },
  {
    type: 'tree-select',
    label: '所属部门',
    field: 'deptId',
    required: true,
    rules: [{ required: true, message: '请选择所属部门' }],
    props: {
      data: deptList.value,
      fieldNames: { key: 'id', title: 'name' },
      allowSearch: true,
      disabled: form.disabled
    },
    span: 24
  },
  {
    type: 'select',
    label: '角色',
    field: 'roleIds',
    required: true,
    rules: [{ required: true, message: '请选择角色' }],
    props: {
      options: roleOptions.value,
      multiple: true,
      allowSearch: { retainInputValue: true },
      disabled: form.disabled
    },
    span: 24
  },
  {
    type: 'textarea',
    label: '描述',
    field: 'description',
    props: {
      maxLength: 200,
      autoSize: { minRows: 3 },
      showWordLimit: true
    },
    span: 24
  },
  {
    type: 'switch',
    label: '状态',
    field: 'status',
    required: true,
    rules: [{ required: true, message: '请选择状态' }],
    props: {
      type: 'round',
      checkedValue: 1,
      uncheckedValue: 0,
      checkedText: '正常',
      uncheckedText: '禁用'
    }
  }
])

const add = (defaultDeptId?: number) => {
  userId.value = 0
  form.deptId = defaultDeptId ?? 0
  visible.value = true
}

const edit = async (id: number) => {
  visible.value = true
  userId.value = id
  const res = await baseAPI.getDetail({ id })
  const data = res.data
  Object.assign(form, {
    ...data,
    roleIds: data.roleIds ?? [],
    deptId: data.deptId ?? 0
  })
}

const close = () => {
  GiFormRef.value?.formRef?.resetFields()
  resetForm()
}

const save = async () => {
  try {
    const valid = await GiFormRef.value?.formRef?.validate()
    if (valid) return false

    // 验证必填字段
    if (!form.email || !form.email.trim()) {
      Message.error('请输入邮箱')
      return false
    }
    if (!form.roleIds || form.roleIds.length === 0) {
      Message.error('请选择角色')
      return false
    }
    if (!form.deptId) {
      Message.error('请选择所属部门')
      return false
    }

    // 准备提交数据（必填字段）
    const submitData: any = {
      email: form.email.trim(),
      username: form.username.trim(),
      nickname: form.nickname.trim()
    }

    // 新增时需要密码（与登录保持一致：前端 RSA 加密后传输）
    if (!isEdit.value) {
      if (!form.password) {
        Message.error('请输入密码')
        return false
      }
      submitData.password = await encryptPassword(form.password)
    }

    // 可选字段（使用默认值）
    submitData.status = form.status ?? '1'
    submitData.isSuperuser = false
    submitData.roleIds = form.roleIds && form.roleIds.length > 0 ? form.roleIds : []
    submitData.deptId = form.deptId ? Number(form.deptId) : 0
    submitData.tenantId = Number(userStore.userInfo.tenantId) || 0

    // 其他可选字段
    if (form.phone && form.phone.trim()) submitData.phone = form.phone.trim()
    if (form.gender) submitData.gender = form.gender
    if (form.description && form.description.trim()) submitData.description = form.description.trim()

    // 编辑时需要 id
    if (isEdit.value) {
      submitData.id = form.id
      await baseAPI.update({ req: submitData })
    } else {
      await userAdd({ data: submitData })
    }

    Message.success(isEdit.value ? '编辑成功' : '新增成功')
    emit('save-success')
    return true
  } catch (error: any) {
    Message.error(error?.message || (isEdit.value ? '编辑失败' : '新增失败'))
    return false
  }
}


defineExpose({ add, edit })
</script>
