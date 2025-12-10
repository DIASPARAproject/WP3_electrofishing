--
-- CREATE integrity triggers on dbmig.establishment and dbmig.data_provider
-- fk_id_establishment_insert
-- fk_id_data_provider_insert
-- integrity_establishment_verify
-- pk_id_data_provider_insert
-- pk_id_establishment_insert
--
-- *************************************************
-- 1) Create schema
-- *************************************************


-- @block establishment

--- @label primary key trigger
CREATE OR REPLACE FUNCTION dbmig.pk_id_establishment_insert() RETURNS trigger
    LANGUAGE plpgsql AS
$$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        PERFORM et_id FROM dbmig.establishment WHERE et_id = NEW.et_id;
        IF FOUND THEN
            RAISE EXCEPTION 'PRIMARY KEY- et_id % already used', NEW.et_id;
        ELSE
            RETURN NEW;
        END IF;
    ELSIF (TG_OP = 'UPDATE') THEN
        IF (NEW.et_id <> OLD.et_id) THEN
            PERFORM et_id FROM dbmig.establishment WHERE et_id = NEW.et_id;
            IF FOUND THEN
            RAISE EXCEPTION 'PRIMARY KEY- et_id % already used', NEW.et_id;
            ELSE
            RETURN NEW;
            END IF;
        ELSE
            RETURN NEW;
        END IF;
    END IF;
END
$$;

ALTER FUNCTION dbmig.pk_id_establishment_insert() OWNER TO diaspara_admin;
COMMENT ON FUNCTION dbmig.pk_id_establishment_insert is 'Workaround for primary key';

CREATE TRIGGER tr_pk_id_establishment_insert BEFORE INSERT OR UPDATE ON dbmig.establishment FOR EACH ROW EXECUTE FUNCTION dbmig.pk_id_establishment_insert();

-- @block data provider

--- @label primary key trigger
CREATE OR REPLACE FUNCTION dbmig.pk_id_data_provider_insert() RETURNS trigger
    LANGUAGE plpgsql AS
$$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        PERFORM dp_id FROM dbmig.data_provider WHERE dp_id = NEW.dp_id;
        IF FOUND THEN
            RAISE EXCEPTION 'PRIMARY KEY- dp_id % already used', NEW.dp_id;
        ELSE
            RETURN NEW;
        END IF;
    ELSIF (TG_OP = 'UPDATE') THEN
        IF (NEW.dp_id <> OLD.dp_id) THEN
            PERFORM dp_id FROM dbmig.data_provider WHERE dp_id = NEW.dp_id;
            IF FOUND THEN
            RAISE EXCEPTION 'PRIMARY KEY- dp_id % already used', NEW.dp_id;
            ELSE
            RETURN NEW;
            END IF;
        ELSE
            RETURN NEW;
        END IF;
    END IF;
END
$$;

ALTER FUNCTION dbmig.pk_id_data_provider_insert() OWNER TO diaspara_admin;
COMMENT ON FUNCTION dbmig.pk_id_data_provider_insert is 'Workaround for primary key';

CREATE TRIGGER tr_pk_id_data_provider_insert BEFORE INSERT OR UPDATE ON dbmig.data_provider FOR EACH ROW EXECUTE FUNCTION dbmig.pk_id_data_provider_insert();

--- @label foreign key trigger for establishment
CREATE FUNCTION dbmig.fk_id_establishment_insert() RETURNS trigger
    LANGUAGE plpgsql AS
$$
BEGIN
  PERFORM et_id FROM dbmig.establishment WHERE et_id = NEW.dp_et_id;
  IF FOUND THEN
	RETURN NEW;
  ELSE
	RAISE EXCEPTION '5- Invalid dp_et_id (%)', NEW.dp_et_id;
  END IF;
END
$$;

ALTER FUNCTION dbmig.fk_id_establishment_insert() OWNER TO diaspara_admin;
COMMENT ON FUNCTION dbmig.fk_id_establishment_insert is 'Workaround for foreign key';

CREATE TRIGGER tr_fk_id_establishment_insert BEFORE INSERT OR UPDATE ON dbmig.data_provider FOR EACH ROW EXECUTE FUNCTION dbmig.fk_id_establishment_insert();

ALTER TABLE ONLY dbmig.data_provider
    DROP CONSTRAINT fk_et_id;

CREATE FUNCTION dbmig.integrity_establishment_verify() RETURNS trigger
    LANGUAGE plpgsql AS
$$
BEGIN
  PERFORM dp_et_id FROM "dbmig".data_provider WHERE dp_et_id = OLD.et_id;
  IF FOUND THEN
	RAISE EXCEPTION '6- You try to delete an establishment record while there is some records in data_provider referring to it. et_id: (%)', OLD.et_id;
  ELSE
	RETURN OLD;
  END IF;
END
$$;
COMMENT ON FUNCTION dbmig.integrity_establishment_verify is 'Workaround for foreign key';

ALTER FUNCTION dbmig.integrity_establishment_verify() OWNER TO diaspara_admin;

CREATE TRIGGER tr_establishment_delete BEFORE DELETE ON dbmig.establishment FOR EACH ROW EXECUTE FUNCTION dbmig.integrity_establishment_verify();


--- @label foreign key trigger for data_provider
CREATE OR REPLACE FUNCTION dbmig.fk_id_data_provider_insert() RETURNS trigger
    LANGUAGE plpgsql AS
$$
BEGIN
    CASE TG_TABLE_NAME
        WHEN 'observation_places', 'aspe_station_op', 'rsa_station_op'  THEN
            PERFORM dp_id FROM dbmig.data_provider WHERE dp_id = NEW.op_dp_id;
            IF FOUND THEN
                RETURN NEW;
            ELSE
                RAISE EXCEPTION '5- Invalid op_dp_id (%)', NEW.op_dp_id;
            END IF;
        ELSE
            RAISE EXCEPTION '5- (%) not supported for foreign key on dp_id cf trigger fk_id_data_provider_insert', TG_TABLE_NAME;
    END CASE;
END
$$;

ALTER FUNCTION dbmig.fk_id_data_provider_insert() OWNER TO diaspara_admin;
COMMENT ON FUNCTION dbmig.fk_id_establishment_insert is 'Workaround for foreign key';
