export interface CateTreeItem {
  id: number
  name: string
  pid: number | null
  type: string | null
  disabled: boolean
  children: CateTreeItem[]
}
