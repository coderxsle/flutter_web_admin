BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_cloud_storage" ADD COLUMN "contentType" text;
ALTER TABLE "serverpod_cloud_storage" ADD COLUMN "cacheControl" text;
ALTER TABLE "serverpod_cloud_storage" ADD COLUMN "contentDisposition" text;
ALTER TABLE "serverpod_cloud_storage" ADD COLUMN "contentEncoding" text;
ALTER TABLE "serverpod_cloud_storage" ADD COLUMN "customMetadata" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "maxFileSize" bigint NOT NULL DEFAULT 10485760;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "contentLength" bigint;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "preventOverwrite" boolean NOT NULL DEFAULT false;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "contentType" text;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "cacheControl" text;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "contentDisposition" text;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "contentEncoding" text;
ALTER TABLE "serverpod_cloud_storage_direct_upload" ADD COLUMN "customMetadata" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_future_call" ADD COLUMN "scheduling" json;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- ACTION ALTER TABLE
--
DROP INDEX "serverpod_log_sessionLogId_idx";
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");
--
-- ACTION ALTER TABLE
--
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");
--
-- ACTION ALTER TABLE
--
DROP INDEX "serverpod_query_log_sessionLogId_idx";
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");
--
-- ACTION ALTER TABLE
--
-- Serverpod 4 renames nonce to key without changing its type. Preserve existing
-- attempts instead of the generated drop/recreate; PostgreSQL updates the
-- composite index to reference the renamed column automatically.
ALTER TABLE "serverpod_auth_idp_rate_limited_request_attempt"
    RENAME COLUMN "nonce" TO "key";

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260918044310778-serverpod-4-upgrade', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918044310778-serverpod-4-upgrade', "timestamp" = now();

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
