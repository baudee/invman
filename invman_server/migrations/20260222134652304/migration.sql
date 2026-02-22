BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_settings" (
    "id" bigserial PRIMARY KEY,
    "maintenanceMode" boolean NOT NULL,
    "minVersion" text NOT NULL,
    "appStoreUrl" text,
    "playStoreUrl" text
);


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20260222134652304', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260222134652304', "timestamp" = now();

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
