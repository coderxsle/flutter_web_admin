import Table from './GiTable.vue'

export type * from './type'
// gi 源代码
// export type TableInstance = InstanceType<typeof Table>
// 修复报错
export type TableInstance = typeof Table extends new (...args: any) => infer R ? R : never
export { Table as GiTable }