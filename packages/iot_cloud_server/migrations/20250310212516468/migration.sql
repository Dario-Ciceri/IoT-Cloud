BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "iot_device_state" ALTER COLUMN "errorMessage" DROP NOT NULL;

--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250310212516468', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250310212516468', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
