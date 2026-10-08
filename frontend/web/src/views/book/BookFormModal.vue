<template>
  <a-modal v-model:visible="visible" :title="title" width="calc(100% - 20px)" :mask-closable="false"
    :modal-style="{ maxWidth: '560px' }" @before-ok="save" @close="close">
    <GiForm ref="GiFormRef" :model-value="form" :columns="formColumns" :grid-item-props="{ span: 24 }"
      @update:model-value="Object.assign(form, $event)" />
  </a-modal>
</template>

<script setup lang="ts">
import type { BookForm } from '@/apis/book'
import type { FormColumnItem } from '@/components/index'
import { Message } from '@arco-design/web-vue'
import { addBook, baseAPI, updateBook } from '@/apis/book'
import { GiForm } from '@/components/index'
import { useResetReactive } from '@/hooks'

const emit = defineEmits<{
  (e: 'save-success'): void
}>()

const GiFormRef = useTemplateRef<InstanceType<typeof GiForm>>('GiFormRef')
/** 编辑态的图书 id；为空表示新增 */
const bookId = ref<number | null>(null)
const isEdit = computed(() => bookId.value !== null)
const title = computed(() => (isEdit.value ? '编辑图书' : '新增图书'))
const visible = ref(false)
const saving = ref(false)

const [form, resetForm] = useResetReactive<BookForm>({
  id: undefined,
  name: '',
  isbn: '',
  author: '',
  keyword: '',
  publisher: '',
  image: '',
  originalPrice: null,
  categoryId: null
})

const formColumns = computed<FormColumnItem[]>(() => [
  {
    type: 'input',
    label: '书名',
    field: 'name',
    required: true,
    props: { maxLength: 100, placeholder: '请输入书名' }
  },
  {
    type: 'input',
    label: 'ISBN',
    field: 'isbn',
    props: { maxLength: 32, placeholder: '请输入 ISBN 编号' }
  },
  {
    type: 'input',
    label: '作者',
    field: 'author',
    props: { maxLength: 64, placeholder: '请输入作者' }
  },
  {
    type: 'input',
    label: '出版社',
    field: 'publisher',
    props: { maxLength: 64, placeholder: '请输入出版社' }
  },
  {
    type: 'input-number',
    label: '定价',
    field: 'originalPrice',
    required: true,
    props: { min: 0, precision: 2, placeholder: '请输入定价', style: { width: '100%' } }
  },
  {
    type: 'input',
    label: '封面图',
    field: 'image',
    props: { maxLength: 255, placeholder: '请输入封面图片 URL' }
  },
  {
    type: 'input',
    label: '关键字',
    field: 'keyword',
    props: { maxLength: 64, placeholder: '用于检索的关键字' }
  },
  {
    type: 'input-number',
    label: '分类 ID',
    field: 'categoryId',
    props: { min: 1, precision: 0, placeholder: '对应 book_category.id（可空）', style: { width: '100%' } }
  }
])

/** 打开「新增」弹窗：清空 id 与表单 */
const add = () => {
  bookId.value = null
  resetForm()
  visible.value = true
}

/** 打开「编辑」弹窗：先取详情再回填，避免列表里缺字段导致提交时丢数据 */
const edit = async (id: number) => {
  bookId.value = id
  visible.value = true
  try {
    const res = await baseAPI.getDetail({ id })
    Object.assign(form, res.data, { id: res.data.id })
  } catch {
    // 详情拉取失败时关闭弹窗，避免带着空表单提交覆盖原记录
    visible.value = false
    Message.error('图书详情加载失败')
  }
}

const close = () => {
  GiFormRef.value?.formRef?.resetFields()
  bookId.value = null
  resetForm()
}

const save = async () => {
  if (saving.value) return false

  const valid = await GiFormRef.value?.formRef?.validate()
  if (valid) return false

  // 兜底：`name` / `originalPrice` 在后端是硬约束（`Book.fromJson` 直接强转），
  // 缺失会以 500 的形式回来，这里先拦一道给出可读提示。
  if (!form.name?.trim()) {
    Message.warning('请填写书名')
    return false
  }
  if (form.originalPrice === null || form.originalPrice === undefined || Number.isNaN(Number(form.originalPrice))) {
    Message.warning('请填写合法的定价')
    return false
  }

  const payload: BookForm = {
    ...form,
    name: form.name.trim(),
    originalPrice: Number(form.originalPrice)
  }

  saving.value = true
  try {
    const res = isEdit.value ? await updateBook(payload) : await addBook(payload)
    if (!res.success) return false
    Message.success(isEdit.value ? '修改成功' : '新增成功')
    emit('save-success')
    return true
  } catch {
    // 失败提示已由 http 拦截器统一弹出（业务 code != 20000 / HTTP 异常），这里只负责不让弹窗关闭
    return false
  } finally {
    saving.value = false
  }
}

defineExpose({ add, edit })
</script>
