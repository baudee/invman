BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_user_info" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_user_image" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_google_refresh_token" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_reset" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_failed_sign_in" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_create_request" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_auth" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_key" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "stock" ADD COLUMN "logoUrl" text;

--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20260216142255278', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260216142255278', "timestamp" = now();

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


--
-- MIGRATION VERSION FOR 'serverpod_auth'
--
DELETE FROM "serverpod_migrations"WHERE "module" IN ('serverpod_auth');

COMMIT;
