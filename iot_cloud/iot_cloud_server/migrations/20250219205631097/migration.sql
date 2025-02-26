BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "io_module" (
    "id" bigserial PRIMARY KEY,
    "state" json NOT NULL,
    "serialId" text NOT NULL,
    "name" text NOT NULL,
    "type" bigint NOT NULL,
    "subtype" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "io_module_state" (
    "id" bigserial PRIMARY KEY,
    "value" text NOT NULL,
    "unit" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "iot_device" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "iot_device" (
    "id" bigserial PRIMARY KEY,
    "serialId" text NOT NULL,
    "type" bigint NOT NULL,
    "name" text NOT NULL,
    "fwVersion" text NOT NULL,
    "state" json NOT NULL,
    "attachedModules" json NOT NULL,
    "pins" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "iot_device_state" (
    "id" bigserial PRIMARY KEY,
    "status" bigint NOT NULL,
    "cpuLoad" bigint NOT NULL,
    "temp" double precision NOT NULL,
    "mem" double precision NOT NULL,
    "heartBeat" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pin" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "number" bigint NOT NULL,
    "direction" bigint NOT NULL,
    "properties" json NOT NULL,
    "state" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pin_state" (
    "id" bigserial PRIMARY KEY,
    "value" text NOT NULL
);


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250219205631097', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250219205631097', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
