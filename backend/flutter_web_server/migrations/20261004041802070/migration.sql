BEGIN;

--
-- status 由 text 改为 bigint：原位转换，保留既有数据。
-- 数值语义：0=停用/取消，1=启用/正常；payment 为 0待支付 1已支付 2支付失败 3已退款；
-- refund 为 0待审批 1已批准 2已完成。数据本身的修正由导入脚本负责，此处只做类型转换。
--
ALTER TABLE "zhongyi_bill"
    ALTER COLUMN "status" DROP DEFAULT,
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE WHEN "status" = 'active' THEN 1 ELSE 0 END
    ),
    ALTER COLUMN "status" SET DEFAULT 1;

ALTER TABLE "zhongyi_bill_item"
    ALTER COLUMN "status" DROP DEFAULT,
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE WHEN "status" IN ('0', '1') THEN "status"::bigint ELSE 0 END
    ),
    ALTER COLUMN "status" SET DEFAULT 0;

ALTER TABLE "zhongyi_cabinet"
    ALTER COLUMN "status" DROP DEFAULT,
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE WHEN "status" IN ('0', '1') THEN "status"::bigint ELSE 0 END
    ),
    ALTER COLUMN "status" SET DEFAULT 0;

ALTER TABLE "zhongyi_medicine_inventory"
    ALTER COLUMN "status" DROP DEFAULT,
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE WHEN "status" IN ('0', '1') THEN "status"::bigint ELSE 0 END
    ),
    ALTER COLUMN "status" SET DEFAULT 0;

ALTER TABLE "zhongyi_payment"
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE "status"
            WHEN 'pending' THEN 0
            WHEN 'paid' THEN 1
            WHEN 'failed' THEN 2
            WHEN 'refunded' THEN 3
            ELSE 0
        END
    );

ALTER TABLE "zhongyi_refund"
    ALTER COLUMN "status" SET DATA TYPE bigint USING (
        CASE "status"
            WHEN 'pending' THEN 0
            WHEN 'approved' THEN 1
            WHEN 'completed' THEN 2
            ELSE 0
        END
    );

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261004041802070', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004041802070', "timestamp" = now();

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
