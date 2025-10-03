BEGIN;

--
-- Class Book as table book
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "isbn" text,
    "author" text NOT NULL DEFAULT ''::text,
    "keyword" text NOT NULL DEFAULT ''::text,
    "publisher" text NOT NULL DEFAULT ''::text,
    "image" text NOT NULL DEFAULT ''::text,
    "originalPrice" double precision NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false,
    "categoryId" bigint
);

-- Indexes
CREATE UNIQUE INDEX "book_unique" ON "book" USING btree ("isbn", "name");

--
-- Class BookCategory as table book_category
--
CREATE TABLE "book_category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- Class BookInventoryLog as table book_inventory_log
--
CREATE TABLE "book_inventory_log" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "changeType" bigint NOT NULL,
    "changeTime" timestamp without time zone NOT NULL,
    "description" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- Class BookPackage as table book_package
--
CREATE TABLE "book_package" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text,
    "contentDescription" text NOT NULL DEFAULT ''::text,
    "originalPrice" double precision NOT NULL,
    "discountRate" double precision NOT NULL DEFAULT 1.0,
    "salePrice" double precision NOT NULL,
    "status" bigint NOT NULL DEFAULT 0,
    "startTime" timestamp without time zone,
    "endTime" timestamp without time zone,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "package_name_unique" ON "book_package" USING btree ("name");

--
-- Class BookPackageItem as table book_package_item
--
CREATE TABLE "book_package_item" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "packageId" bigint NOT NULL,
    "quantity" bigint NOT NULL DEFAULT 1,
    "packagePrice" double precision NOT NULL,
    "originalPrice" double precision NOT NULL,
    "discountRate" double precision NOT NULL DEFAULT 1.0,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "book_package_unique" ON "book_package_item" USING btree ("bookId", "packageId");

--
-- Class BookSale as table book_sale
--
CREATE TABLE "book_sale" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "salePrice" double precision NOT NULL,
    "saleTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- Class Customer as table customer
--
CREATE TABLE "customer" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL DEFAULT ''::text,
    "password" text NOT NULL DEFAULT ''::text,
    "nickname" text NOT NULL DEFAULT ''::text,
    "phone" text NOT NULL DEFAULT ''::text,
    "email" text NOT NULL DEFAULT ''::text,
    "status" bigint NOT NULL DEFAULT 0,
    "memberLevel" bigint NOT NULL DEFAULT 0,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "customer_unique" ON "customer" USING btree ("userName");

--
-- Class InfraApiAccessLog as table infra_api_access_log
--
CREATE TABLE "infra_api_access_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "traceId" text NOT NULL,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "applicationName" text NOT NULL,
    "requestMethod" text NOT NULL,
    "requestUrl" text NOT NULL,
    "requestParams" text,
    "responseBody" text,
    "userIp" text NOT NULL,
    "userAgent" text NOT NULL,
    "operateModule" text,
    "operateName" text,
    "operateType" bigint NOT NULL,
    "beginTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone NOT NULL,
    "duration" bigint NOT NULL,
    "resultCode" bigint NOT NULL,
    "resultMsg" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class InfraApiErrorLog as table infra_api_error_log
--
CREATE TABLE "infra_api_error_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "traceId" text NOT NULL,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "applicationName" text NOT NULL,
    "requestMethod" text NOT NULL,
    "requestUrl" text NOT NULL,
    "requestParams" text NOT NULL,
    "userIp" text NOT NULL,
    "userAgent" text NOT NULL,
    "exceptionTime" timestamp without time zone NOT NULL,
    "exceptionName" text NOT NULL,
    "exceptionMessage" text NOT NULL,
    "exceptionRootCauseMessage" text NOT NULL,
    "exceptionStackTrace" text NOT NULL,
    "exceptionClassName" text NOT NULL,
    "exceptionFileName" text NOT NULL,
    "exceptionMethodName" text NOT NULL,
    "exceptionLineNumber" bigint NOT NULL,
    "processStatus" bigint NOT NULL,
    "processTime" timestamp without time zone,
    "processUserId" bigint,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class InfraFile as table infra_file
--
CREATE TABLE "infra_file" (
    "id" bigserial PRIMARY KEY,
    "configId" bigint,
    "name" text,
    "path" text NOT NULL,
    "url" text NOT NULL,
    "type" text,
    "size" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class InfraFileConfig as table infra_file_config
--
CREATE TABLE "infra_file_config" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "storage" bigint NOT NULL,
    "remark" text,
    "master" boolean NOT NULL,
    "config" text NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "infra_file_config_name_unique" ON "infra_file_config" USING btree ("name");

--
-- Class InfraFileContent as table infra_file_content
--
CREATE TABLE "infra_file_content" (
    "id" bigserial PRIMARY KEY,
    "configId" bigint NOT NULL,
    "path" text NOT NULL,
    "content" bytea NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class InfraJob as table infra_job
--
CREATE TABLE "infra_job" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" bigint NOT NULL,
    "handlerName" text NOT NULL,
    "handlerParam" text,
    "cronExpression" text NOT NULL,
    "retryCount" bigint NOT NULL,
    "retryInterval" bigint NOT NULL,
    "monitorTimeout" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class InfraJobLog as table infra_job_log
--
CREATE TABLE "infra_job_log" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "handlerName" text NOT NULL,
    "handlerParam" text,
    "executeIndex" bigint NOT NULL,
    "beginTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone,
    "duration" bigint,
    "status" bigint NOT NULL,
    "result" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class Qimen as table qimen_history
--
CREATE TABLE "qimen_history" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "panTime" timestamp without time zone NOT NULL,
    "method" text NOT NULL,
    "dunType" text NOT NULL,
    "juShu" bigint NOT NULL,
    "question" text NOT NULL,
    "analysis" text NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class Region as table region
--
CREATE TABLE "region" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text,
    "pinyin" text NOT NULL DEFAULT ''::text,
    "parentId" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "region_unique" ON "region" USING btree ("parentId", "name");

--
-- Class Store as table store
--
CREATE TABLE "store" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "logo" text,
    "address" text,
    "contact" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- Class StoreActivity as table store_activity
--
CREATE TABLE "store_activity" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "name" text NOT NULL,
    "address" text NOT NULL,
    "description" text NOT NULL,
    "startTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "store_activity_unique" ON "store_activity" USING btree ("storeId");

--
-- Class StoreActivityBook as table store_activity_book
--
CREATE TABLE "store_activity_book" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "activityId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "discountPrice" double precision NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "store_activity_book_unique" ON "store_activity_book" USING btree ("storeId", "activityId", "bookId");

--
-- Class StoreBook as table store_book
--
CREATE TABLE "store_book" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "purchasePrice" double precision NOT NULL,
    "salePrice" double precision NOT NULL,
    "discountPrice" double precision NOT NULL,
    "inventory" bigint NOT NULL DEFAULT 0,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "store_book_unique" ON "store_book" USING btree ("storeId", "bookId");

--
-- Class StoreSalesRecord as table store_sales_record
--
CREATE TABLE "store_sales_record" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "saleType" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "bookPackageId" bigint NOT NULL,
    "salesCount" bigint NOT NULL,
    "salePrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "discountPrice" double precision NOT NULL,
    "paymentPrice" double precision NOT NULL,
    "activityId" bigint NOT NULL,
    "saleTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- Class SysDept as table sys_dept
--
CREATE TABLE "sys_dept" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "parentId" bigint NOT NULL,
    "sort" bigint NOT NULL,
    "leaderUserId" bigint,
    "phone" text,
    "email" text,
    "status" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_dept_name_parent_unique" ON "sys_dept" USING btree ("name", "parentId");

--
-- Class SysDictData as table sys_dict_data
--
CREATE TABLE "sys_dict_data" (
    "id" bigserial PRIMARY KEY,
    "sort" bigint NOT NULL,
    "label" text NOT NULL,
    "value" text NOT NULL,
    "dictType" text NOT NULL,
    "status" bigint NOT NULL,
    "colorType" text,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_dict_data_label_type_unique" ON "sys_dict_data" USING btree ("label", "dictType");
CREATE UNIQUE INDEX "sys_dict_data_value_type_unique" ON "sys_dict_data" USING btree ("value", "dictType");

--
-- Class SysDictType as table sys_dict_type
--
CREATE TABLE "sys_dict_type" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "status" bigint NOT NULL,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL,
    "deletedTime" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "sys_dict_type_unique" ON "sys_dict_type" USING btree ("type");

--
-- Class SysLoginLog as table sys_login_log
--
CREATE TABLE "sys_login_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "logType" bigint NOT NULL,
    "traceId" text NOT NULL,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "username" text NOT NULL,
    "result" bigint NOT NULL,
    "userIp" text NOT NULL,
    "userAgent" text NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysMailAccount as table sys_mail_account
--
CREATE TABLE "sys_mail_account" (
    "id" bigserial PRIMARY KEY,
    "mail" text NOT NULL,
    "username" text NOT NULL,
    "password" text NOT NULL,
    "host" text NOT NULL,
    "port" bigint NOT NULL,
    "sslEnable" boolean NOT NULL,
    "starttlsEnable" boolean NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_mail_account_mail_unique" ON "sys_mail_account" USING btree ("mail");

--
-- Class SysMailLog as table sys_mail_log
--
CREATE TABLE "sys_mail_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "userType" bigint,
    "toMail" text NOT NULL,
    "accountId" bigint NOT NULL,
    "fromMail" text NOT NULL,
    "templateId" bigint NOT NULL,
    "templateCode" text NOT NULL,
    "templateNickname" text,
    "templateTitle" text NOT NULL,
    "templateContent" text NOT NULL,
    "templateParams" text NOT NULL,
    "sendStatus" bigint NOT NULL,
    "sendTime" timestamp without time zone,
    "sendMessageId" text,
    "sendException" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysMailTemplate as table sys_mail_template
--
CREATE TABLE "sys_mail_template" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "accountId" bigint NOT NULL,
    "nickname" text,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "params" text NOT NULL,
    "status" bigint NOT NULL,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_mail_template_code_unique" ON "sys_mail_template" USING btree ("code");

--
-- Class SysMenu as table sys_menu
--
CREATE TABLE "sys_menu" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "permission" text NOT NULL DEFAULT ''::text,
    "type" bigint NOT NULL,
    "sort" bigint NOT NULL DEFAULT 0,
    "parentId" bigint NOT NULL DEFAULT 0,
    "path" text DEFAULT ''::text,
    "icon" text,
    "component" text,
    "componentName" text,
    "status" bigint NOT NULL DEFAULT 0,
    "visible" boolean NOT NULL DEFAULT true,
    "keepAlive" boolean NOT NULL DEFAULT true,
    "alwaysShow" boolean NOT NULL DEFAULT true,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "sys_menu_name_parent_unique" ON "sys_menu" USING btree ("name", "parentId");
CREATE UNIQUE INDEX "sys_menu_permission_unique" ON "sys_menu" USING btree ("permission");

--
-- Class SysNotice as table sys_notice
--
CREATE TABLE "sys_notice" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "type" bigint NOT NULL,
    "status" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysNotifyMessage as table sys_notify_message
--
CREATE TABLE "sys_notify_message" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "templateId" bigint NOT NULL,
    "templateCode" text NOT NULL,
    "templateNickname" text NOT NULL,
    "templateContent" text NOT NULL,
    "templateType" bigint NOT NULL,
    "templateParams" text NOT NULL,
    "readStatus" boolean NOT NULL,
    "readTime" timestamp without time zone,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysNotifyTemplate as table sys_notify_template
--
CREATE TABLE "sys_notify_template" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "nickname" text NOT NULL,
    "content" text NOT NULL,
    "type" bigint NOT NULL,
    "params" text,
    "status" bigint NOT NULL,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_notify_template_code_unique" ON "sys_notify_template" USING btree ("code");

--
-- Class SysOperateLog as table sys_operate_log
--
CREATE TABLE "sys_operate_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "traceId" text NOT NULL,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "type" text NOT NULL,
    "subType" text NOT NULL,
    "bizId" bigint NOT NULL,
    "action" text NOT NULL,
    "success" boolean NOT NULL,
    "extra" text NOT NULL,
    "requestMethod" text,
    "requestUrl" text,
    "userIp" text,
    "userAgent" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysPost as table sys_post
--
CREATE TABLE "sys_post" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "sort" bigint NOT NULL,
    "status" bigint NOT NULL,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_post_code_tenant_unique" ON "sys_post" USING btree ("code", "tenantId");
CREATE UNIQUE INDEX "sys_post_name_tenant_unique" ON "sys_post" USING btree ("name", "tenantId");

--
-- Class SysRole as table sys_role
--
CREATE TABLE "sys_role" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "sort" bigint NOT NULL,
    "dataScope" bigint NOT NULL,
    "dataScopeDeptIds" text,
    "status" bigint NOT NULL,
    "type" bigint NOT NULL,
    "remark" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_name_tenant_unique" ON "sys_role" USING btree ("name", "tenantId");
CREATE UNIQUE INDEX "sys_role_code_tenant_unique" ON "sys_role" USING btree ("code", "tenantId");

--
-- Class SysRoleMenu as table sys_role_menu
--
CREATE TABLE "sys_role_menu" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "roleId" bigint NOT NULL,
    "menuId" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_menu_unique" ON "sys_role_menu" USING btree ("roleId", "menuId");

--
-- Class SysSmsChannel as table sys_sms_channel
--
CREATE TABLE "sys_sms_channel" (
    "id" bigserial PRIMARY KEY,
    "signature" text NOT NULL,
    "code" text NOT NULL,
    "status" bigint NOT NULL,
    "remark" text,
    "apiKey" text NOT NULL,
    "apiSecret" text,
    "callbackUrl" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_sms_channel_code_unique" ON "sys_sms_channel" USING btree ("code");

--
-- Class SysSmsCode as table sys_sms_code
--
CREATE TABLE "sys_sms_code" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "mobile" text NOT NULL,
    "code" text NOT NULL,
    "createIp" text NOT NULL,
    "scene" bigint NOT NULL,
    "todayIndex" bigint NOT NULL,
    "used" bigint NOT NULL,
    "usedTime" timestamp without time zone,
    "usedIp" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysSmsLog as table sys_sms_log
--
CREATE TABLE "sys_sms_log" (
    "id" bigserial PRIMARY KEY,
    "channelId" bigint NOT NULL,
    "channelCode" text NOT NULL,
    "templateId" bigint NOT NULL,
    "templateCode" text NOT NULL,
    "templateType" bigint NOT NULL,
    "templateContent" text NOT NULL,
    "templateParams" text NOT NULL,
    "apiTemplateId" text NOT NULL,
    "mobile" text NOT NULL,
    "userId" bigint,
    "userType" bigint,
    "sendStatus" bigint NOT NULL,
    "sendTime" timestamp without time zone,
    "apiSendCode" text,
    "apiSendMsg" text,
    "apiRequestId" text,
    "apiSerialNo" text,
    "receiveStatus" bigint NOT NULL,
    "receiveTime" timestamp without time zone,
    "apiReceiveCode" text,
    "apiReceiveMsg" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysSmsTemplate as table sys_sms_template
--
CREATE TABLE "sys_sms_template" (
    "id" bigserial PRIMARY KEY,
    "type" bigint NOT NULL,
    "status" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "content" text NOT NULL,
    "params" text NOT NULL,
    "remark" text,
    "apiTemplateId" text NOT NULL,
    "channelId" bigint NOT NULL,
    "channelCode" text NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_sms_template_code_unique" ON "sys_sms_template" USING btree ("code");

--
-- Class SysSocialClient as table sys_social_client
--
CREATE TABLE "sys_social_client" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "socialType" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "clientId" text NOT NULL,
    "clientSecret" text NOT NULL,
    "agentId" text,
    "status" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_social_client_code_unique" ON "sys_social_client" USING btree ("clientId");

--
-- Class SysSocialUser as table sys_social_user
--
CREATE TABLE "sys_social_user" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "type" bigint NOT NULL,
    "openid" text NOT NULL,
    "token" text,
    "rawTokenInfo" text NOT NULL,
    "nickname" text NOT NULL,
    "avatar" text,
    "rawUserInfo" text NOT NULL,
    "code" text NOT NULL,
    "state" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_social_user_openid_unique" ON "sys_social_user" USING btree ("openid");

--
-- Class SysSocialUserBind as table sys_social_user_bind
--
CREATE TABLE "sys_social_user_bind" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "userType" bigint NOT NULL,
    "socialType" bigint NOT NULL,
    "socialUserId" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysTenant as table sys_tenant
--
CREATE TABLE "sys_tenant" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "contactUserId" bigint,
    "contactName" text NOT NULL,
    "contactMobile" text,
    "status" bigint NOT NULL,
    "websites" text,
    "packageId" bigint NOT NULL,
    "expireTime" timestamp without time zone NOT NULL,
    "accountCount" bigint NOT NULL,
    "creator" text NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_tenant_name_unique" ON "sys_tenant" USING btree ("name");

--
-- Class SysTenantPackage as table sys_tenant_package
--
CREATE TABLE "sys_tenant_package" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" bigint NOT NULL,
    "remark" text,
    "menuIds" text NOT NULL,
    "creator" text NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- Class SysUser as table sys_user
--
CREATE TABLE "sys_user" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "deptId" bigint,
    "username" text NOT NULL,
    "phone" text,
    "password" text,
    "nickname" text NOT NULL,
    "gender" bigint NOT NULL,
    "email" text,
    "avatar" text,
    "remark" text,
    "status" bigint NOT NULL,
    "deleted" boolean NOT NULL DEFAULT false,
    "loginIp" text,
    "loginTime" timestamp without time zone,
    "updater" text,
    "updateTime" timestamp without time zone,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "sys_user_username_unique" ON "sys_user" USING btree ("username");
CREATE UNIQUE INDEX "sys_user_phone_unique" ON "sys_user" USING btree ("phone");

--
-- Class SysUserPost as table sys_user_post
--
CREATE TABLE "sys_user_post" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_user_post_unique" ON "sys_user_post" USING btree ("userId", "postId");

--
-- Class SysUserRole as table sys_user_role
--
CREATE TABLE "sys_user_role" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_user_role_unique" ON "sys_user_role" USING btree ("roleId", "userId");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR book_store
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_store', '20251003031800505', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251003031800505', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
