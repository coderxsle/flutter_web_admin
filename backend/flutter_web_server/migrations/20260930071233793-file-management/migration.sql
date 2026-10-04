BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "infra_file" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;
ALTER TABLE "infra_file" ADD COLUMN "parentId" bigint;
ALTER TABLE "infra_file" ADD COLUMN "isDir" boolean NOT NULL DEFAULT false;
ALTER TABLE "infra_file" ADD COLUMN "storageKey" text;
ALTER TABLE "infra_file" ADD COLUMN "extendName" text;
ALTER TABLE "infra_file" ADD COLUMN "mimeType" text;
ALTER TABLE "infra_file" ADD COLUMN "sha256" text;
ALTER TABLE "infra_file" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "infra_file" ALTER COLUMN "url" DROP NOT NULL;
ALTER TABLE "infra_file" ALTER COLUMN "size" SET DEFAULT 0;

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260930071233793-file-management', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260930071233793-file-management', "timestamp" = now();

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
