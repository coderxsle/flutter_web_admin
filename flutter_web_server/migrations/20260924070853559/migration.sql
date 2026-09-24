BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "air_table_fields" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
ALTER TABLE "air_table_fields" ADD COLUMN "deleted" boolean NOT NULL DEFAULT false;
CREATE INDEX "air_table_fields_tenant_deleted_idx" ON "air_table_fields" USING btree ("tenantId", "deleted");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "air_table_items" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
ALTER TABLE "air_table_items" ADD COLUMN "deleted" boolean NOT NULL DEFAULT false;
CREATE INDEX "air_table_items_tenant_deleted_idx" ON "air_table_items" USING btree ("tenantId", "deleted");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "air_table_rows" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
ALTER TABLE "air_table_rows" ADD COLUMN "deleted" boolean NOT NULL DEFAULT false;
CREATE INDEX "air_table_rows_tenant_deleted_idx" ON "air_table_rows" USING btree ("tenantId", "deleted");
--
-- ACTION ALTER TABLE
--
DROP INDEX "table_name_unique";
ALTER TABLE "air_tables" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
ALTER TABLE "air_tables" ADD COLUMN "deleted" boolean NOT NULL DEFAULT false;
CREATE INDEX "air_tables_tenant_deleted_idx" ON "air_tables" USING btree ("tenantId", "deleted");
CREATE UNIQUE INDEX "table_name_unique" ON "air_tables" USING btree ("tenantId", "name");

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260924070853559', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924070853559', "timestamp" = now();

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
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();


COMMIT;
