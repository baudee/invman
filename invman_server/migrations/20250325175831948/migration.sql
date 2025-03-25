BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stock" (
    "id" bigserial PRIMARY KEY,
    "symbol" text NOT NULL,
    "name" text NOT NULL,
    "value" double precision,
    "currency" text NOT NULL
);


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250325175831948', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250325175831948', "timestamp" = now();

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
