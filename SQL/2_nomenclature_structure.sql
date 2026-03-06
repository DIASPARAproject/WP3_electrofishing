--
-- PostgreSQL database dump
--

-- Dumped from database version 14.22 (Ubuntu 14.22-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: nomenclature; Type: SCHEMA; Schema: -; Owner: diaspara_admin
--

CREATE SCHEMA nomenclature;


ALTER SCHEMA nomenclature OWNER TO diaspara_admin;

--
-- Name: nomenclature_id_insert(); Type: FUNCTION; Schema: nomenclature; Owner: postgres
--

CREATE FUNCTION nomenclature.nomenclature_id_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  PERFORM no_id FROM "nomenclature".nomenclature WHERE no_id = NEW.no_id;
  IF FOUND THEN
	RAISE EXCEPTION '1- Invalid no_id (%)', NEW.no_id;
  ELSE
	RETURN NEW;
  END IF;
END
$$;


ALTER FUNCTION nomenclature.nomenclature_id_insert() OWNER TO postgres;

--
-- Name: nomenclature_id_update(); Type: FUNCTION; Schema: nomenclature; Owner: postgres
--

CREATE FUNCTION nomenclature.nomenclature_id_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  PERFORM no_id FROM "nomenclature".nomenclature WHERE no_id = NEW.no_id;
  IF FOUND THEN
	RETURN NEW;
  ELSE
	RAISE EXCEPTION '1- Invalid no_id (%)', NEW.no_id;
  END IF;
END
$$;


ALTER FUNCTION nomenclature.nomenclature_id_update() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: nomenclature; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.nomenclature (
    no_id integer NOT NULL,
    no_code text,
    no_type character varying(60),
    no_name character varying(80)
);


ALTER TABLE nomenclature.nomenclature OWNER TO diaspara_admin;

--
-- Name: age; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.age (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.age OWNER TO diaspara_admin;

--
-- Name: biological_characteristic_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.biological_characteristic_type (
    bc_label character varying(100),
    bc_unit character varying(25),
    bc_data_type character varying(25)
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.biological_characteristic_type OWNER TO diaspara_admin;

--
-- Name: downstream_mitigation_measure; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.downstream_mitigation_measure (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.downstream_mitigation_measure OWNER TO diaspara_admin;

--
-- Name: effort_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.effort_type (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.effort_type OWNER TO diaspara_admin;

--
-- Name: electrofishing_mean; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.electrofishing_mean (
    ef_definition character varying(500)
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.electrofishing_mean OWNER TO diaspara_admin;

--
-- Name: event_change; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.event_change (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.event_change OWNER TO diaspara_admin;

--
-- Name: fishway_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.fishway_type (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.fishway_type OWNER TO diaspara_admin;

--
-- Name: gear_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.gear_type (
    isscfg_code character varying(6),
    main_gear character varying(60),
    eel_specific_gear character varying(60)
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.gear_type OWNER TO diaspara_admin;

--
-- Name: maturity; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.maturity (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.maturity OWNER TO diaspara_admin;

--
-- Name: migration_direction; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.migration_direction (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.migration_direction OWNER TO diaspara_admin;

--
-- Name: nomenclature_no_id_seq; Type: SEQUENCE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE SEQUENCE nomenclature.nomenclature_no_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nomenclature.nomenclature_no_id_seq OWNER TO diaspara_admin;

--
-- Name: nomenclature_no_id_seq; Type: SEQUENCE OWNED BY; Schema: nomenclature; Owner: diaspara_admin
--

ALTER SEQUENCE nomenclature.nomenclature_no_id_seq OWNED BY nomenclature.nomenclature.no_id;


--
-- Name: obstruction_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.obstruction_type (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.obstruction_type OWNER TO diaspara_admin;

--
-- Name: TABLE obstruction_type; Type: COMMENT; Schema: nomenclature; Owner: diaspara_admin
--

COMMENT ON TABLE nomenclature.obstruction_type IS 'This table used to contain only physical obstruction as type, the types have been extended during sudoang';


--
-- Name: orient_flow; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.orient_flow (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.orient_flow OWNER TO diaspara_admin;

--
-- Name: scientific_observation_method; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.scientific_observation_method (
    sc_observation_category character varying(30),
    sc_definition character varying(500)
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.scientific_observation_method OWNER TO diaspara_admin;

--
-- Name: sex; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.sex (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.sex OWNER TO diaspara_admin;

--
-- Name: species; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.species (
    sp_vernacular_name character varying(30)
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.species OWNER TO diaspara_admin;

--
-- Name: stage; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.stage (
    spe_code text
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.stage OWNER TO diaspara_admin;

--
-- Name: turbine_type; Type: TABLE; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TABLE nomenclature.turbine_type (
)
INHERITS (nomenclature.nomenclature);


ALTER TABLE nomenclature.turbine_type OWNER TO diaspara_admin;

--
-- Name: age no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.age ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: biological_characteristic_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.biological_characteristic_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: downstream_mitigation_measure no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.downstream_mitigation_measure ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: effort_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.effort_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: electrofishing_mean no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.electrofishing_mean ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: event_change no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.event_change ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: fishway_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.fishway_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: gear_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.gear_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: maturity no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.maturity ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: migration_direction no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.migration_direction ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: nomenclature no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.nomenclature ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: obstruction_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.obstruction_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: orient_flow no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.orient_flow ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: scientific_observation_method no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.scientific_observation_method ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: sex no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.sex ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: species no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.species ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: stage no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.stage ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: turbine_type no_id; Type: DEFAULT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.turbine_type ALTER COLUMN no_id SET DEFAULT nextval('nomenclature.nomenclature_no_id_seq'::regclass);


--
-- Name: age age_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.age
    ADD CONSTRAINT age_id PRIMARY KEY (no_id);


--
-- Name: biological_characteristic_type bc_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.biological_characteristic_type
    ADD CONSTRAINT bc_id PRIMARY KEY (no_id);


--
-- Name: downstream_mitigation_measure c_pk_downstream_mitigation_measure; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.downstream_mitigation_measure
    ADD CONSTRAINT c_pk_downstream_mitigation_measure PRIMARY KEY (no_id);


--
-- Name: electrofishing_mean ef_mean_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.electrofishing_mean
    ADD CONSTRAINT ef_mean_id PRIMARY KEY (no_id);


--
-- Name: effort_type effort_type_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.effort_type
    ADD CONSTRAINT effort_type_id PRIMARY KEY (no_id);


--
-- Name: event_change event_change_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.event_change
    ADD CONSTRAINT event_change_id PRIMARY KEY (no_id);


--
-- Name: fishway_type fishway_type_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.fishway_type
    ADD CONSTRAINT fishway_type_id PRIMARY KEY (no_id);


--
-- Name: gear_type gear_type_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.gear_type
    ADD CONSTRAINT gear_type_id PRIMARY KEY (no_id);


--
-- Name: maturity maturity_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.maturity
    ADD CONSTRAINT maturity_id PRIMARY KEY (no_id);


--
-- Name: migration_direction migration_direction_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.migration_direction
    ADD CONSTRAINT migration_direction_id PRIMARY KEY (no_id);


--
-- Name: nomenclature nomenclature_pkey; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.nomenclature
    ADD CONSTRAINT nomenclature_pkey PRIMARY KEY (no_id);


--
-- Name: obstruction_type obstruction_type_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.obstruction_type
    ADD CONSTRAINT obstruction_type_id PRIMARY KEY (no_id);


--
-- Name: orient_flow orient_flow_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.orient_flow
    ADD CONSTRAINT orient_flow_id PRIMARY KEY (no_id);


--
-- Name: scientific_observation_method sc_observ_method_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.scientific_observation_method
    ADD CONSTRAINT sc_observ_method_id PRIMARY KEY (no_id);


--
-- Name: sex sex_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.sex
    ADD CONSTRAINT sex_id PRIMARY KEY (no_id);


--
-- Name: species sp_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.species
    ADD CONSTRAINT sp_id PRIMARY KEY (no_id);


--
-- Name: stage st_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.stage
    ADD CONSTRAINT st_id PRIMARY KEY (no_id);


--
-- Name: turbine_type turbine_type_id; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.turbine_type
    ADD CONSTRAINT turbine_type_id PRIMARY KEY (no_id);


--
-- Name: species uk_no_code; Type: CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.species
    ADD CONSTRAINT uk_no_code UNIQUE (no_code);


--
-- Name: downstream_mitigation_measure tr_downstream_mitigation_measure_insert; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_downstream_mitigation_measure_insert BEFORE INSERT ON nomenclature.downstream_mitigation_measure FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();


--
-- Name: downstream_mitigation_measure tr_downstream_mitigation_measure_update; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_downstream_mitigation_measure_update BEFORE UPDATE ON nomenclature.downstream_mitigation_measure FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();


--
-- Name: effort_type tr_effort_insert; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_effort_insert BEFORE INSERT ON nomenclature.effort_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();


--
-- Name: effort_type tr_effort_update; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_effort_update BEFORE UPDATE ON nomenclature.effort_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();


--
-- Name: event_change tr_event_change_insert; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_event_change_insert BEFORE INSERT ON nomenclature.event_change FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();


--
-- Name: event_change tr_event_change_update; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_event_change_update BEFORE UPDATE ON nomenclature.event_change FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();


--
-- Name: fishway_type tr_fishway_type_insert; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_fishway_type_insert BEFORE INSERT ON nomenclature.fishway_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();


--
-- Name: fishway_type tr_fishway_type_update; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_fishway_type_update BEFORE UPDATE ON nomenclature.fishway_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();


--
-- Name: obstruction_type tr_obstruction_type_insert; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_obstruction_type_insert BEFORE INSERT ON nomenclature.obstruction_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();


--
-- Name: obstruction_type tr_obstruction_type_update; Type: TRIGGER; Schema: nomenclature; Owner: diaspara_admin
--

CREATE TRIGGER tr_obstruction_type_update BEFORE UPDATE ON nomenclature.obstruction_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();


--
-- Name: stage fk_species; Type: FK CONSTRAINT; Schema: nomenclature; Owner: diaspara_admin
--

ALTER TABLE ONLY nomenclature.stage
    ADD CONSTRAINT fk_species FOREIGN KEY (spe_code) REFERENCES nomenclature.species(no_code) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA nomenclature; Type: ACL; Schema: -; Owner: diaspara_admin
--

GRANT USAGE ON SCHEMA nomenclature TO diaspara_read;


--
-- Name: FUNCTION nomenclature_id_insert(); Type: ACL; Schema: nomenclature; Owner: postgres
--

GRANT ALL ON FUNCTION nomenclature.nomenclature_id_insert() TO diaspara_read;


--
-- Name: FUNCTION nomenclature_id_update(); Type: ACL; Schema: nomenclature; Owner: postgres
--

GRANT ALL ON FUNCTION nomenclature.nomenclature_id_update() TO diaspara_read;


--
-- Name: TABLE nomenclature; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.nomenclature TO diaspara_read;


--
-- Name: TABLE age; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.age TO diaspara_read;


--
-- Name: TABLE biological_characteristic_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.biological_characteristic_type TO diaspara_read;


--
-- Name: TABLE downstream_mitigation_measure; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.downstream_mitigation_measure TO diaspara_read;


--
-- Name: TABLE effort_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.effort_type TO diaspara_read;


--
-- Name: TABLE electrofishing_mean; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.electrofishing_mean TO diaspara_read;


--
-- Name: TABLE event_change; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.event_change TO diaspara_read;


--
-- Name: TABLE fishway_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.fishway_type TO diaspara_read;


--
-- Name: TABLE gear_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.gear_type TO diaspara_read;


--
-- Name: TABLE maturity; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.maturity TO diaspara_read;


--
-- Name: TABLE migration_direction; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.migration_direction TO diaspara_read;


--
-- Name: TABLE obstruction_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.obstruction_type TO diaspara_read;


--
-- Name: TABLE orient_flow; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.orient_flow TO diaspara_read;


--
-- Name: TABLE scientific_observation_method; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.scientific_observation_method TO diaspara_read;


--
-- Name: TABLE sex; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.sex TO diaspara_read;


--
-- Name: TABLE species; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.species TO diaspara_read;


--
-- Name: TABLE stage; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.stage TO diaspara_read;


--
-- Name: TABLE turbine_type; Type: ACL; Schema: nomenclature; Owner: diaspara_admin
--

GRANT SELECT ON TABLE nomenclature.turbine_type TO diaspara_read;


--
-- PostgreSQL database dump complete
--

