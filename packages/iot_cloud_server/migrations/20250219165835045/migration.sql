BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "sensor" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "iot_device" (
    "id" bigserial PRIMARY KEY,
    "info" json NOT NULL,
    "state" json NOT NULL,
    "attachedModules" json NOT NULL
);


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250219165835045', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250219165835045', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
