BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "zhongyi_inventory" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "zhongyi_medicine" DROP COLUMN "retailSaleUnit";
ALTER TABLE "zhongyi_medicine" DROP COLUMN "retailSalePrice";
ALTER TABLE "zhongyi_medicine" DROP COLUMN "latestPurchasePrice";
ALTER TABLE "zhongyi_medicine" DROP COLUMN "stockQuantityG";

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261004043623838', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004043623838', "timestamp" = now();

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
