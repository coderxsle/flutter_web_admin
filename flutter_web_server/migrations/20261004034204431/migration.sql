BEGIN;

-- Refuse to discard bills created by an older deployment of the billing service.
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM "zhongyi_billing" LIMIT 1)
        OR EXISTS (SELECT 1 FROM "zhongyi_billing_item" LIMIT 1) THEN
        RAISE EXCEPTION 'zhongyi_billing tables contain data; reconcile them into zhongyi_bill before dropping';
    END IF;
    IF EXISTS (
        SELECT 1 FROM "zhongyi_bill" b
        LEFT JOIN "zhongyi_patient" p ON p."id" = b."patientId"
        WHERE p."id" IS NULL
    ) THEN
        RAISE EXCEPTION 'zhongyi_bill contains records without a patient; resolve tenant ownership first';
    END IF;
END $$;

--
-- ACTION DROP TABLE
--
DROP TABLE "zhongyi_billing_item";

--
-- ACTION DROP TABLE
--
DROP TABLE "zhongyi_billing";

--
-- ACTION ALTER TABLE
--
DROP INDEX "zhongyi_bill_patient_time_idx";
ALTER TABLE "zhongyi_bill" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
UPDATE "zhongyi_bill" b SET "tenantId" = p."tenantId"
FROM "zhongyi_patient" p WHERE p."id" = b."patientId";
CREATE INDEX "zhongyi_bill_patient_time_idx" ON "zhongyi_bill" USING btree ("tenantId", "patientId", "createTime");

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261004034204431', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004034204431', "timestamp" = now();

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
