BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "zhongyi_prescription_template" ADD COLUMN "sourceType" text;
ALTER TABLE "zhongyi_prescription_template" ADD COLUMN "sourceId" bigint;
ALTER TABLE "zhongyi_prescription_template" ADD COLUMN "doctorId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "zhongyi_prescription_template_item" (
    "id" bigserial PRIMARY KEY,
    "templateId" bigint NOT NULL,
    "medicineId" bigint NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "role" text,
    "dosageGrams" double precision NOT NULL,
    "dosageUnit" text NOT NULL DEFAULT 'g'::text,
    "dosageText" text,
    "usageMethod" text,
    "isSubstitute" boolean NOT NULL DEFAULT false,
    "substituteForId" bigint,
    "notes" text,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "zhongyi_prescription_template_item_template_idx" ON "zhongyi_prescription_template_item" USING btree ("templateId", "deleted", "sortOrder");
CREATE INDEX "zhongyi_prescription_template_item_medicine_idx" ON "zhongyi_prescription_template_item" USING btree ("medicineId", "deleted");


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261004020855302-zhongyi-prescription-template-items', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004020855302-zhongyi-prescription-template-items', "timestamp" = now();

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
