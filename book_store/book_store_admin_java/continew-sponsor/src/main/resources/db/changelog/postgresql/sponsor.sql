-- liquibase formatted sql

-- changeset coderxslee:sys_sponsor

CREATE TABLE IF NOT EXISTS "sys_sponsor" (
    "id"          int8         NOT NULL,
    "name"        varchar(100) NOT NULL,
    "img"         varchar(512) NOT NULL,
    "url"         varchar(512) NOT NULL,
    "type"        varchar(30)  NOT NULL,
    "description" varchar(200) DEFAULT NULL,
    "sort"        int4         NOT NULL DEFAULT 999,
    "status"      int2         NOT NULL DEFAULT 1,
    "create_user" int8         NOT NULL,
    "create_time" timestamp    NOT NULL,
    "update_user" int8         DEFAULT NULL,
    "update_time" timestamp    DEFAULT NULL,
    PRIMARY KEY ("id")
);
CREATE INDEX "idx_sponsor_type" ON "sys_sponsor" ("type");
CREATE INDEX "idx_sponsor_create_user" ON "sys_sponsor" ("create_user");
CREATE INDEX "idx_sponsor_update_user" ON "sys_sponsor" ("update_user");
COMMENT ON COLUMN "sys_sponsor"."id"          IS 'ID';
COMMENT ON COLUMN "sys_sponsor"."name"        IS '赞助商名称';
COMMENT ON COLUMN "sys_sponsor"."img"         IS '图片URL';
COMMENT ON COLUMN "sys_sponsor"."url"         IS '跳转链接';
COMMENT ON COLUMN "sys_sponsor"."type"        IS '类型（platinum: 白金赞助商; gold: 金牌赞助商; silver: 银牌赞助商）';
COMMENT ON COLUMN "sys_sponsor"."description" IS '描述';
COMMENT ON COLUMN "sys_sponsor"."sort"        IS '排序';
COMMENT ON COLUMN "sys_sponsor"."status"      IS '状态（1：启用；2：禁用）';
COMMENT ON COLUMN "sys_sponsor"."create_user" IS '创建人';
COMMENT ON COLUMN "sys_sponsor"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_sponsor"."update_user" IS '修改人';
COMMENT ON COLUMN "sys_sponsor"."update_time" IS '修改时间';
COMMENT ON TABLE  "sys_sponsor"               IS '赞助商表'; 