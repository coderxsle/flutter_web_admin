# gi-demo 提交分析（2026-03-30 至今）与同步方案

- 远程仓库：https://gitee.com/lin0716/gi-demo
- 分析时间：2026-09-20
- 远程 `master` HEAD：`61df64cc`（2026-06-15）
- 时间范围内提交：**27 条**（2026-03-30 ~ 2026-06-15，作者均为「木糖醇」）
- 分支情况：`origin/dev-01` 已完全并入 `origin/master`，无需单独同步
- 本地目标目录：`/Users/coderxslee/workspace/flutter_web_admin/gi_demo_admin`

---

## 一、本地现状诊断（关键）

### 1. `gi_demo_admin` 并不是一个 git 仓库

- 目录内**没有 `.git`**；
- 其文件是被**父仓库 `/Users/coderxslee/workspace/flutter_web_admin`**（远程 `gitee.com/coderxslee/flutter_web_admin.git`）跟踪的，共 440 个文件；
- 在父仓库里的相关提交只有两条：`75bd83c`（新增 Gi Admin Pro）、`51a10e2`（修复双列布局切换一级菜单…）。

也就是说，目前不存在「gi_demo_admin 仓库的历史」可以对齐远程。

### 2. 本地代码 = 远程 `f137b5e4`（2026-03-30） + 一批本地改造

以内容哈希逐文件比对，本地与远程 `f137b5e4` 的差异为：

| 类别 | 数量 | 说明 |
|---|---|---|
| 内容被改动的文件 | 46 | 见下表 |
| 本地新增的文件 | 5 | `260330.md`、`src/utils/crypto.ts`、`src/views/system/role/components/{PermissionPanel,RoleSidebar,RoleUserPanel}.vue` |
| 本地删除的文件 | 1 | `src/views/system/role/RolePermModal.vue`（被上面 3 个角色组件拆分替代） |
| 噪音 | 2 | 两个 mp3 只是 macOS Unicode 归一化差异，内容一致，不算改动 |

改动规模：**+2190 行 / −447 行，涉及 52 个文件**。主要本地改造：

- **角色管理页面重构**：`src/views/system/role/index.vue`（+587/−94），把远程的 `RolePermModal.vue` 拆成 `RoleSidebar.vue`(167)、`RoleUserPanel.vue`(117)、`PermissionPanel.vue`(239)
- **新增工具**：`src/utils/crypto.ts`（+99，加密工具）
- **用户管理**：`src/views/system/user/index.vue`（+118/−18）、`UserFormModal.vue`（+109/−26）、`UserDetailDrawer.vue`
- **HTTP / 鉴权**：`src/utils/http.ts`（+148/−18）、`src/utils/auth.ts`（+21/−1）、`src/utils/regexp.ts`（+21/−10）
- **字典模块**：`src/apis/system/dict.ts`（+74/−12）、`DictDataFormModal.vue`（+53/−15）、`dict/index.vue`、`DictFormModal.vue`
- **API 层与类型**：`src/apis/base.ts`、`apis/user/index.ts`、`apis/system/role.ts`、`apis/system/user.ts`、`apis/cate/type.ts`、`apis/file/*`、`apis/person/type.ts`
- **Store / Hooks**：`src/stores/useUserStore.ts`（+27/−15）、`src/hooks/useTable.ts`、`hooks/app/useDept.ts`、`hooks/app/useRole.ts`
- **构建/环境配置**：`.env.development`、`.env.production`、`.env.test`、`.gitignore`、`.vscode/settings.json`
- **其他页面**：`src/views/system/dept/*`、`menu/*`、`views/demo/examples/gi-button-demo/index.vue`、`views/file/components/*Modal/ModalContent.vue`

> 结论：本地不是远程的干净副本，而是一个**已经分叉的本地改造分支**。

---

## 二、逐条提交明细（27 条）

> 标记说明：`⚠️冲突预判` 表示该提交触碰了本地已改造的文件。

### 2026-03-30

**1. `f137b5e4` — feat: 修复双列布局切换一级菜单，二级菜单没有自动展开问题，GiForm 的 defaultCollapsed 默认值改为 true**
- 10:25:24 ｜ *本地基点，已包含在当前目录中，无需再同步*

**2. `f69acf8b` — feat: @iconify-json/icon-park-outline 图标集改为离线注册**
- 16:24:59 ｜ 1 文件，+5/−8
- `src/main.ts`：IconPark 图标集由在线按需加载改为离线注册（本地打包）。

**3. `884e8d9d` — feat: GiIconSelector 组件重构，支持 iconpark**
- 18:32:08 ｜ 5 文件，+147/−125
- 重构 `src/components/GiIconSelector/GiIconSelector.vue`、`type.ts`；更新示例页 `gi-icon-selector-demo/index.vue`；适配 `views/system/menu/MenuFormModal.vue`；`.vscode/settings.json`
- ⚠️冲突预判：与本地改造的 `.vscode/settings.json`、`MenuFormModal.vue` 重叠

### 2026-04-17

**4. `11d68ac5` — feat: 升级组件库版本，更换系统菜单图标**
- 15:15:52 ｜ 24 文件，+65/−125
- `package.json` / `package-lock.json` 升级依赖；**删除 `src/icons/` 下 19 个 svg**（menu-*.svg、arco.svg、vite.svg 等）改为组件库内置图标；`mock/_data/system_menu.ts` 菜单图标调整；`src/router/index.ts`、`src/styles/arco-ui/a-menu.less`

**5. `4d3b2991` — feat: 修复文件管理图标缺失**
- 15:27:26 ｜ 2 文件，+2/−1
- 新增 `src/icons/file-all.svg`，修正 `src/utils/file.ts` 中的图标映射。

### 2026-04-21

**6. `e4c51ad3` — feat: 删除 GiSpace 组件，新增 GiFlex 组件**
- 16:51:25 ｜ 11 文件，+154/−167
- 新增 `src/components/GiFlex/{GiFlex.vue,index.ts,type.ts}`；删除 `src/components/GiSpace/*`；新增示例页 `gi-flex-demo`，删除 `gi-space-demo`；同步 `src/components.d.ts`、`src/components/index.ts`、`views/demo/index.vue`
- ⚠️冲突预判：`src/components.d.ts`

### 2026-04-23

**7. `2db3f48d` — feat: 升级主题包版本**
- 14:59:45 ｜ 5 文件，+16/−7
- `package.json`/`package-lock.json`；新增 `src/styles/arco-ui/a-switch.less`；调整 `a-tree.less`、`styles/arco-ui/index.less`

### 2026-04-27

**8. `0bd51c12` — feat: 全局类名前缀 gi 改为 g，避免与 Gi 组件冲突**
- 14:00:50 ｜ 58 文件，+153/−154
- 全站样式类名前缀重命名（`gi-*` → `g-*`），横跨 `layout/`、`views/`（home、analyse、crud、detail、file、form、result、system、table、test…）、`components/`、`styles/global.scss`、`stores/useMenuBadgeStore.ts`
- ⚠️冲突预判：与本地改造的 8 个文件重叠 —— `GiCellGender.vue`、`gi-button-demo/index.vue`、`system/dept/index.vue`、`system/dict/DictDataModal/index.vue`、`system/dict/index.vue`、`system/menu/index.vue`、`system/role/index.vue`、`system/user/index.vue`（**冲突面最大的一条**）

**9. `527f80ba` — feat: 优化 GiFlex 组件**
- 14:53:18 ｜ 12 文件，+57/−56
- `GiFlex.vue`、`GiFlex/type.ts`、`styles/global.scss`，以及 10 个使用 GiFlex 的页面适配（crud、detail、form、multi 等）

### 2026-04-28

**10. `32de7111` — feat: 首页、分析页重构**
- 18:58:12 ｜ 33 文件，+1065/−517
- 新增 `components/GiTrend/{GiTrend.vue,index.ts}`；新增分析页组件 `analyse/components/{ContentChart,DataChart}.vue`；新增首页组件 `home/components/{FinishCard,NoticeCard,OverviewCard,ReportCard,TargetCard}.vue`、`avatar-data.ts`
- 删除 `home/components/{ImageCard,ProjectCard}.vue`、`assets/svgs/home-design.svg`、`src/icons/item-*.svg`、`time.svg`
- 重写 `views/home/index.vue`、`views/analyse/index.vue`、`GiIconBox.vue`、`utils/index.ts`
- ⚠️冲突预判：`src/components.d.ts`

### 2026-04-29

**11. `18bec637` — feat: 优化首页、分析页样式**
- 11:59:56 ｜ 19 文件，+195/−92
- 新增 `home/components/TrendCard.vue`，删除 `TargetCard.vue`；调整 `GiTrend.vue`、`global.scss` 及 analyse / home 全部卡片样式；升级依赖

### 2026-04-30

**12. `5de52c06` — feat: 首页样式优化**
- 17:47:40 ｜ 9 文件，+16/−11
- `styles/global.scss`、`layout/components/MenuFoldBtn.vue`、`analyse/index.vue`、home 的 Notice/Overview/Report/Trend/Work 卡片
- ⚠️冲突预判：`src/components.d.ts`

### 2026-05-15

**13. `00fc19db` — feat: 字典管理模块重构**
- 16:02:25 ｜ 9 文件，+332/−211
- 目录结构调整：`dict/DictDataModal/DictDataFormModal.vue` → `dict/DictDataFormModal.vue`（相似度 82% 的移动），删除 `dict/DictDataModal/index.vue`
- 新增 `dict/LeftDictList.vue`；重写 `dict/index.vue`、`dict/DictFormModal.vue`；同步 `src/apis/system/dict.ts` 与 mock（`mock/_data/_type.ts`、`mock/_data/system_dict.ts`、`mock/system/dict.ts`）
- ⚠️冲突预判：与本地改造的 `apis/system/dict.ts`、`dict/DictDataModal/index.vue`、`dict/DictFormModal.vue`、`dict/index.vue` 全部重叠（**字典模块是第二个重灾区**）

### 2026-05-18

**14. `4b62e68f` — feat: 字典管理新增启用禁用过滤，字典数据项新增颜色属性**
- 15:40:36 ｜ 7 文件，+96/−41
- 新增 `styles/arco-ui/a-color-picker.less`；`DictDataFormModal.vue` 增加颜色属性；`LeftDictList.vue`、`dict/index.vue` 增加启用/禁用过滤；`mock/_data/system_dict.ts`
- ⚠️冲突预判：`.vscode/settings.json`、`dict/index.vue`

**15. `11af1832` — feat: GiTableSetting 组件封装和使用示例**
- 17:35:10 ｜ 8 文件，+579
- 新增 `components/GiTableSetting/{GiTableSetting.vue,index.ts,type.ts,useTableColumnSetting.ts}`，新增示例页 `views/table/custom3/index.vue`，更新 mock 菜单与 `components.d.ts`、`components/index.ts`
- ⚠️冲突预判：`src/components.d.ts`

**16. `453a72db` — feat: 去除表格自定义加载图标**
- 18:06:05 ｜ 1 文件，+2/−2
- `src/App.vue`

### 2026-05-19

**17. `4e796030` — feat: 提供 skills 文件**
- 14:43:26 ｜ 7 文件，+467/−1
- 新增 `.cursor/skills/{api-mock,crud-page,project}/SKILL.md`；新增 `styles/arco-ui/a-radio.less`；`src/types/tool.ts` 重命名为 `tool.d.ts`；调整 `LeftDictList.vue`

### 2026-05-20

**18. `3c29526f` — feat: 登录页改造**
- 11:17:22 ｜ 4 文件，+324/−40
- 新增 `views/login/LoginLeft.vue`；删除 `assets/images/login-bg.jpg`；重写 `views/login/index.vue`
- ⚠️冲突预判：`.vscode/settings.json`、`views/login/index.vue`

**19. `e8264f07` — feat: 登录页调色板组件**
- 14:29:30 ｜ 3 文件，+156/−52
- 新增 `views/login/LoginPalette.vue`；调整 `LoginLeft.vue`、`login/index.vue`
- ⚠️冲突预判：`views/login/index.vue`

### 2026-05-26

**20. `a11bb0ee` — Update useRouteStore.ts**
- 14:19:36 ｜ 1 文件，+1/−1
- `src/stores/useRouteStore.ts` 单行修正

### 2026-05-29

**21. `7bc99e06` — feat: 优化页签，优化代码**
- 17:38:11 ｜ 21 文件，+243/−258
- 多布局改造：`layout/Layout{Columns,Default,Mix,Top}.vue`、`layout/components/{Asider,Main,Tabs,OneLevelMenu,MenuFoldBtn}.vue`、`SettingDrawerPanel.vue`
- 逻辑层：`layout/hooks/{useLevelMenu,useMenu}.ts`、`router/guard/setupPermissionGuard.ts`、`stores/{useAppStore,useRouteStore,useUserStore}.ts`、`types/app.d.ts`、`config/setting.json`、`apis/user/{index.ts,type.ts}`
- ⚠️冲突预判：`apis/user/index.ts`、`apis/user/type.ts`、`stores/useUserStore.ts`

### 2026-06-01

**22. `0db137b6` — feat: 首页分析页回归调整**
- 10:06:00 ｜ 20 文件，+457/−1022
- 回退/重做上一轮首页分析页改造：删除 `analyse/components/{ContentChart,DataChart}.vue`、`home/components/{FinishCard,NoticeCard,OverviewCard,ReportCard,TrendCard}.vue`；恢复 `home/components/{ImageCard,ProjectCard}.vue` 与 `assets/svgs/home-design.svg`；调整 `GiTrend.vue`、`global.scss`、`analyse/index.vue`、`home/index.vue`

### 2026-06-02

**23. `bc7ae2d8` — feat: 迁移 Iconify 自定义图标并优化文件模块与项目配置**
- 10:18:03 ｜ 71 文件，+395/−612
- **体量最大的一条**：删除 `src/icons/*.svg`（约 30 个）、`components/GiSvgIcon/*`、`components/icons/Icon{Borders,TableSize,TreeAdd,TreeReduce}.vue`；改为 Iconify 自定义图标集，新增 `src/icons/custom-icons.json`、`src/icons/index.ts`
- 升级 `package.json`、`vite.config.ts`（Iconify 相关）；适配文件管理模块全部文件（`views/file/main/**`）、`layout/components/{Menu/MenuIcon.vue,HeaderRightBar/*,Tabs/index.vue}`、`stores/useAppStore.ts`、`main.ts`、`crud/main/CateTree.vue`、`form/step/Step1.vue`、`home/**`、`.cursorrules`
- ⚠️冲突预判：`src/components.d.ts`、`views/file/components/FileMoveModal/ModalContent.vue`

**24. `0c63c4bf` — feat: 重构登录页布局与品牌展示**
- 11:36:03 ｜ 2 文件，+354/−230
- `views/login/LoginLeft.vue`、`views/login/index.vue`
- ⚠️冲突预判：`views/login/index.vue`

**25. `37cac780` — docs: 新增 AGENTS.md 作为 AI 编码助手项目指南**
- 16:50:36 ｜ 2 文件，+155/−18
- 新增 `AGENTS.md`；`src/components.d.ts`
- ⚠️冲突预判：`src/components.d.ts`

### 2026-06-12

**26. `d1e310aa` — refactor: 将 AI 规范迁移至 .agents 目录**
- 11:57:35 ｜ 11 文件，+535/−257
- 新增 `.agents/README.md`、`.agents/rules/{agent-behavior,coding-standards,css,vue}.md`
- `.cursor/skills/{api-mock,crud-page}/SKILL.md` → `.agents/skills/*`（100% 移动），`.cursor/skills/project/SKILL.md` → `.agents/skills/project/SKILL.md`（改写），删除 `.cursorrules`；更新 `AGENTS.md`

### 2026-06-15（最新）

**27. `61df64cc` — refactor(agents): 重构 AI 规范为常驻规则与分层 skills**
- 09:52:39 ｜ 14 文件，+377/−446
- `.agents/rules/agent-behavior.md` → `agent.md`；删除 `coding-standards.md`、`css.md`、`vue.md`（内容合并进常驻规则）
- 新增分层 skills：`code-css`、`code-ts`、`code-vue`、`git-commit`
- 重命名：`api-mock` → `project-api`、`crud-page` → `project-crud`、`project` → `project-guide`；更新 `AGENTS.md`、`.agents/README.md`

---

## 三、冲突预判汇总

26 个待同步提交中，**有 14 个触碰了本地已改造的文件**，冲突文件合计 14 个：

| 冲突文件 | 相关远程提交数 |
|---|---|
| `src/components.d.ts` | 7（e4c51ad3 / 32de7111 / 5de52c06 / 11af1832 / bc7ae2d8 / 37cac780 …） |
| `src/views/system/dict/index.vue` | 3（0bd51c12 / 00fc19db / 4b62e68f） |
| `.vscode/settings.json` | 3（884e8d9d / 4b62e68f / 3c29526f） |
| `src/views/login/index.vue` | 3（3c29526f / e8264f07 / 0c63c4bf） |
| `src/apis/system/dict.ts` | 1（00fc19db） |
| `src/views/system/dict/DictFormModal.vue` | 1（00fc19db） |
| `src/views/system/dict/DictDataModal/index.vue` | 1（00fc19db，远程已删除该文件） |
| `src/views/system/role/index.vue` | 1（0bd51c12） |
| `src/views/system/user/index.vue` | 1（0bd51c12） |
| `src/views/system/menu/index.vue` | 1（0bd51c12） |
| `src/views/system/dept/index.vue` | 1（0bd51c12） |
| `src/views/demo/examples/gi-button-demo/index.vue` | 1（0bd51c12） |
| `src/components/GiCell/GiCellGender.vue` | 1（0bd51c12） |
| `src/stores/useUserStore.ts`、`src/apis/user/{index,type}.ts` | 1（7bc99e06） |
| `src/views/file/components/FileMoveModal/ModalContent.vue` | 1（bc7ae2d8） |

另外还有两类结构性冲突：
- 远程 `00fc19db` 删除了 `dict/DictDataModal/index.vue`，而本地改造过该文件；
- 远程 `00fc19db` 把 `DictDataModal/DictDataFormModal.vue` 移动到了 `dict/` 根目录，而本地也改造过该文件；
- 本地把 `role/RolePermModal.vue` 换成了 `role/components/` 下的 3 个组件。

---

## 四、同步执行结果（已完成）

**采用的策略：建立独立仓库 + 保留本地改造（合并式）；父仓库暂不处理。**

### 4.1 执行步骤

1. 备份本地目录到 `/tmp/gi_demo_admin_backup_before_sync/gi_demo_admin_local.tar.gz`（19 MB，不含 `node_modules`）
2. 在 `gi_demo_admin` 内 `git init -b master`，添加 remote `origin = https://gitee.com/lin0716/gi-demo.git`，`git fetch`
3. 把分支指向远程基点 `f137b5e4`，使工作区相对基点呈现本地改造（46 改 / 1 删 / 5 新增）
4. 将 **403 个文件的权限位由 755 规范化为 644**（远程 gi-demo 中不存在任何可执行文件，原来的 755 是复制时带入的噪音），使差异面从 421 个降到 47 个
5. 提交本地改造基线 → `25c68363`
6. `git merge origin/master`（26 个提交）→ 产生 11 处冲突
7. 逐个冲突解决（见 4.2）
8. 提交合并 → `305873e2`

### 4.2 冲突解决决策

| 冲突文件 | 处理方式 |
|---|---|
| `.vscode/settings.json` | cSpell 词表取并集（结果与上游一致） |
| `src/components/GiCell/GiCellGender.vue` | 采用上游（字符串性别值 `'1'` + `g-round` 类名） |
| `src/views/demo/examples/gi-button-demo/index.vue` | 采用上游（`gi-*` → `g-*` 类名） |
| `src/views/login/index.vue` | **保留本地** `Regexp.StrongPassword` 校验规则 |
| `src/views/system/menu/MenuFormModal.vue` | 采用上游 iconpark 重构（去掉 `iconType`），保留本地 `visible` 字段 |
| `src/views/system/role/index.vue` | **保留本地角色管理重构**，残留 `gi-*` 类名改为 `g-*` |
| `src/stores/useUserStore.ts` | 采用上游架构（完整 `UserInfo` / `getUserRoutes`），补回本地 `encryptPassword`、`refreshToken`、`tenantId` 与「角色不自动赋 admin」逻辑 |
| `src/apis/system/dict.ts` | 采用上游重构 |
| `src/views/system/dict/index.vue` | 采用上游重构 |
| `src/views/system/dict/DictDataFormModal.vue` | 采用上游重构 |
| `src/views/system/dict/DictDataModal/index.vue` | 接受上游删除（`UD`） |
| `src/views/system/dict/DictFormModal.vue` | 采用上游重构（该文件无冲突，但为保持模块一致而整体切换到上游） |

> 说明：`逐块选择` 在字典模块的 3 个文件上不可行 —— 合并后的非冲突区域已是上游新版结构，而本地冲突块是旧版设计残留，单独选任一侧都会留下未定义变量（例如 `DictDataFormModal.vue` 的 `save()` 来自本地、使用 `dictCode.value`，而 `title`/`close()` 来自上游、使用 `dictTypeCode`）。因此这三个文件整文件定为上游。

### 4.3 结果校验

- 冲突标记：全仓无残留
- 字典模块 6 个文件与上游 `master` 逐字节一致
- 历史：`git rev-list --left-right --count origin/master...HEAD` → `0 2`，即**上游 26 个提交已全部进入本地历史**，本地仅多出「基线提交 + 合并提交」两笔（追加图标恢复提交 `0390eb0d` 后为 `0 3`）
- 合并后相对上游仍有差异的文件：**44 个**（5 新增 / 1 删除 / 38 修改），全部是本地分支的既有改造
- 导入可解析性扫描：552 个本地导入中 0 个真实断链（24 条为 Vite `?raw` 误报）

### 4.4 遗留问题（本地分支既有，非本次合并引入）

1. **`Status` / `Gender` 类型体系数字与字符串混用**
   - 本地把 `src/types/global.d.ts` 改成了数字：`type Status = 0 | 1`、`type Gender = 1 | 2 | 3`
   - 但 `src/views/crud/form/index.vue`、`src/views/form/custom/components/Card2/4/5.vue` 仍用字符串 `'1' as Status`、`'1' as Gender`（这些文件本地未改）
   - `src/components/GiCell/GiCellStatus.vue` 仍是本地的**数字**比较（`status === 1`），而合并后 mock 数据是字符串（`status: '1'`）→ 状态标签在 mock 下渲染不出来
   - 建议：统一为字符串（与上游/字典一致）或统一为数字，并同步修改调用点

2. **字典码不一致**：本地 `system/user`、`system/menu`、`system/dept` 页面使用 `useDict(['common_status'])`，而 mock 中只有 `STATUS` / `GENDER` → 这些页面的状态列在 mock 下为空。本地分支应是对接真实后端，需要确认后端确实提供 `common_status`

3. **父仓库噪音**：`gi_demo_admin` 现在是独立仓库，父仓库 `flutter_web_admin` 的 `git status` 多出 433 条记录（340 修改 / 75 删除 / 若干未跟踪）。按你的选择**父仓库暂未处理**。若想清理，可在父仓库执行：
   ```
   echo "gi_demo_admin/" >> .gitignore
   git rm -r --cached gi_demo_admin
   ```

4. ~~**依赖未安装完整**~~：后续确认 `node_modules` 中 `vite@7.3.1`、`vue-tsc`、`@iconify/vue`、`@iconify-json/icon-park-outline`、`unplugin-vue-components` 等均已就位，已具备构建条件（见 §6 的构建验证结果）。

---

## 五、菜单图标回归本地彩色方案（已完成）

**背景**：上游 `11d68ac5` / `bc7ae2d8` 删除了 `vite-plugin-svg-icons` + `virtual:svg-icons-register` + `GiSvgIcon` 的 SVG Sprite 体系，改为 Iconify（默认 `icon-park-outline`）。但菜单数据里的裸名图标（`menu-analyse`、`menu-home` 等）既没有集合前缀、也不以 `icon` 开头，`MenuIcon.vue` 的判定条件识别不到 → **菜单图标整片消失**。

**目标**：沿用上游最新的 Iconify 机制，同时恢复本地之前的彩色图标效果（不重新引入旧依赖）。

### 5.1 改动内容（提交 `0390eb0d`）

| 文件 | 改动 |
|---|---|
| `src/icons/custom-icons.json` | 追加 **19 个**本地彩色 SVG（18 个 `menu-*` + `arco` + `vite`），逐个转成 Iconify collection 条目（含 `width`/`height`/`body`），**保留原始 `fill` 颜色**。集合由 38 个增至 **57 个** |
| `src/layout/components/Menu/MenuIcon.vue` | 新增「裸名兜底」分支：把无前缀、不以 `icon` 开头的值映射为 `custom:<name>`，并以 **24px** 渲染（与旧版 `GiSvgIcon` 的 `:size="24"` 一致）；显式 `custom:` 与 `icon-park` 走 16px 分支；Arco 组件走 `component :is` |
| `mock/_data/system_menu.ts` | 还原 **18 个父级菜单**图标为裸名；并把上游改动的 `/detail/base`、`/detail/general` 由 `bookmark-one` 还原为 `newspaper-folding` |
| `src/router/index.ts` | 首页图标由 `icon-park-outline:workbench` 还原为 `menu-home` |

### 5.2 为什么"父级彩色、子级 icon-park"是正确形态

本地基线（`25c68363`）的菜单数据本身就是这个结构，并非全部裸名：

- **父级（一级）菜单** → 本地彩色图标：`menu-analyse`、`menu-crud`、`menu-form`、`menu-table`、`menu-layout`、`menu-error`、`menu-result`、`menu-system`、`menu-test`、`menu-example`、`menu-multi`、`menu-about`、`menu-document`、`menu-detail`、`menu-gitee`、`arco`、`vite`
- **子级菜单** → `icon-park-outline:*`：`notes`、`table-file`、`layout-three`、`bug`、`report`、`setting-config`、`protect`、`connection-point`、`newspaper-folding`

因此本次只恢复"被上游换掉的父级图标"，子级保持 icon-park 不动 —— 与基线**逐路径一致**。

### 5.3 校验结果

| 校验项 | 结果 |
|---|---|
| `custom-icons.json` 完整性 | `prefix=custom`，57 个图标，19 个所需图标全部存在且 `body` 非空 |
| 菜单图标 vs 本地基线 | 共同路径 **61 条，0 条不一致**；上游新增页 `/table/custom3`（"配置化表格2"）保留其 `table-file`（基线中本无此页） |
| `system_menu.ts` 语法 | 去类型后 Node 解析通过，顶层节点 15 个 |
| 图标注册链路 | `main.ts` → `@/icons/index` → `addCollection(CustomIcons)` 完整；`GiIconSelector` 的 **Custom** 页签自动包含新增的 19 个图标 |
| 图标渲染入口 | 全仓菜单图标均经 `MenuIcon.vue`（`MenuItem.vue` / `OneLevelMenu/index.vue` / `views/system/menu/index.vue`），无遗漏渲染点 |
| **生产构建** | **`npm run build` 通过**（1184 modules transformed；详见 §6.2） |

---

## 六、新发现：构建阻断（`login-bg.jpg` 缺失）

### 6.1 问题

首次执行 `npm run build` 时在 CSS 阶段报错：

```
[vite:css] [postcss] ENOENT: no such file or directory,
  open '.../src/assets/images/login-bg.jpg'
file: src/views/login/index.vue?vue&type=style&index=0&...&lang.scss
```

全量扫描 `src` 下所有资源引用后确认：**全项目仅此 1 处引用缺失文件**（引用 6 处、缺失 1 处）。

> 注：`pnpm dev` 下 Vite 通常只报 404/告警而不中断，所以本地开发可能"看起来正常"，但**打包必然失败**。

### 6.2 根因

| 事实 | 说明 |
|---|---|
| `f137b5e4`（基点）与 `25c68363`（本地基线）中该图片**存在** | 由上游 `5dcaf463 feat: 登录页重构` 新增、`d15c991b feat: 修改登录页背景图` 修改 |
| 上游 `origin/master` 中该图片**不存在** | 上游 `3c29526f feat: 登录页改造` 删除了它，并把登录页重写为 `LoginLeft.vue` + `LoginPalette.vue` 的左右分栏结构（改用 `logo.gif`） |
| 本次合并的结果 | 对 `src/views/login/index.vue` 冲突**保留了本地版**（含 `Regexp.StrongPassword` 校验），但该文件的删除动作被合并干净地接受了 → 留下"本地登录页 + 上游删掉的图片" |

**连带现象**：上游的 `src/views/login/LoginLeft.vue`（+272 行）与 `LoginPalette.vue`（+100 行）已随合并进入本地仓库，但当前本地版 `index.vue` 并未引用它们 → **这两个文件目前是死代码**。

### 6.3 验证结论

把 `login-bg.jpg` 从历史临时取出后重跑 `npm run build` → **构建通过**。随后已将该临时文件与 `dist/` 一并清除，仓库回到提交 `0390eb0d` 的干净状态。

### 6.4 待你决策的三个选项

| 选项 | 做法 | 影响 |
|---|---|---|
| **A（推荐）** | `git checkout 25c68363 -- src/assets/images/login-bg.jpg` 恢复该图片 | 1.2 MB 二进制入库；完全保留本地登录页外观；与"保留本地改造"的既定策略一致 |
| **B** | 改用上游登录页：`src/views/login/index.vue` 换成上游版（走 `LoginLeft`/`LoginPalette`），并保留本地 `Regexp.StrongPassword` 规则 | 丢弃本地登录页外观；`LoginLeft`/`LoginPalette` 从此不再是死代码；无需二进制资源 |
| **C** | 仅删掉 `index.vue` 第 126 行的 `background-image` | 改动最小；登录页左侧背景变纯色，视觉有损失 |

---
