BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "io_module" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "io_module" (
    "id" bigserial PRIMARY KEY,
    "iotDeviceId" bigint NOT NULL,
    "stateId" bigint NOT NULL,
    "serialId" text NOT NULL,
    "name" text NOT NULL,
    "type" bigint NOT NULL,
    "subtype" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "io_module_state_unique_idx" ON "io_module" USING btree ("stateId");

--
-- ACTION DROP TABLE
--
DROP TABLE "pin" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "pin" (
    "id" bigserial PRIMARY KEY,
    "iotDeviceId" bigint NOT NULL,
    "name" text NOT NULL,
    "number" bigint NOT NULL,
    "direction" bigint NOT NULL,
    "properties" json NOT NULL,
    "stateId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "pin_state_unique_idx" ON "pin" USING btree ("stateId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "io_module"
    ADD CONSTRAINT "io_module_fk_0"
    FOREIGN KEY("iotDeviceId")
    REFERENCES "iot_device"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "io_module"
    ADD CONSTRAINT "io_module_fk_1"
    FOREIGN KEY("stateId")
    REFERENCES "io_module_state"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "pin"
    ADD CONSTRAINT "pin_fk_0"
    FOREIGN KEY("iotDeviceId")
    REFERENCES "iot_device"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pin"
    ADD CONSTRAINT "pin_fk_1"
    FOREIGN KEY("stateId")
    REFERENCES "pin_state"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR iot_cloud
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('iot_cloud', '20250222181256945', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250222181256945', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
