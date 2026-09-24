BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "sys_menu_title_parent_unique";
DROP INDEX "sys_menu_permission_unique";
DROP INDEX "sys_menu_parent_sort_idx";
CREATE UNIQUE INDEX "sys_menu_title_parent_unique" ON "sys_menu" USING btree ("tenantId", "title", "parentId");
CREATE UNIQUE INDEX "sys_menu_permission_unique" ON "sys_menu" USING btree ("tenantId", "permission");
CREATE INDEX "sys_menu_parent_sort_idx" ON "sys_menu" USING btree ("tenantId", "parentId", "sort");

--
-- MIGRATION VERSION FOR flutter_web
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutter_web', '20260924020103589', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924020103589', "timestamp" = now();

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
