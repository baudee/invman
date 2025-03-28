BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "transfer" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "stockId" bigint NOT NULL,
    "quantity" double precision NOT NULL,
    "amount" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "transfer"
    ADD CONSTRAINT "transfer_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "transfer"
    ADD CONSTRAINT "transfer_fk_1"
    FOREIGN KEY("stockId")
    REFERENCES "stock"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR invman
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('invman', '20250328094115911', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250328094115911', "timestamp" = now();

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
