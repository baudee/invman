BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE INDEX "stock_name_idx" ON "stock" USING btree ("name");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "stock_like" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "stockId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "stock_like_user_stock_idx" ON "stock_like" USING btree ("userId", "stockId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "stock_like"
    ADD CONSTRAINT "stock_like_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "stock_like"
    ADD CONSTRAINT "stock_like_fk_1"
    FOREIGN KEY("stockId")
    REFERENCES "stock"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20260220150102198', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260220150102198', "timestamp" = now();

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
