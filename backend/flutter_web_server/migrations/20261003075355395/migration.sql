BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "zhongyi_bill" (
    "id" bigserial PRIMARY KEY,
    "billNo" text NOT NULL,
    "patientId" bigint NOT NULL,
    "registrationId" bigint,
    "medicalRecordId" bigint,
    "billingStage" text NOT NULL,
    "totalAmount" double precision NOT NULL DEFAULT 0.0,
    "paidAmount" double precision NOT NULL DEFAULT 0.0,
    "refundedAmount" double precision NOT NULL DEFAULT 0.0,
    "discountAmount" double precision,
    "discountReason" text,
    "paymentStatus" text NOT NULL DEFAULT 'unpaid'::text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "cashierId" bigint,
    "paidAt" timestamp without time zone,
    "notes" text,
    "description" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX IF NOT EXISTS "zhongyi_bill_no_unique" ON "zhongyi_bill" USING btree ("billNo");
CREATE INDEX IF NOT EXISTS "zhongyi_bill_patient_time_idx" ON "zhongyi_bill" USING btree ("patientId", "createTime");

--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "zhongyi_bill_item" (
    "id" bigserial PRIMARY KEY,
    "billId" bigint NOT NULL,
    "itemType" text NOT NULL,
    "referenceType" text,
    "referenceId" bigint,
    "itemName" text NOT NULL,
    "specification" text,
    "unit" text NOT NULL DEFAULT '次'::text,
    "quantity" bigint NOT NULL DEFAULT 1,
    "unitPrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "isRefunded" boolean NOT NULL DEFAULT false,
    "refundedQuantity" bigint NOT NULL DEFAULT 0,
    "description" text,
    "status" text NOT NULL DEFAULT '0'::text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS "zhongyi_bill_item_bill_idx" ON "zhongyi_bill_item" USING btree ("billId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "zhongyi_billing_item" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "billingId" bigint NOT NULL,
    "itemType" text NOT NULL,
    "itemName" text NOT NULL,
    "quantity" double precision NOT NULL DEFAULT 1.0,
    "unitPrice" double precision NOT NULL DEFAULT 0.0,
    "amount" double precision NOT NULL DEFAULT 0.0,
    "relationType" text,
    "relationId" bigint,
    "specification" text,
    "unit" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS "zhongyi_billing_item_tenant_bill_idx" ON "zhongyi_billing_item" USING btree ("tenantId", "billingId", "deleted");

--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "zhongyi_cabinet" (
    "id" bigserial PRIMARY KEY,
    "cabinetNo" text NOT NULL,
    "name" text,
    "location" text,
    "cabinetType" text NOT NULL DEFAULT 'drawer'::text,
    "medicineId" bigint,
    "capacityG" bigint,
    "isLocked" boolean NOT NULL DEFAULT false,
    "description" text,
    "status" text NOT NULL DEFAULT '0'::text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX IF NOT EXISTS "zhongyi_cabinet_no_unique" ON "zhongyi_cabinet" USING btree ("cabinetNo");

--
-- ACTION ALTER TABLE
--
-- Preserve existing values while aligning the generated model types.
ALTER TABLE "zhongyi_medicine"
  ALTER COLUMN "dosageWarning" TYPE double precision
  USING NULLIF(btrim("dosageWarning"), '')::double precision;
ALTER TABLE "zhongyi_medicine" ALTER COLUMN "status" SET DEFAULT 0;
--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "zhongyi_medicine_inventory" (
    "id" bigserial PRIMARY KEY,
    "medicineId" bigint NOT NULL,
    "batchNumber" text NOT NULL,
    "supplierId" bigint,
    "quantityG" double precision NOT NULL DEFAULT 0.0,
    "unit" text NOT NULL DEFAULT 'g'::text,
    "purchasePrice" double precision,
    "productionDate" timestamp without time zone,
    "expiryDate" timestamp without time zone,
    "qualityStatus" text NOT NULL DEFAULT 'qualified'::text,
    "storageLocation" text,
    "isExhausted" boolean NOT NULL DEFAULT false,
    "description" text,
    "status" text NOT NULL DEFAULT '0'::text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX IF NOT EXISTS "zhongyi_medicine_inventory_batch_unique" ON "zhongyi_medicine_inventory" USING btree ("medicineId", "batchNumber", "supplierId");

--
-- ACTION ALTER TABLE
--
-- Keep existing frequency values and expose them as text to the model.
ALTER TABLE "zhongyi_prescription_template"
  ALTER COLUMN "dailyFrequency" TYPE text
  USING "dailyFrequency"::text;

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261003075355395', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261003075355395', "timestamp" = now();

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
