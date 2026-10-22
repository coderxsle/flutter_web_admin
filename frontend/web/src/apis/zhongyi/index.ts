import http from '@/utils/http'

export interface PageResult<T> {
  records: T[]
  total: number
  page?: number
  pageSize?: number
}

export interface Medicine {
  id: number
  medicineCode: string
  prefix?: string
  name: string
  pinyin?: string
  category?: string
  subcategory?: string
  originPlace?: string
  properties?: Record<string, unknown>
  functions?: string
  indications?: string
  commonDosageMin?: number
  commonDosageMax?: number
  dosageWarning?: number
  toxicity?: string
  pregnancyCategory?: string
  isSpecialManagement?: boolean
  storageRequirements?: string
  shelfLifeMonths?: number
  retailSaleUnit?: string
  retailSalePrice?: number
  latestPurchasePrice?: number
  stockQuantityG?: number
  status?: number
  description?: string
  createdTime?: string
  updatedTime?: string
}

export interface MedicinePrice {
  id?: number
  medicineId: number
  priceType: string
  unit: string
  salePrice: number
  effectiveFrom?: string
  effectiveTo?: string
}

export interface Inventory {
  id: number
  medicineId: number
  medicineName?: string
  batchNumber: string
  supplierId?: number
  quantityG: number
  unit: string
  purchasePrice?: number
  productionDate?: string
  expiryDate?: string
  qualityStatus?: string
  storageLocation?: string
  isExhausted?: boolean
  description?: string
  status?: number
  createdTime?: string
  updatedTime?: string
}

export interface InventoryTransaction {
  id: number
  medicineId: number
  inventoryId?: number
  batchNumber?: string
  transactionType: string
  quantityBefore?: number
  quantityChange: number
  quantityAfter?: number
  remark?: string
  transactionTime?: string
}

export interface Department {
  id: number
  name: string
  code: string
  parentId?: number
  sortOrder?: number
  isActive?: boolean
  phone?: string
  description?: string
  children?: Department[]
}

export interface Staff {
  id: number
  userId?: number
  name?: string
  username?: string
  gender?: string
  mobile?: string
  departmentId?: number
  employeeCode: string
  professionalTitle?: string
  licenseNumber?: string
  specialization?: string
  isDoctor?: boolean
  isPharmacist?: boolean
  consultationFee?: number
  introduction?: string
  description?: string
}

export interface Patient {
  id: number
  name: string
  gender?: number
  birthDate?: string
  phone?: string
  occupation?: string
  bloodType?: string
  constitution?: string
  source?: string
  createTime?: string
  idCard?: string
  address?: string
  emergencyContact?: string
  emergencyPhone?: string
  allergyHistory?: string
  medicalHistory?: string
  familyHistory?: string
  updateTime?: string
}

export interface Billing {
  id: number
  billNo: string
  patientId: number
  patientName?: string
  billingStage: string
  totalAmount: number
  paidAmount: number
  refundedAmount: number
  paymentStatus: string
  status: number
  remark?: string
  notes?: string
  discountAmount?: number
  discountReason?: string
  cashierId?: number
  paidAt?: string
  createTime?: string
  items: BillingItem[]
  payments?: Payment[]
}

export interface BillingItem {
  id?: number
  billId?: number
  itemType: string
  itemName: string
  quantity: number
  unitPrice: number
  amount: number
  unit?: string
  specification?: string
  referenceType?: string
  referenceId?: number
  isRefunded?: boolean
  refundedQuantity?: number
}

export interface Payment {
  id?: number
  channel: string
  amount: number
  transactionNo?: string
  status?: number
  paidAt?: string
}

export interface PrescriptionTemplate {
  id: number
  name: string
  scope: string
  category?: string
  sourceType?: string
  sourceId?: number
  doctorId?: number
  syndrome?: string
  efficacy?: string
  doses: number
  dailyFrequency?: string
  administrationMethod?: string
  decoctionInstruction?: string
  dietRestrictions?: string
  notes?: string
  isActive: boolean
  creator?: string
  updater?: string
  items: PrescriptionItem[]
  createTime?: string
  updateTime?: string
}

export interface PrescriptionItem {
  id?: number
  templateId?: number
  medicineId: number
  sortOrder?: number
  role?: string
  dosageGrams: number
  dosageUnit?: string
  dosageText?: string
  usageMethod?: string
  isSubstitute?: boolean
  substituteForId?: number
  notes?: string
}

type Query = Record<string, unknown>

const asPage = <T>(data: unknown): PageResult<T> => {
  if (Array.isArray(data)) return { records: data as T[], total: data.length }
  const value = (data || {}) as Record<string, unknown>
  const records = (value.records ?? []) as T[]
  return {
    records,
    total: Number(value.total ?? records.length),
    page: Number(value.page ?? 1),
    pageSize: Number(value.pageSize ?? records.length)
  }
}

export const zhongyiApi = {
  medicine: {
    list: (query: Query) => http.get<PageResult<Medicine>>('/lxs_zhongyi/medicine/list', query).then((res) => ({ ...res, data: asPage<Medicine>(res.data) })),
    options: (query?: Query) => http.get<Medicine[]>('/lxs_zhongyi/medicine/options', query),
    detail: (id: number) => http.get<Medicine>(`/lxs_zhongyi/medicine/detail/${id}`),
    create: (data: Partial<Medicine>) => http.post<Medicine>('/lxs_zhongyi/medicine/create', data),
    update: (id: number, data: Partial<Medicine>) => http.post<Medicine>(`/lxs_zhongyi/medicine/update/${id}`, data),
    remove: (ids: number[]) => http.post<unknown>('/lxs_zhongyi/medicine/delete', ids),
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
    update: (id: number, data: Partial<Department>) => http.post<Department>(`/lxs_zhongyi/department/update/${id}`, data),
    remove: (ids: number[]) => http.post<unknown>('/lxs_zhongyi/department/delete', ids)
  },
  staff: {
    list: (query: Query) => http.get<PageResult<Staff>>('/lxs_zhongyi/staff/list', query).then((res) => ({ ...res, data: asPage<Staff>(res.data) })),
    detail: (id: number) => http.get<Staff>(`/lxs_zhongyi/staff/detail/${id}`),
    create: (data: Partial<Staff>) => http.post<Staff>('/lxs_zhongyi/staff/create', data),
    update: (id: number, data: Partial<Staff>) => http.post<Staff>(`/lxs_zhongyi/staff/update/${id}`, data),
    remove: (ids: number[]) => http.post<unknown>('/lxs_zhongyi/staff/delete', ids)
  },
  patient: {
    list: (query: Query) => http.get<PageResult<Patient>>('/lxs_zhongyi/patient/list', query).then((res) => ({ ...res, data: asPage<Patient>(res.data) })),
    detail: (id: number) => http.get<Patient>(`/lxs_zhongyi/patient/detail/${id}`),
    create: (data: Partial<Patient>) => http.post<Patient>('/lxs_zhongyi/patient/create', data),
    update: (id: number, data: Partial<Patient>) => http.post<Patient>(`/lxs_zhongyi/patient/update/${id}`, data),
    remove: (ids: number[]) => http.post<unknown>('/lxs_zhongyi/patient/delete', ids)
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
    update: (id: number, data: Partial<PrescriptionTemplate>) => http.post<PrescriptionTemplate>(`/lxs_zhongyi/prescription-template/update/${id}`, data),
    remove: (ids: number[]) => http.post<unknown>('/lxs_zhongyi/prescription-template/delete', ids),
    status: (id: number, isActive: boolean) => http.post<PrescriptionTemplate>(`/lxs_zhongyi/prescription-template/${id}/status`, { isActive: isActive })
  }
}

export { asPage }
