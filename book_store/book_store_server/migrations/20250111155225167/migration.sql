BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "book" ALTER COLUMN "isbn" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "image" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "author" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "category" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "categoryId" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "status" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "publisher" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "purchasePrice" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "salePrice" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "stock" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "createTime" DROP NOT NULL;
ALTER TABLE "book" ALTER COLUMN "updatedTime" DROP NOT NULL;

--
-- MIGRATION VERSION FOR book_store
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('book_store', '20250111155225167', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250111155225167', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
