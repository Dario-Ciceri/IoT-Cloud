BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "iot_device" DROP COLUMN "pins";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pin" ADD COLUMN "_iotDevicePinsIotDeviceId" bigint;
ALTER TABLE ONLY "pin"
    ADD CONSTRAINT "pin_fk_1"
    FOREIGN KEY("_iotDevicePinsIotDeviceId")
    REFERENCES "iot_device"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250219220906281', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250219220906281', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
