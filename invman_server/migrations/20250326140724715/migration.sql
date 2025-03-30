BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "stock" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "stock" ALTER COLUMN "value" SET DEFAULT 0.0;

--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250326140724715', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250326140724715', "timestamp" = now();

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
