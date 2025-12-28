BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "investment" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "name" text NOT NULL,
    "withdrawalRuleId" bigint NOT NULL,
    "stockSymbol" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "investment_user_idx" ON "investment" USING btree ("userId", "updatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "transfer" (
    "id" bigserial PRIMARY KEY,
    "investmentId" bigint NOT NULL,
    "quantity" double precision NOT NULL,
    "amount" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "investment_idx" ON "transfer" USING btree ("investmentId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "withdrawal_fee" (
    "id" bigserial PRIMARY KEY,
    "fixed" double precision NOT NULL DEFAULT 0.0,
    "percent" double precision NOT NULL DEFAULT 0.0,
    "minimum" double precision NOT NULL DEFAULT 0.0,
    "ruleId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "withdrawal_rule" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "name" text NOT NULL,
    "currencyChangePercentage" double precision NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "investment"
    ADD CONSTRAINT "investment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "investment"
    ADD CONSTRAINT "investment_fk_1"
    FOREIGN KEY("withdrawalRuleId")
    REFERENCES "withdrawal_rule"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "transfer"
    ADD CONSTRAINT "transfer_fk_0"
    FOREIGN KEY("investmentId")
    REFERENCES "investment"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "withdrawal_fee"
    ADD CONSTRAINT "withdrawal_fee_fk_0"
    FOREIGN KEY("ruleId")
    REFERENCES "withdrawal_rule"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "withdrawal_rule"
    ADD CONSTRAINT "withdrawal_rule_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20251226152639163', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251226152639163', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
