BEGIN;

--
-- ACTION ALTER TABLE
--
-- Serverpod generated a drop/add for the text -> bigint change. Convert in
-- place instead so existing patient gender values are retained.
ALTER TABLE "zhongyi_patient" ALTER COLUMN "gender" DROP DEFAULT;
DO $$
DECLARE
    current_type text;
BEGIN
    SELECT data_type
      INTO current_type
      FROM information_schema.columns
     WHERE table_schema = 'public'
       AND table_name = 'zhongyi_patient'
       AND column_name = 'gender';

    IF current_type = 'text' THEN
        ALTER TABLE "zhongyi_patient"
            ALTER COLUMN "gender" TYPE bigint
            USING CASE
                WHEN "gender" IS NULL OR btrim("gender") = '' THEN 3
                WHEN lower(btrim("gender")) IN ('1', 'male') THEN 1
                WHEN lower(btrim("gender")) IN ('2', 'female') THEN 2
                WHEN lower(btrim("gender")) IN ('3', 'other', 'secret') THEN 3
                ELSE 3
            END;
    ELSIF current_type <> 'bigint' THEN
        RAISE EXCEPTION 'zhongyi_patient.gender 当前类型为 %，无法迁移为 bigint', current_type;
    END IF;
END $$;
ALTER TABLE "zhongyi_patient" ALTER COLUMN "gender" SET DEFAULT 3;
ALTER TABLE "zhongyi_patient" ALTER COLUMN "gender" SET NOT NULL;
COMMENT ON COLUMN "public"."zhongyi_patient"."gender" IS '用户性别（1=男，2=女，3=保密）';

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20261004032818129', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004032818129', "timestamp" = now();

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
