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
-- Class DictItem as table dict_item
--
CREATE TABLE "dict_item" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text,
    "value" text NOT NULL DEFAULT ''::text,
    "sn" bigint NOT NULL DEFAULT 0,
    "disabled" bigint NOT NULL DEFAULT 0,
    "typeId" bigint NOT NULL DEFAULT 0,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "dict_item_name_type_unique" ON "dict_item" USING btree ("name", "typeId");
CREATE UNIQUE INDEX "dict_item_value_type_unique" ON "dict_item" USING btree ("value", "typeId");

--
-- Class DictType as table dict_type
--
CREATE TABLE "dict_type" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text,
    "value" text NOT NULL DEFAULT ''::text,
    "intro" text NOT NULL DEFAULT ''::text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "dict_type_unique" ON "dict_type" USING btree ("name", "value");

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
-- Class RolePermission as table role_permission
--
CREATE TABLE "role_permission" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL,
    "permissionKey" text NOT NULL,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

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
-- Class SysOperationLog as table sys_operation_log
--
CREATE TABLE "sys_operation_log" (
    "id" bigserial PRIMARY KEY,
    "tableNameStr" text NOT NULL DEFAULT ''::text,
    "operationType" bigint NOT NULL DEFAULT 0,
    "recordId" bigint,
    "oldData" text NOT NULL DEFAULT ''::text,
    "newData" text NOT NULL DEFAULT ''::text,
    "operatorId" bigint NOT NULL DEFAULT 0,
    "operationTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class SysResource as table sys_resource
--
CREATE TABLE "sys_resource" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text,
    "uri" text NOT NULL DEFAULT ''::text,
    "permission" text NOT NULL DEFAULT ''::text,
    "type" bigint NOT NULL DEFAULT 0,
    "icon" text NOT NULL DEFAULT ''::text,
    "sn" bigint NOT NULL DEFAULT 0,
    "parentId" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "sys_resource_unique" ON "sys_resource" USING btree ("name", "parentId");

--
-- Class SysRole as table sys_role
--
CREATE TABLE "sys_role" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''::text
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_unique" ON "sys_role" USING btree ("name");

--
-- Class SysRoleResource as table sys_role_resource
--
CREATE TABLE "sys_role_resource" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL DEFAULT 0,
    "resourceId" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "sys_role_resource_unique" ON "sys_role_resource" USING btree ("roleId", "resourceId");

--
-- Class SysUser as table sys_user
--
CREATE TABLE "sys_user" (
    "id" bigserial PRIMARY KEY,
    "truename" text NOT NULL DEFAULT ''::text,
    "nickname" text NOT NULL DEFAULT ''::text,
    "username" text NOT NULL DEFAULT ''::text,
    "password" text NOT NULL DEFAULT ''::text,
    "phone" text NOT NULL DEFAULT ''::text,
    "email" text NOT NULL DEFAULT ''::text,
    "avatar" text,
    "roles" text,
    "permissions" text,
    "creatorId" bigint NOT NULL DEFAULT 0,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "loginTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" bigint NOT NULL DEFAULT 0,
    "isDeleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "sys_user_unique" ON "sys_user" USING btree ("username");

--
-- Class SysUserRole as table sys_user_role
--
CREATE TABLE "sys_user_role" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL DEFAULT 0
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
<<<<<<<< HEAD:book_store/book_store_server/migrations/20250228134114015/definition.sql
    VALUES ('book_store', '20250228134114015', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250228134114015', "timestamp" = now();
========
    VALUES ('book_store', '20250301055834224', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250301055834224', "timestamp" = now();
>>>>>>>> 7187d12a07e962d2b58d00c16c23d9490a059cf0:book_store/book_store_server/migrations/20250301055834224/definition.sql

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
