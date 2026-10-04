-- 用户性别字典语义与系统用户保持一致：
-- 1=男，2=女，3=保密。
--
-- 字段类型为 bigint，历史导入值按系统用户字典统一为 1/2/3。
UPDATE "public"."zhongyi_patient"
SET "gender" = CASE
  WHEN "gender" IS NULL THEN 3
  WHEN "gender" IN (1, 2, 3) THEN "gender"
  ELSE 3
END;

COMMENT ON COLUMN "public"."zhongyi_patient"."gender" IS '用户性别（1=男，2=女，3=保密）';
