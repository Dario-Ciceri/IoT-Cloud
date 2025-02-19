BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sensor" (
    "id" bigserial PRIMARY KEY,
    "value" bigint NOT NULL
);


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250214163702802', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250214163702802', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
