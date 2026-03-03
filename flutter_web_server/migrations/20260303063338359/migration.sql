BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sys_api" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "path" text NOT NULL,
    "method" text NOT NULL,
    "remark" text,
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
-- ACTION ALTER TABLE
--
ALTER TABLE "sys_role" DROP COLUMN "dataScopeDeptIds";
ALTER TABLE "sys_role" ADD COLUMN "menus" json;
ALTER TABLE "sys_role" ADD COLUMN "apis" json;
ALTER TABLE "sys_role" ADD COLUMN "dataScopeDeptIds" json;
ALTER TABLE "sys_role" ALTER COLUMN "dataScope" SET DEFAULT 5;
CREATE INDEX "sys_role_tenant_deleted_idx" ON "sys_role" USING btree ("tenantId", "deleted");
CREATE INDEX "sys_role_tenant_status_idx" ON "sys_role" USING btree ("tenantId", "status");

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260303063338359', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260303063338359', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20260129181124635', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181124635', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
