BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_billing" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "billNo" text NOT NULL,
    "patientId" bigint NOT NULL,
    "patientName" text NOT NULL,
    "billingStage" text NOT NULL,
    "totalAmount" double precision NOT NULL DEFAULT 0.0,
    "paidAmount" double precision NOT NULL DEFAULT 0.0,
    "refundedAmount" double precision NOT NULL DEFAULT 0.0,
    "paymentStatus" text NOT NULL,
    "status" text NOT NULL,
    "remark" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_billing_tenant_bill_no_unique" ON "zhongyi_billing" USING btree ("tenantId", "billNo");
CREATE INDEX "zhongyi_billing_tenant_patient_time_idx" ON "zhongyi_billing" USING btree ("tenantId", "patientId", "createTime");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_department" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "parentId" bigint DEFAULT 0,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "isActive" boolean NOT NULL DEFAULT true,
    "phone" text,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_department_tenant_code_unique" ON "zhongyi_department" USING btree ("tenantId", "code");
CREATE INDEX "zhongyi_department_tenant_parent_sort_idx" ON "zhongyi_department" USING btree ("tenantId", "parentId", "sortOrder");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_inventory" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "medicineId" bigint NOT NULL,
    "medicineName" text NOT NULL,
    "batchNumber" text NOT NULL,
    "quantityG" double precision NOT NULL DEFAULT 0.0,
    "unit" text NOT NULL,
    "purchasePrice" double precision NOT NULL DEFAULT 0.0,
    "expiryDate" timestamp without time zone,
    "qualityStatus" text,
    "storageLocation" text,
    "remark" text,
    "status" bigint NOT NULL DEFAULT 1,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_inventory_tenant_medicine_batch_unique" ON "zhongyi_inventory" USING btree ("tenantId", "medicineId", "batchNumber");
CREATE INDEX "zhongyi_inventory_tenant_medicine_expiry_idx" ON "zhongyi_inventory" USING btree ("tenantId", "medicineId", "expiryDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_inventory_transaction" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "medicineId" bigint NOT NULL,
    "inventoryId" bigint,
    "batchNumber" text,
    "transactionType" text NOT NULL,
    "quantityChangeG" double precision NOT NULL,
    "quantityBeforeG" double precision NOT NULL,
    "quantityAfterG" double precision NOT NULL,
    "remark" text,
    "operatorId" bigint,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_inventory_transaction_tenant_medicine_time_idx" ON "zhongyi_inventory_transaction" USING btree ("tenantId", "medicineId", "createTime");
CREATE INDEX "zhongyi_inventory_transaction_tenant_inventory_idx" ON "zhongyi_inventory_transaction" USING btree ("tenantId", "inventoryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_medicine" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "medicineCode" text NOT NULL,
    "prefix" text,
    "baseName" text NOT NULL,
    "name" text NOT NULL,
    "pinyin" text,
    "category" text,
    "subcategory" text,
    "originPlace" text,
    "propertiesJson" text,
    "functions" text,
    "indications" text,
    "commonDosageMin" double precision,
    "commonDosageMax" double precision,
    "dosageWarning" text,
    "toxicity" text,
    "pregnancyCategory" text,
    "isSpecialManagement" boolean NOT NULL DEFAULT false,
    "storageRequirements" text,
    "shelfLifeMonths" bigint,
    "description" text,
    "retailSaleUnit" text,
    "retailSalePrice" double precision NOT NULL DEFAULT 0.0,
    "latestPurchasePrice" double precision NOT NULL DEFAULT 0.0,
    "stockQuantityG" double precision NOT NULL DEFAULT 0.0,
    "status" bigint NOT NULL DEFAULT 1,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_medicine_tenant_code_unique" ON "zhongyi_medicine" USING btree ("tenantId", "medicineCode");
CREATE INDEX "zhongyi_medicine_tenant_category_status_deleted_idx" ON "zhongyi_medicine" USING btree ("tenantId", "category", "status", "deleted");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_medicine_price" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "medicineId" bigint NOT NULL,
    "priceType" text NOT NULL,
    "unit" text NOT NULL,
    "salePrice" double precision NOT NULL,
    "effectiveFrom" timestamp without time zone NOT NULL,
    "effectiveTo" timestamp without time zone,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_medicine_price_tenant_medicine_effective_idx" ON "zhongyi_medicine_price" USING btree ("tenantId", "medicineId", "effectiveFrom");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_patient" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "gender" text,
    "birthDate" timestamp without time zone,
    "phone" text,
    "idCard" text,
    "address" text,
    "occupation" text,
    "bloodType" text,
    "emergencyContact" text,
    "emergencyPhone" text,
    "allergyHistory" text,
    "medicalHistory" text,
    "familyHistory" text,
    "constitution" text,
    "source" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_patient_tenant_name_idx" ON "zhongyi_patient" USING btree ("tenantId", "name");
CREATE INDEX "zhongyi_patient_tenant_phone_idx" ON "zhongyi_patient" USING btree ("tenantId", "phone");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_patient_access_log" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "patientId" bigint,
    "action" text NOT NULL,
    "actorId" bigint,
    "accessTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_patient_access_log_tenant_patient_time_idx" ON "zhongyi_patient_access_log" USING btree ("tenantId", "patientId", "accessTime");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_payment" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "billingId" bigint NOT NULL,
    "channel" text NOT NULL,
    "amount" double precision NOT NULL,
    "transactionNo" text,
    "status" text NOT NULL,
    "paidAt" timestamp without time zone,
    "operatorId" bigint,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_payment_tenant_billing_idx" ON "zhongyi_payment" USING btree ("tenantId", "billingId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_prescription_template" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "scope" text NOT NULL,
    "category" text,
    "syndrome" text,
    "efficacy" text,
    "doses" bigint NOT NULL DEFAULT 1,
    "itemsJson" text NOT NULL,
    "dailyFrequency" bigint,
    "administrationMethod" text,
    "decoctionInstruction" text,
    "dietRestrictions" text,
    "notes" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_prescription_template_tenant_active_idx" ON "zhongyi_prescription_template" USING btree ("tenantId", "isActive", "deleted");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_refund" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "billingId" bigint NOT NULL,
    "refundNo" text NOT NULL,
    "refundAmount" double precision NOT NULL,
    "refundReason" text,
    "status" text NOT NULL,
    "requestedBy" bigint,
    "approvedBy" bigint,
    "completedBy" bigint,
    "requestedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "approvedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_refund_tenant_refund_no_unique" ON "zhongyi_refund" USING btree ("tenantId", "refundNo");
CREATE INDEX "zhongyi_refund_tenant_billing_status_idx" ON "zhongyi_refund" USING btree ("tenantId", "billingId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_staff" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "departmentId" bigint,
    "employeeCode" text NOT NULL,
    "professionalTitle" text,
    "licenseNumber" text,
    "specialization" text,
    "isDoctor" boolean NOT NULL DEFAULT false,
    "isPharmacist" boolean NOT NULL DEFAULT false,
    "consultationFee" double precision NOT NULL DEFAULT 0.0,
    "introduction" text,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "zhongyi_staff_tenant_user_unique" ON "zhongyi_staff" USING btree ("tenantId", "userId");
CREATE UNIQUE INDEX "zhongyi_staff_tenant_employee_code_unique" ON "zhongyi_staff" USING btree ("tenantId", "employeeCode");
CREATE INDEX "zhongyi_staff_tenant_department_deleted_idx" ON "zhongyi_staff" USING btree ("tenantId", "departmentId", "deleted");


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261003040746355', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261003040746355', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();


COMMIT;
