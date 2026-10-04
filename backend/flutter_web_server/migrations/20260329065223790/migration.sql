BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "air_table_fields" (
    "id" bigserial PRIMARY KEY,
    "field" text NOT NULL,
    "tablesId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "air_table_items" (
    "id" bigserial PRIMARY KEY,
    "value" text NOT NULL,
    "rowId" bigint NOT NULL,
    "fieldId" bigint NOT NULL,
    "itemId" bigint,
    "tablesId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "air_table_rows" (
    "id" bigserial PRIMARY KEY,
    "index" bigint NOT NULL,
    "tablesId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "air_tables" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "table_name_unique" ON "air_tables" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
    "categoryId" bigint,
    "name" text NOT NULL,
    "isbn" text,
    "author" text NOT NULL DEFAULT ''::text,
    "keyword" text NOT NULL DEFAULT ''::text,
    "publisher" text NOT NULL DEFAULT ''::text,
    "image" text NOT NULL DEFAULT ''::text,
    "originalPrice" double precision NOT NULL,
    "isDeleted" boolean NOT NULL DEFAULT false,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "book_unique" ON "book" USING btree ("isbn", "name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_category" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
    "name" text NOT NULL,
    "description" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_inventory_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
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
-- ACTION CREATE TABLE
--
CREATE TABLE "book_package" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
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
-- ACTION CREATE TABLE
--
CREATE TABLE "book_package_item" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
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
-- ACTION CREATE TABLE
--
CREATE TABLE "book_sale" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
    "bookId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "salePrice" double precision NOT NULL,
    "saleTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "infra_file_config" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "storage" bigint NOT NULL,
    "description" text,
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_api" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "path" text NOT NULL,
    "method" text NOT NULL,
    "description" text,
    "status" bigint DEFAULT 1,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "sys_api_path_method_tenant_unique" ON "sys_api" USING btree ("path", "method");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_dept" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "parentId" bigint DEFAULT 0,
    "name" text,
    "sort" bigint,
    "status" bigint,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "sys_dept_name_parent_unique" ON "sys_dept" USING btree ("tenantId", "parentId", "name");
CREATE INDEX "sys_dept_tenant_parent_deleted_idx" ON "sys_dept" USING btree ("tenantId", "parentId", "deleted");
CREATE INDEX "sys_dept_tenant_deleted_status_idx" ON "sys_dept" USING btree ("tenantId", "deleted", "status");
CREATE INDEX "sys_dept_tenant_name_deleted_idx" ON "sys_dept" USING btree ("tenantId", "name", "deleted");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_dict_code" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint DEFAULT 0,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "status" bigint NOT NULL,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_dict_code_unique" ON "sys_dict_code" USING btree ("code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_dict_data" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "value" text NOT NULL,
    "color" text,
    "sort" bigint NOT NULL,
    "status" bigint NOT NULL,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_dict_data_name_code_unique" ON "sys_dict_data" USING btree ("name", "code");
CREATE UNIQUE INDEX "sys_dict_data_value_code_unique" ON "sys_dict_data" USING btree ("value", "code");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "description" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_mail_template_code_unique" ON "sys_mail_template" USING btree ("code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_menu" (
    "id" bigserial PRIMARY KEY,
    "parentId" bigint NOT NULL DEFAULT 0,
    "type" bigint NOT NULL,
    "title" text NOT NULL,
    "icon" text,
    "permission" text NOT NULL DEFAULT ''::text,
    "path" text DEFAULT ''::text,
    "redirect" text,
    "component" text,
    "componentName" text,
    "activeMenu" text,
    "sort" bigint NOT NULL DEFAULT 0,
    "status" bigint NOT NULL DEFAULT 1,
    "breadcrumb" boolean NOT NULL DEFAULT true,
    "visible" boolean NOT NULL DEFAULT true,
    "keepAlive" boolean NOT NULL DEFAULT true,
    "alwaysShow" boolean NOT NULL DEFAULT true,
    "showInTabs" boolean NOT NULL DEFAULT true,
    "affix" boolean NOT NULL DEFAULT false,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_menu_title_parent_unique" ON "sys_menu" USING btree ("title", "parentId");
CREATE UNIQUE INDEX "sys_menu_permission_unique" ON "sys_menu" USING btree ("permission");
CREATE INDEX "sys_menu_parent_sort_idx" ON "sys_menu" USING btree ("parentId", "sort");
CREATE INDEX "sys_menu_status_idx" ON "sys_menu" USING btree ("status");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "description" text,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_notify_template_code_unique" ON "sys_notify_template" USING btree ("code");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_post" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "sort" bigint NOT NULL,
    "status" bigint NOT NULL,
    "description" text,
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_role" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "sort" bigint NOT NULL,
    "type" bigint NOT NULL,
    "dataScope" bigint NOT NULL DEFAULT 5,
    "dataScopeDeptIds" json,
    "menus" json,
    "apis" json,
    "description" text,
    "status" bigint NOT NULL,
    "deleted" boolean NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_name_tenant_unique" ON "sys_role" USING btree ("name", "tenantId");
CREATE UNIQUE INDEX "sys_role_code_tenant_unique" ON "sys_role" USING btree ("code", "tenantId");
CREATE INDEX "sys_role_tenant_deleted_idx" ON "sys_role" USING btree ("tenantId", "deleted");
CREATE INDEX "sys_role_tenant_status_idx" ON "sys_role" USING btree ("tenantId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_role_menu" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "roleId" bigint NOT NULL,
    "menuId" bigint NOT NULL,
    "deleted" boolean NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_menu_unique" ON "sys_role_menu" USING btree ("roleId", "menuId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_sms_channel" (
    "id" bigserial PRIMARY KEY,
    "signature" text NOT NULL,
    "code" text NOT NULL,
    "status" bigint NOT NULL,
    "description" text,
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_sms_template" (
    "id" bigserial PRIMARY KEY,
    "type" bigint NOT NULL,
    "status" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "content" text NOT NULL,
    "params" text NOT NULL,
    "description" text,
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_tenant_package" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" bigint NOT NULL,
    "description" text,
    "menuIds" text NOT NULL,
    "creator" text NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_user" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "deptId" bigint,
    "postIds" json,
    "username" text NOT NULL,
    "password" text,
    "authUserId" uuid,
    "nickname" text NOT NULL,
    "phone" text,
    "gender" bigint DEFAULT 3,
    "email" text,
    "avatar" text,
    "description" text,
    "status" bigint DEFAULT 1,
    "isSuperuser" boolean NOT NULL DEFAULT false,
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
CREATE UNIQUE INDEX "sys_user_auth_user_unique" ON "sys_user" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_user_role" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL,
    "deleted" boolean NOT NULL,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "sys_user_role_unique" ON "sys_user_role" USING btree ("roleId", "userId");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
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
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "nonce", "attemptedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "air_table_fields"
    ADD CONSTRAINT "air_table_fields_fk_0"
    FOREIGN KEY("tablesId")
    REFERENCES "air_tables"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "air_table_items"
    ADD CONSTRAINT "air_table_items_fk_0"
    FOREIGN KEY("rowId")
    REFERENCES "air_table_rows"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "air_table_items"
    ADD CONSTRAINT "air_table_items_fk_1"
    FOREIGN KEY("fieldId")
    REFERENCES "air_table_fields"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "air_table_items"
    ADD CONSTRAINT "air_table_items_fk_2"
    FOREIGN KEY("itemId")
    REFERENCES "air_table_items"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "air_table_items"
    ADD CONSTRAINT "air_table_items_fk_3"
    FOREIGN KEY("tablesId")
    REFERENCES "air_tables"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "air_table_rows"
    ADD CONSTRAINT "air_table_rows_fk_0"
    FOREIGN KEY("tablesId")
    REFERENCES "air_tables"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sys_user"
    ADD CONSTRAINT "sys_user_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260329065223790', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329065223790', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
