BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "isbn" text NOT NULL,
    "title" text NOT NULL,
    "image" text NOT NULL,
    "author" text NOT NULL,
    "category" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "status" bigint NOT NULL,
    "publisher" text NOT NULL,
    "purchasePrice" double precision NOT NULL,
    "salePrice" double precision NOT NULL,
    "stock" bigint NOT NULL,
    "createTime" timestamp without time zone NOT NULL,
    "updatedTime" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR book_store
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_store', '20250111143633903', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250111143633903', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
