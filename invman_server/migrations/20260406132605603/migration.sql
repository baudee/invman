BEGIN;

--
-- ACTION ALTER TABLE
--
-- Enable the extension
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Drop old index if it exists
DROP INDEX IF EXISTS "asset_name_idx";

-- Corrected Index Syntax: "column" <space> operator_class
CREATE INDEX "asset_symbol_trgm_idx" ON "asset" USING gin ("symbol" gin_trgm_ops);
CREATE INDEX "asset_name_trgm_idx" ON "asset" USING gin ("name" gin_trgm_ops);

--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20260406132605603', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260406132605603', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
