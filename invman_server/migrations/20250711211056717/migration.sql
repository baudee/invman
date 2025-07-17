BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "transfer" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "transfer" (
    "id" bigserial PRIMARY KEY,
    "investmentId" bigint NOT NULL,
    "quantity" double precision NOT NULL,
    "amount" double precision NOT NULL
);

-- Indexes
CREATE INDEX "investment_idx" ON "transfer" USING btree ("investmentId");

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
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250711211056717', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250711211056717', "timestamp" = now();

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
