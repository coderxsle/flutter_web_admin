import http from '@/utils/http'

export interface PageResult<T> {
  records: T[]
  total: number
  page?: number
  pageSize?: number
}

export interface Medicine {
  id: number
  medicine_code: string
  prefix?: string
  name: string
  pinyin?: string
  category?: string
  subcategory?: string
  origin_place?: string
  properties?: Record<string, unknown>
  functions?: string
  indications?: string
  common_dosage_min?: number
  common_dosage_max?: number
  dosage_warning?: number
  toxicity?: string
  pregnancy_category?: string
  is_special_management?: boolean
  storage_requirements?: string
  shelf_life_months?: number
  retail_sale_unit?: string
  retail_sale_price?: number
  latest_purchase_price?: number
  stock_quantity_g?: number
  status?: number
  description?: string
  created_time?: string
  updated_time?: string
}

export interface MedicinePrice {
  id?: number
  medicine_id: number
  price_type: string
  unit: string
  sale_price: number
  effective_from?: string
  effective_to?: string
}

export interface Inventory {
  id: number
  medicine_id: number
  medicine_name?: string
  batch_number: string
  supplier_id?: number
  quantity_g: number
  unit: string
  purchase_price?: number
  production_date?: string
  expiry_date?: string
  quality_status?: string
  storage_location?: string
  is_exhausted?: boolean
  description?: string
  status?: number
  created_time?: string
  updated_time?: string
}

export interface InventoryTransaction {
  id: number
  medicine_id: number
  inventory_id?: number
  batch_number?: string
  transaction_type: string
  quantity_before?: number
  quantity_change: number
  quantity_after?: number
  remark?: string
  transaction_time?: string
}

export interface Department {
  id: number
  name: string
  code: string
  parent_id?: number
  sort_order?: number
  is_active?: boolean
  phone?: string
  description?: string
  children?: Department[]
}

export interface Staff {
  id: number
  user_id?: number
  name?: string
  username?: string
  gender?: string
  mobile?: string
  department_id?: number
  employee_code: string
  professional_title?: string
  license_number?: string
  specialization?: string
  is_doctor?: boolean
  is_pharmacist?: boolean
  consultation_fee?: number
  introduction?: string
  description?: string
}

export interface Patient {
  id: number
  name: string
  gender?: number
  birth_date?: string
  phone?: string
  occupation?: string
  blood_type?: string
  constitution?: string
  source?: string
  create_time?: string
  id_card?: string
  address?: string
  emergency_contact?: string
  emergency_phone?: string
  allergy_history?: string
  medical_history?: string
  family_history?: string
  update_time?: string
}

export interface Billing {
  id: number
  bill_no: string
  patient_id: number
  patient_name?: string
  billing_stage: string
  total_amount: number
  paid_amount: number
  refunded_amount: number
  payment_status: string
  status: number
  remark?: string
  notes?: string
  discount_amount?: number
  discount_reason?: string
  cashier_id?: number
  paid_at?: string
  create_time?: string
  items: BillingItem[]
  payments?: Payment[]
}

export interface BillingItem {
  id?: number
  bill_id?: number
  item_type: string
  item_name: string
  quantity: number
  unit_price: number
  amount: number
  unit?: string
  specification?: string
  reference_type?: string
  reference_id?: number
  is_refunded?: boolean
  refunded_quantity?: number
}

export interface Payment {
  id?: number
  channel: string
  amount: number
  transaction_no?: string
  status?: number
  paid_at?: string
}

export interface PrescriptionTemplate {
  id: number
  name: string
  scope: string
  category?: string
  source_type?: string
  source_id?: number
  doctor_id?: number
  syndrome?: string
  efficacy?: string
  doses: number
  daily_frequency?: string
  administration_method?: string
  decoction_instruction?: string
  diet_restrictions?: string
  notes?: string
  is_active: boolean
  creator?: string
  updater?: string
  items: PrescriptionItem[]
  create_time?: string
  update_time?: string
}

export interface PrescriptionItem {
  id?: number
  template_id?: number
  medicine_id: number
  sort_order?: number
  role?: string
  dosage_grams: number
  dosage_unit?: string
  dosage_text?: string
  usage_method?: string
  is_substitute?: boolean
  substitute_for_id?: number
  notes?: string
}

type Query = Record<string, unknown>

const put = <T>(url: string, data?: unknown) => http.request<T>({ method: 'put', url, data })
const del = <T>(url: string, data?: unknown) => http.request<T>({ method: 'delete', url, data })

const asPage = <T>(data: unknown): PageResult<T> => {
  if (Array.isArray(data)) return { records: data as T[], total: data.length }
  const value = (data || {}) as Record<string, unknown>
  const records = (value.records ?? value.items ?? []) as T[]
  return {
    records,
    total: Number(value.total ?? records.length),
    page: Number(value.page ?? value.page_no ?? 1),
    pageSize: Number(value.pageSize ?? value.page_size ?? records.length)
  }
}

export const zhongyiApi = {
  medicine: {
    list: (query: Query) => http.get<PageResult<Medicine>>('/lxs_zhongyi/medicine/list', query).then((res) => ({ ...res, data: asPage<Medicine>(res.data) })),
    options: (query?: Query) => http.get<Medicine[]>('/lxs_zhongyi/medicine/options', query),
    detail: (id: number) => http.get<Medicine>(`/lxs_zhongyi/medicine/detail/${id}`),
    create: (data: Partial<Medicine>) => http.post<Medicine>('/lxs_zhongyi/medicine/create', data),
    update: (id: number, data: Partial<Medicine>) => put<Medicine>(`/lxs_zhongyi/medicine/update/${id}`, data),
    remove: (ids: number[]) => del<unknown>('/lxs_zhongyi/medicine/delete', ids),
    prices: (id: number) => http.get<MedicinePrice[]>(`/lxs_zhongyi/medicine/${id}/prices`),
    addPrice: (id: number, data: Partial<MedicinePrice>) => http.post<MedicinePrice>(`/lxs_zhongyi/medicine/${id}/prices`, data)
  },
  inventory: {
    list: (query: Query) => http.get<PageResult<Inventory>>('/lxs_zhongyi/inventory/list', query).then((res) => ({ ...res, data: asPage<Inventory>(res.data) })),
    detail: (id: number) => http.get<Inventory>(`/lxs_zhongyi/inventory/detail/${id}`),
    stockIn: (data: Query) => http.post<Inventory>('/lxs_zhongyi/inventory/stock-in', data),
    adjust: (data: Query) => http.post<Inventory>('/lxs_zhongyi/inventory/adjust', data),
    transactions: (query: Query) => http.get<PageResult<InventoryTransaction>>('/lxs_zhongyi/inventory/transaction/list', query).then((res) => ({ ...res, data: asPage<InventoryTransaction>(res.data) }))
  },
  department: {
    tree: (query?: Query) => http.get<Department[]>('/lxs_zhongyi/department/tree', query),
    detail: (id: number) => http.get<Department>(`/lxs_zhongyi/department/detail/${id}`),
    create: (data: Partial<Department>) => http.post<Department>('/lxs_zhongyi/department/create', data),
    update: (id: number, data: Partial<Department>) => put<Department>(`/lxs_zhongyi/department/update/${id}`, data),
    remove: (ids: number[]) => del<unknown>('/lxs_zhongyi/department/delete', ids)
  },
  staff: {
    list: (query: Query) => http.get<PageResult<Staff>>('/lxs_zhongyi/staff/list', query).then((res) => ({ ...res, data: asPage<Staff>(res.data) })),
    detail: (id: number) => http.get<Staff>(`/lxs_zhongyi/staff/detail/${id}`),
    create: (data: Partial<Staff>) => http.post<Staff>('/lxs_zhongyi/staff/create', data),
    update: (id: number, data: Partial<Staff>) => put<Staff>(`/lxs_zhongyi/staff/update/${id}`, data),
    remove: (ids: number[]) => del<unknown>('/lxs_zhongyi/staff/delete', ids)
  },
  patient: {
    list: (query: Query) => http.get<PageResult<Patient>>('/lxs_zhongyi/patient/list', query).then((res) => ({ ...res, data: asPage<Patient>(res.data) })),
    detail: (id: number) => http.get<Patient>(`/lxs_zhongyi/patient/detail/${id}`),
    create: (data: Partial<Patient>) => http.post<Patient>('/lxs_zhongyi/patient/create', data),
    update: (id: number, data: Partial<Patient>) => put<Patient>(`/lxs_zhongyi/patient/update/${id}`, data),
    remove: (ids: number[]) => del<unknown>('/lxs_zhongyi/patient/delete', ids)
  },
  billing: {
    list: (query: Query) => http.get<PageResult<Billing>>('/lxs_zhongyi/billing/list', query).then((res) => ({ ...res, data: asPage<Billing>(res.data) })),
    detail: (id: number) => http.get<Billing>(`/lxs_zhongyi/billing/detail/${id}`),
    create: (data: Query) => http.post<Billing>('/lxs_zhongyi/billing/create', data),
    pay: (id: number, data: Query) => http.post<Payment>(`/lxs_zhongyi/billing/${id}/pay`, data),
    cancel: (id: number) => http.post<Billing>(`/lxs_zhongyi/billing/${id}/cancel`),
    refund: (id: number, data: Query) => http.post<unknown>(`/lxs_zhongyi/billing/${id}/refund`, data),
    approveRefund: (id: number) => http.post<unknown>(`/lxs_zhongyi/billing/refund/${id}/approve`),
    completeRefund: (id: number) => http.post<unknown>(`/lxs_zhongyi/billing/refund/${id}/complete`)
  },
  template: {
    list: (query: Query) => http.get<PageResult<PrescriptionTemplate>>('/lxs_zhongyi/prescription-template/list', query).then((res) => ({ ...res, data: asPage<PrescriptionTemplate>(res.data) })),
    detail: (id: number) => http.get<PrescriptionTemplate>(`/lxs_zhongyi/prescription-template/detail/${id}`),
    create: (data: Partial<PrescriptionTemplate>) => http.post<PrescriptionTemplate>('/lxs_zhongyi/prescription-template/create', data),
    update: (id: number, data: Partial<PrescriptionTemplate>) => put<PrescriptionTemplate>(`/lxs_zhongyi/prescription-template/update/${id}`, data),
    remove: (ids: number[]) => del<unknown>('/lxs_zhongyi/prescription-template/delete', ids),
    status: (id: number, isActive: boolean) => http.post<PrescriptionTemplate>(`/lxs_zhongyi/prescription-template/${id}/status`, { is_active: isActive })
  }
}

export { asPage }
