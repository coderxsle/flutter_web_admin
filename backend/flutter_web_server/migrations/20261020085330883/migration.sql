BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "arts_record" (
    "id" bigserial PRIMARY KEY,
    "tenantId" bigint NOT NULL DEFAULT 0,
    "userId" bigint NOT NULL,
    "artsType" text NOT NULL,
    "clientKey" text NOT NULL,
    "title" text NOT NULL DEFAULT ''::text,
    "question" text NOT NULL DEFAULT ''::text,
    "chartTime" timestamp without time zone NOT NULL,
    "queryParams" text NOT NULL DEFAULT ''::text,
    "chartSnapshot" text NOT NULL DEFAULT ''::text,
    "interpretation" text NOT NULL DEFAULT ''::text,
    "feedback" text NOT NULL DEFAULT ''::text,
    "tags" json,
    "status" bigint NOT NULL DEFAULT 1,
    "deleted" boolean NOT NULL DEFAULT false,
    "creator" text,
    "createTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updater" text,
    "updateTime" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "arts_record_client_key_unique" ON "arts_record" USING btree ("tenantId", "userId", "clientKey");
CREATE INDEX "arts_record_user_type_time_idx" ON "arts_record" USING btree ("tenantId", "userId", "artsType", "chartTime");


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261020085330883', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261020085330883', "timestamp" = now();

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
