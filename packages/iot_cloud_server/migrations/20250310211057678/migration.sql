BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "iot_device_state" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "iot_device_state" (
    "id" bigserial PRIMARY KEY,
    "status" bigint NOT NULL,
    "cpuLoad" bigint NOT NULL,
    "temp" double precision NOT NULL,
    "mem" double precision NOT NULL,
    "errorMessage" text NOT NULL,
    "heartBeat" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250310211057678', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250310211057678', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
