BEGIN;

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
    "stateId" bigint NOT NULL,
    "attachedModules" json NOT NULL,
    "pins" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "iot_device_state_unique_idx" ON "iot_device" USING btree ("stateId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "iot_device"
    ADD CONSTRAINT "iot_device_fk_0"
    FOREIGN KEY("stateId")
    REFERENCES "iot_device_state"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250219213408381', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250219213408381', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
