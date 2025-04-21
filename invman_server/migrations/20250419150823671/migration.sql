BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "stock" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stock" (
    "id" bigserial PRIMARY KEY,
    "symbol" text NOT NULL,
    "name" text NOT NULL,
    "value" double precision NOT NULL DEFAULT 0.0,
    "currency" text NOT NULL,
    "quoteType" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "stock_symbol_idx" ON "stock" USING btree ("symbol");

--
-- ACTION ALTER TABLE
--
CREATE INDEX "transfer_user_idx" ON "transfer" USING btree ("userId");
CREATE INDEX "transfer_stock_idx" ON "transfer" USING btree ("stockId");

--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250419150823671', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250419150823671', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
