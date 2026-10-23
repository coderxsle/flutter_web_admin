BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_release" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "platform" text NOT NULL,
    "channel" text NOT NULL DEFAULT 'official'::text,
    "versionName" text NOT NULL,
    "versionCode" bigint NOT NULL,
    "releaseNotes" text NOT NULL DEFAULT ''::text,
    "minOsVersion" text,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "rolloutPercent" bigint NOT NULL DEFAULT 0,
    "forceUpdate" boolean NOT NULL DEFAULT false,
    "storageKey" text,
    "fileName" text,
    "fileSize" bigint NOT NULL DEFAULT 0,
    "sha256" text,
    "storeUrl" text,
    "publishedAt" timestamp without time zone,
    "downloadCount" bigint NOT NULL DEFAULT 0,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "app_release_version_unique" ON "app_release" USING btree ("tenantId", "platform", "channel", "versionCode");
CREATE INDEX "app_release_lookup_idx" ON "app_release" USING btree ("tenantId", "platform", "channel", "status", "versionCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_update_policy" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "platform" text NOT NULL,
    "channel" text NOT NULL DEFAULT 'official'::text,
    "minSupportedVersionCode" bigint NOT NULL DEFAULT 0,
    "promptCooldownHours" bigint NOT NULL DEFAULT 24,
    "downloadUrlTtlMinutes" bigint NOT NULL DEFAULT 120,
    "enabled" boolean NOT NULL DEFAULT true,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL,
    "deleted" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "app_update_policy_unique" ON "app_update_policy" USING btree ("tenantId", "platform", "channel");


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261023024748688-app-update', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261023024748688-app-update', "timestamp" = now();

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
