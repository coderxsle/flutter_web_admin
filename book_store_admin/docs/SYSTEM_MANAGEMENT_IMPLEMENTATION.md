本文档详细说明系统管理模块的实施计划，包括用户管理、角色管理和资源管理三个子模块。系统管理模块是整个权限体系的基础，优先实现该模块可以为后续其他功能提供必要的权限控制。

## 一、数据库结构概览
基于现有数据库设计，系统管理模块涉及以下数据表：

### 1. 系统用户表 (sys_user)
+ 存储管理员用户信息
+ 包含用户名、密码、姓名、角色、权限等字段
+ 记录用户状态、创建时间、登录时间等

### 2. 系统角色表 (sys_role)
+ 存储角色定义
+ 包含角色名称等基本信息

### 3. 系统资源表 (sys_resource)
+ 存储菜单、按钮等资源信息
+ 记录资源类型、名称、URI、权限标识等
+ 支持资源嵌套（父子关系）

### 4. 用户-角色关联表 (sys_user_role)
+ 存储用户和角色的多对多关系
+ 通过用户ID和角色ID进行关联

### 5. 角色-资源关联表 (sys_role_resource)
+ 存储角色和资源的多对多关系
+ 通过角色ID和资源ID进行关联

### 6. 系统操作日志表 (sys_operation_log)
+ 记录系统操作日志
+ 包含操作类型、操作时间、操作人、操作内容等信息

## 二、实施步骤
### 阶段一：用户管理（预计5天）
1. **页面设计与实现**
    - 设计用户列表页面
    - 实现用户添加/编辑表单
    - 实现用户状态管理界面
2. **API接口开发**
    - 用户列表查询接口
    - 用户添加/编辑/删除接口
    - 用户状态更新接口
    - 密码重置接口
3. **功能逻辑实现**
    - 用户数据的CRUD操作
    - 密码加密处理
    - 表单验证逻辑
4. **UI交互优化**
    - 表格分页与排序
    - 搜索过滤功能
    - 操作反馈提示

### 阶段二：角色管理（预计3天）
1. **页面设计与实现**
    - 角色列表页面
    - 角色添加/编辑表单
    - 角色-用户关联管理界面
2. **API接口开发**
    - 角色列表查询接口
    - 角色添加/编辑/删除接口
    - 角色-用户关联管理接口
3. **功能逻辑实现**
    - 角色数据的CRUD操作
    - 角色-用户关系处理
    - 表单验证逻辑
4. **UI交互优化**
    - 角色列表分页
    - 用户分配界面优化
    - 操作反馈提示

### 阶段三：资源管理（预计4天）
1. **页面设计与实现**
    - 资源树形列表页面
    - 资源添加/编辑表单
    - 角色-资源关联管理界面
2. **API接口开发**
    - 资源树形列表查询接口
    - 资源添加/编辑/删除接口
    - 角色-资源关联管理接口
3. **功能逻辑实现**
    - 资源数据的CRUD操作
    - 资源树形结构处理
    - 角色-资源关系处理
4. **UI交互优化**
    - 树形结构展示优化
    - 权限分配界面优化
    - 操作反馈提示

### 阶段四：权限应用（预计3天）
1. **前端权限控制**
    - 实现基于角色的菜单显示
    - 实现基于权限的按钮显示
    - 实现路由访问控制
2. **后端权限校验**
    - 实现API接口权限校验
    - 实现数据权限过滤
    - 完善权限检查机制
3. **权限缓存优化**
    - 用户权限缓存机制
    - 权限刷新机制
    - 性能优化

## 三、关键接口定义
1. **用户管理接口**

```json
GET /api/system/users - 获取用户列表
POST /api/system/users - 添加用户
PUT /api/system/users/{id} - 更新用户
DELETE /api/system/users/{id} - 删除用户
PUT /api/system/users/{id}/status - 更新用户状态
PUT /api/system/users/{id}/password - 重置密码
GET /api/system/users/{id}/roles - 获取用户角色
PUT /api/system/users/{id}/roles - 分配用户角色
```

2. **角色管理接口**

```json
GET /api/system/roles - 获取角色列表
POST /api/system/roles - 添加角色
PUT /api/system/roles/{id} - 更新角色
DELETE /api/system/roles/{id} - 删除角色
GET /api/system/roles/{id}/users - 获取角色用户
GET /api/system/roles/{id}/resources - 获取角色资源
PUT /api/system/roles/{id}/resources - 分配角色资源
```

3. **资源管理接口**

```json
GET /api/system/resources - 获取资源树
POST /api/system/resources - 添加资源
PUT /api/system/resources/{id} - 更新资源
DELETE /api/system/resources/{id} - 删除资源
```

## 四、数据结构示例
1. **用户管理**
    - 用户列表返回结果使用的类为：  
    book_store_shared/lib/src/models/page_response.dart  
    book_store_shared/lib/src/models/common_response.dart
    - 返回数据格式为：

```json
{
  "code": 20000,
  "message": "success",
  "data": {
    "totalPage": 10,
    "pageSize": 10,
    "pageNum": 1,
    "data": [
      {
        "id": 1,
        "username": "admin",
        "truename": "系统管理员",
        "nickname": "管理员",
        "email": "admin@example.com",
        "phone": "13800138000",
        "status": 0,
        "loginTime": "2023-02-01 10:00:00",
        "createTime": "2023-01-01 00:00:00",
        "roles": ["超级管理员"]
      }
    ]
  }
}
```

2. **角色管理**
    - 角色列表返回：

```json
{
  "code": 20000,
  "message": "success",
  "data": {
    "totalPage": 10,
    "pageSize": 10,
    "pageNum": 1,
    "data": [
      {
        "id": 1,
        "name": "超级管理员",
        "userCount": 1,
        "resourceCount": 20
      }
    ]
  }
}
```



3. **资源管理**
    - 资源树返回：

```json
{
  "code": 20000,
  "message": "success",
  "data": [
    {
      "id": 1,
      "name": "系统管理",
      "uri": "/system",
      "permission": "system:view",
      "type": 0,
      "icon": "settings",
      "sn": 1,
      "parentId": 0,
      "children": [
        {
          "id": 2,
          "name": "用户管理",
          "uri": "/system/users",
          "permission": "system:user:view",
          "type": 1,
          "icon": "user",
          "sn": 1,
          "parentId": 1,
          "children": []
        }
      ]
    }
  ]
}
```

## 五、注意事项
1. **数据安全**
    - 用户密码必须加密存储
    - 敏感操作需要二次确认
    - 重要操作需要记录日志
2. **性能考虑**
    - 权限检查需要考虑性能影响
    - 大数据量情况下的分页优化
    - 资源树加载优化
3. **用户体验**
    - 操作流程简化
    - 提供清晰的操作反馈
    - 权限变更实时生效

## 六、测试计划
1. **单元测试**
    - API接口测试
    - 数据处理逻辑测试
    - 权限检查测试
2. **功能测试**
    - 用户管理功能测试
    - 角色管理功能测试
    - 资源管理功能测试
3. **集成测试**
    - 权限分配与应用测试
    - 不同角色用户操作测试
    - 系统整体功能测试

