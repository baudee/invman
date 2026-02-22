BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "currency" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "currency" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "dollarValue" double precision NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "currency_code_idx" ON "currency" USING btree ("code");

--
-- ACTION DROP TABLE
--
DROP TABLE "stock" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stock" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "symbol" text NOT NULL,
    "name" text NOT NULL,
    "quoteType" text NOT NULL,
    "logoUrl" text,
    "price" double precision NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "currencyId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "stock_symbol_idx" ON "stock" USING btree ("symbol");
CREATE INDEX "stock_name_idx" ON "stock" USING btree ("name");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "stock"
    ADD CONSTRAINT "stock_fk_0"
    FOREIGN KEY("currencyId")
    REFERENCES "currency"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20260222114926576', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260222114926576', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
