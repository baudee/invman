BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "withdrawal" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "fixed" double precision NOT NULL DEFAULT 0.0,
    "percent" double precision NOT NULL DEFAULT 0.0,
    "minimum" double precision NOT NULL DEFAULT 0.0
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "withdrawal"
    ADD CONSTRAINT "withdrawal_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250504152755697', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250504152755697', "timestamp" = now();

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
