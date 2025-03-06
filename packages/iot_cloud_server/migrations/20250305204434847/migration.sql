BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "platformio_project" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "path" text NOT NULL,
    "description" text,
    "board" text,
    "framework" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250305204434847', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250305204434847', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
