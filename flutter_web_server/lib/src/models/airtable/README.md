# 动态表格数据模型设计文档

## 📋 目录
- [设计概述](#设计概述)
- [核心目的](#核心目的)
- [数据模型](#数据模型)
- [解决的问题](#解决的问题)
- [应用场景](#应用场景)
- [数据流程示例](#数据流程示例)
- [设计优势](#设计优势)

---

## 🎯 设计概述

这是一个**元数据驱动的动态表格系统**，采用了类似 Airtable、Notion、飞书多维表格的设计思想。

### 核心理念
**把"数据库结构"本身也变成了数据！**

- **传统方式：** 表结构是固定的，数据是动态的
- **本设计：** 表结构和数据都是动态的

这使得用户可以像使用 Excel 一样自由地创建和修改表格结构，而不需要开发者介入修改数据库。

---

## 🎯 核心目的

### 1. 让用户能够动态创建表格
用户无需懂数据库，就能创建自己需要的表格结构。

### 2. 让用户能够动态添加列
用户可以随时添加、删除、修改列，不需要 `ALTER TABLE` 操作。

### 3. 支持灵活的数据关联
支持表与表、数据与数据、字段与字段之间的任意关联。

### 4. 提供完整的行列概念
明确表示每个数据单元格所在的行和列，支持排序和查询。

---

## 📊 数据模型

系统由四个核心实体组成：

```
Table（表格）
 ├─ Fields（列）
 │   └─ Items（单元格数据）
 └─ Rows（行）
     └─ Items（单元格数据）
```

### 1. Table（表格）

```yaml
class: Table
table: table
fields: 
 name: String
 fields: List<String>?, relation(name=table_fields)
```

**说明：**
- 代表用户创建的每一张表格
- 一个 Table 可以有多个 Field（列）
- 关系：`Table` → 一对多 → `Field`

**示例：**
```yaml
Table: { name: "客户管理" }
Table: { name: "订单管理" }
Table: { name: "产品目录" }
```

---

### 2. Field（列/字段）

```yaml
class: Field
table: field
fields:
 name: String
 table: Table?, relation(name=table_fields)
 items: List<Item>?, relation(name=field_items)
```

**说明：**
- 代表表格中的每一列
- 每个 Field 必须属于某个 Table
- 一个 Field 可以有多个 Item（该列下的所有单元格数据）
- 关系：`Field` → 多对一 → `Table`，`Field` → 一对多 → `Item`

**示例：**
```yaml
Field: { name: "客户姓名", table: "客户管理" }
Field: { name: "联系电话", table: "客户管理" }
Field: { name: "邮箱地址", table: "客户管理" }
```

---

### 3. Row（行）

```yaml
class: Row
table: row
fields:
 index: int  # 行号
 table: Table?, relation(name=table_rows)
 items: List<Item>?, relation(name=row_items)
```

**说明：**
- 代表表格中的每一行
- 通过 `index` 字段实现行的排序
- 一个 Row 包含该行的所有 Item（该行所有列的数据）
- 关系：`Row` → 多对一 → `Table`，`Row` → 一对多 → `Item`

**示例：**
```yaml
Row: { index: 1, table: "客户管理" }  # 第一行
Row: { index: 2, table: "客户管理" }  # 第二行
Row: { index: 3, table: "客户管理" }  # 第三行
```

---

### 4. Item（条目/单元格）

```yaml
class: Item
table: item
fields:
 value: String  # 单元格的值
 row: Row?, relation(name=row_items)
 patentField: Field?, relation(name=field_items)
 tiedItem: Item?, relation(optional)
 tiedField: Field?, relation(optional)
 tiedTable: Table?, relation(optional)
```

**说明：**
- 代表每个单元格的具体数据
- 每个 Item 必须属于某个 Field（列）和某个 Row（行）
- 支持关联其他 Item、Field 或 Table（实现数据之间的引用关系）
- 关系：`Item` → 多对一 → `Field`，`Item` → 多对一 → `Row`

**字段说明：**
- `value`: 单元格的实际数据值
- `row`: 该单元格所在的行
- `patentField`: 该单元格所在的列
- `tiedItem`: 关联到另一个单元格（实现单元格之间的引用）
- `tiedField`: 关联到某个字段（实现字段级别的关联）
- `tiedTable`: 关联到另一张表（实现表级别的关联）

**示例：**
```yaml
# 第1行，"客户姓名"列的数据
Item: { value: "张三", field: "客户姓名", row: 1 }

# 第1行，"联系电话"列的数据
Item: { value: "13800138000", field: "联系电话", row: 1 }

# 带关联的数据示例
# tiedTable 关联到客户表
# tiedItem 关联到具体客户
Item: { value: "订单001", field: "订单编号", row: 1, tiedTable: "客户管理", tiedItem: "张三" }
```

---

## 🔥 解决的问题

### 问题 1：传统数据库的局限性

#### 传统方式的问题

```sql
-- 用户想要一个"客户管理"表
CREATE TABLE customers (
  id INT,
  name VARCHAR(100),
  email VARCHAR(100)
);

-- 用户又想添加一个"电话"列？需要修改表结构！
ALTER TABLE customers ADD COLUMN phone VARCHAR(20);
```

**痛点：**
- ❌ 每次用户想添加列，都要修改数据库结构
- ❌ 需要开发者介入
- ❌ 不灵活，无法让用户自己定制
- ❌ 可能影响现有数据

#### 本设计的解决方案

```yaml
# 用户创建表格 → 在 Table 表中插入一条记录
Table: { name: "客户管理" }

# 用户添加列 → 在 Field 表中插入记录
Field: { name: "姓名", table: "客户管理" }
Field: { name: "邮箱", table: "客户管理" }
Field: { name: "电话", table: "客户管理" }  # 随时可以添加！

# 用户添加数据 → 在 Item 表中插入记录
Row: { index: 1, table: "客户管理" }
Item: { value: "张三", field: "姓名", row: 1 }
Item: { value: "zhangsan@example.com", field: "邮箱", row: 1 }
```

**优势：**
- ✅ 用户可以随时添加/删除列
- ✅ 不需要修改数据库结构
- ✅ 完全动态化
- ✅ 不影响现有数据

---

### 问题 2：数据之间的复杂关联

#### 应用场景

用户想要实现类似 Notion/Airtable 的关联功能：

```
订单表：
- 客户（关联到"客户表"）
- 产品（关联到"产品表"）
- 数量
- 总价

客户表：
- 姓名
- 邮箱
- 所有订单（反向关联到"订单表"）
```

#### 传统方式的问题

```sql
CREATE TABLE orders (
  customer_id INT FOREIGN KEY REFERENCES customers(id),
  product_id INT FOREIGN KEY REFERENCES products(id),
  ...
);
```

**痛点：**
- ❌ 关联关系是硬编码的
- ❌ 用户无法自己定义新的关联类型
- ❌ 修改关联关系需要修改表结构

#### 本设计的解决方案

```yaml
# 订单表中的某个订单
Item: {
  value: "订单001",
  field: "订单编号",
  row: 1,
  tiedTable: "客户表",    # 关联到客户表
  tiedItem: "张三",       # 关联到具体的客户
  tiedField: "客户姓名"   # 关联到客户姓名字段
}
```

**优势：**
- ✅ 用户可以自己定义任意关联
- ✅ 支持表与表、数据与数据、字段与字段之间的灵活关联
- ✅ 类似 Notion 的 Relation 功能
- ✅ 支持多层级关联

---

### 问题 3：行的概念和排序

#### 没有 Row 表的问题

假设用户输入以下数据：

```
| 姓名   | 年龄 | 邮箱              |
|--------|------|-------------------|
| 张三   | 25   | zhang@example.com |
| 李四   | 30   | li@example.com    |
```

如果没有 Row 表：
- ❌ 无法确定"张三"、"25"、"zhang@example.com"是同一行的数据
- ❌ 无法对行进行排序
- ❌ 无法删除某一行（只能一个个删除 Item）
- ❌ 查询某一行的所有数据很困难

#### 有了 Row 表的解决方案

```yaml
# 第一行
Row: { index: 1, table: "用户表" }
  ├─ Item: { value: "张三", field: "姓名", row: 1 }
  ├─ Item: { value: "25", field: "年龄", row: 1 }
  └─ Item: { value: "zhang@example.com", field: "邮箱", row: 1 }

# 第二行
Row: { index: 2, table: "用户表" }
  ├─ Item: { value: "李四", field: "姓名", row: 2 }
  ├─ Item: { value: "30", field: "年龄", row: 2 }
  └─ Item: { value: "li@example.com", field: "邮箱", row: 2 }
```

**优势：**
- ✅ 明确表示哪些 Item 属于同一行
- ✅ 可以通过 `index` 字段排序
- ✅ 可以轻松删除整行数据（删除 Row 即可级联删除所有相关 Item）
- ✅ 可以查询"第 N 行的所有数据"
- ✅ 支持行的拖拽排序（修改 index 值）

---

## 💼 应用场景

### 1. 低代码平台
用户可以自己创建表格、定义字段，搭建自己的业务系统，不需要懂数据库。

**示例：** 搭建一个简单的 CRM 系统
- 创建"客户表"、"订单表"、"产品表"
- 自定义需要的字段
- 设置表之间的关联关系

### 2. CRM/ERP 系统
不同企业有不同的业务需求，用户可以根据自己的需求自定义字段。

**示例：** 
- A 公司需要记录客户的"行业类型"
- B 公司需要记录客户的"公司规模"
- 用户可以自己添加需要的字段，而不需要开发者修改代码

### 3. 问卷/表单系统
每个问卷的问题不同，用户可以动态添加问题（字段）。

**示例：**
- 创建"客户满意度调查"表
- 添加问题：评分、文本反馈、多选题等
- 收集的数据自动存储到对应的 Item 中

### 4. 数据分析工具
用户可以导入任意结构的数据，系统自动创建对应的表格和字段。

**示例：**
- 导入 Excel 文件
- 系统自动创建 Table、Field、Row、Item
- 用户可以在系统中继续编辑和分析数据

### 5. 项目管理工具
类似 Trello、Asana 的看板系统。

**示例：**
- 创建"项目任务"表
- 字段：任务名称、负责人、状态、优先级、截止日期
- 通过关联功能，关联到"团队成员"表

---

## 📝 数据流程示例

### 完整示例：创建一个"项目管理"表格

#### 步骤 1：用户创建表格

```yaml
Table: { id: 1, name: "项目管理" }
```

#### 步骤 2：用户添加列

```yaml
Field: { id: 1, name: "项目名称", table: 1 }
Field: { id: 2, name: "负责人", table: 1 }
Field: { id: 3, name: "状态", table: 1 }
Field: { id: 4, name: "优先级", table: 1 }
```

#### 步骤 3：用户添加第一行数据

```yaml
# 创建第一行
Row: { id: 1, index: 1, table: 1 }

# 添加该行的各列数据
Item: { id: 1, value: "网站重构", field: 1, row: 1 }
Item: { id: 2, value: "张三", field: 2, row: 1 }
Item: { id: 3, value: "进行中", field: 3, row: 1 }
Item: { id: 4, value: "高", field: 4, row: 1 }
```

#### 步骤 4：用户添加第二行数据

```yaml
# 创建第二行
Row: { id: 2, index: 2, table: 1 }

# 添加该行的各列数据
Item: { id: 5, value: "APP开发", field: 1, row: 2 }
Item: { id: 6, value: "李四", field: 2, row: 2 }
Item: { id: 7, value: "已完成", field: 3, row: 2 }
Item: { id: 8, value: "中", field: 4, row: 2 }
```

#### 步骤 5：用户添加关联（可选）

假设有一个"团队成员"表，我们想把"负责人"关联到该表：

```yaml
# 修改"负责人"字段的 Item，添加关联
Item: { 
  id: 2, 
  value: "张三", 
  field: 2, 
  row: 1,
  tiedTable: "团队成员",  # 关联到团队成员表
  tiedItem: "张三"        # 关联到具体的成员
}
```

### 最终呈现给用户的表格

```
| 项目名称   | 负责人 | 状态   | 优先级 |
|-----------|--------|--------|--------|
| 网站重构   | 张三   | 进行中 | 高     |
| APP开发    | 李四   | 已完成 | 中     |
```

---

## ✨ 设计优势

### 1. 极高的灵活性
- 用户可以随时创建、修改、删除表格和字段
- 不需要开发者介入
- 不需要修改数据库结构

### 2. 强大的关联能力
- 支持表与表之间的关联
- 支持数据与数据之间的关联
- 支持字段与字段之间的关联
- 类似 Notion 的 Relation 和 Rollup 功能

### 3. 完整的行列概念
- 通过 Row 表明确表示行
- 通过 Field 表明确表示列
- 通过 Item 表存储具体的单元格数据
- 支持行列的排序和查询

### 4. 易于扩展
- 可以轻松添加新功能（如：字段类型、数据验证、权限控制等）
- 可以支持更复杂的数据关系
- 可以实现视图、筛选、排序等高级功能

### 5. 数据隔离
- 每个用户的数据都存储在同一套表结构中
- 通过 Table 的所有者来区分不同用户的数据
- 便于实现多租户系统

---

## 🔄 与传统数据库的对比

| 特性 | 传统数据库 | 本设计 |
|------|-----------|--------|
| 创建表 | 需要执行 SQL | 插入一条 Table 记录 |
| 添加列 | 需要 ALTER TABLE | 插入一条 Field 记录 |
| 修改列 | 需要 ALTER TABLE | 更新 Field 记录 |
| 删除列 | 需要 ALTER TABLE | 删除 Field 记录 |
| 数据关联 | 硬编码的外键 | 灵活的 tied* 字段 |
| 用户自定义 | 不支持 | 完全支持 |
| 开发者介入 | 需要 | 不需要 |

---

## 🚀 技术实现建议

### 1. 性能优化
- 为 `Row.index`、`Field.table`、`Item.row`、`Item.field` 等字段添加索引
- 考虑使用缓存来存储常用的表结构信息
- 对于大量数据的查询，考虑使用分页

### 2. 数据验证
- 在应用层添加字段类型验证（文本、数字、日期等）
- 添加必填字段验证
- 添加数据格式验证

### 3. 权限控制
- 添加 Table 的所有者字段
- 实现基于角色的访问控制（RBAC）
- 支持表的共享和协作

### 4. 视图和筛选
- 实现类似 Airtable 的视图功能
- 支持筛选、排序、分组
- 支持自定义视图配置

---

## 📚 参考

这种设计模式被广泛应用于以下产品：

- **Airtable**: 在线协作数据库
- **Notion**: 笔记和协作工具
- **飞书多维表格**: 企业协作平台
- **维格表**: 国产 Airtable 替代品
- **Seatable**: 开源的在线协作数据库

---

## 📄 许可证

本文档遵循项目的开源许可证。

---

**最后更新：** 2025-10-25

