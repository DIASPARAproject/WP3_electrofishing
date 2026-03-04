--
-- PostgreSQL database dump
--

-- Dumped from database version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)
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
-- Name: electrofishing; Type: SCHEMA; Schema: -; Owner: diaspara_admin
--

CREATE SCHEMA electrofishing;


ALTER SCHEMA electrofishing OWNER TO diaspara_admin;



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: batch; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.batch (
    ba_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    ba_op_id uuid NOT NULL,
    ba_ba_id uuid,
    ba_id_original text,
    ba_no_species integer,
    ba_no_stage integer,
    ba_no_biol_char integer,
    ba_quantity real,
    ba_batch_level integer
);


ALTER TABLE electrofishing.batch OWNER TO diaspara_admin;

--
-- Name: batch_fish; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.batch_fish (
    CONSTRAINT c_ck_ba_batch_level CHECK ((ba_batch_level = 2))
)
INHERITS (electrofishing.batch);


ALTER TABLE electrofishing.batch_fish OWNER TO diaspara_admin;

--
-- Name: batch_ope; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.batch_ope (
    ba_pass integer,
    CONSTRAINT c_ck_ba_ba_id CHECK ((ba_ba_id IS NULL)),
    CONSTRAINT c_ck_ba_batch_level CHECK ((ba_batch_level = 1))
)
INHERITS (electrofishing.batch);


ALTER TABLE electrofishing.batch_ope OWNER TO diaspara_admin;

--
-- Name: biological_characteristic; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.biological_characteristic (
    bc_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bc_ba_id uuid NOT NULL,
    bc_no_biol_char integer NOT NULL,
    bc_numvalue real
);


ALTER TABLE electrofishing.biological_characteristic OWNER TO diaspara_admin;

--
-- Name: data_provider; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.data_provider (
    dp_id integer NOT NULL,
    dp_name character varying(60),
    dp_edmo_key integer,
    dp_establishment_name text
);


ALTER TABLE electrofishing.data_provider OWNER TO diaspara_admin;

--
-- Name: data_provider_dp_id_seq; Type: SEQUENCE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE SEQUENCE electrofishing.data_provider_dp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE electrofishing.data_provider_dp_id_seq OWNER TO diaspara_admin;

--
-- Name: data_provider_dp_id_seq; Type: SEQUENCE OWNED BY; Schema: electrofishing; Owner: diaspara_admin
--

ALTER SEQUENCE electrofishing.data_provider_dp_id_seq OWNED BY electrofishing.data_provider.dp_id;


--
-- Name: gear_fishing; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.gear_fishing (
    gf_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    gf_id_original text,
    gf_sta_id uuid NOT NULL,
    gf_starting_date date NOT NULL,
    gf_ending_date date,
    gf_dp_id integer NOT NULL,
    gf_no_gear_type integer,
    gf_gear_number integer,
    gf_no_effort_type integer,
    gf_effort_value real,
    CONSTRAINT ck_gf_gear_number CHECK ((gf_gear_number > 0)),
    CONSTRAINT ck_gf_gf_effort_value CHECK ((gf_effort_value > (0)::double precision))
);


ALTER TABLE electrofishing.gear_fishing OWNER TO diaspara_admin;

--
-- Name: operation; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.operation (
    op_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    op_id_original text,
    op_sta_id uuid NOT NULL,
    op_starting_date date NOT NULL,
    op_ending_date date,
    op_dp_id integer NOT NULL,
    op_no_method integer,
    op_no_efishing_mean integer,
    op_wetted_area real,
    op_fished_length real,
    op_fished_width real,
    op_duration double precision,
    op_nbpas integer,
    CONSTRAINT ck_op_duration CHECK ((op_duration > (0)::double precision)),
    CONSTRAINT ck_op_fished_length CHECK ((op_fished_length > (0)::double precision)),
    CONSTRAINT ck_op_fished_width CHECK ((op_fished_width > (0)::double precision)),
    CONSTRAINT ck_op_nbpas CHECK ((op_nbpas > 0)),
    CONSTRAINT ck_op_wetted_area CHECK ((op_wetted_area > (0)::double precision))
);


ALTER TABLE electrofishing.operation OWNER TO diaspara_admin;

--
-- Name: station; Type: TABLE; Schema: electrofishing; Owner: diaspara_admin
--

CREATE TABLE electrofishing.station (
    sta_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    sta_name text,
    sta_sta_id uuid,
    sta_dp_id integer,
    sta_id_original text NOT NULL,
    sta_country character varying(2),
    geom public.geometry
);


ALTER TABLE electrofishing.station OWNER TO diaspara_admin;

--
-- Name: batch_fish ba_id; Type: DEFAULT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish ALTER COLUMN ba_id SET DEFAULT public.uuid_generate_v4();


--
-- Name: batch_ope ba_id; Type: DEFAULT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope ALTER COLUMN ba_id SET DEFAULT public.uuid_generate_v4();


--
-- Name: data_provider dp_id; Type: DEFAULT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.data_provider ALTER COLUMN dp_id SET DEFAULT nextval('electrofishing.data_provider_dp_id_seq'::regclass);



--
-- Name: data_provider_dp_id_seq; Type: SEQUENCE SET; Schema: electrofishing; Owner: diaspara_admin
--

SELECT pg_catalog.setval('electrofishing.data_provider_dp_id_seq', 1, false);


--
-- Name: batch_fish batch_fish_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT batch_fish_pkey PRIMARY KEY (ba_id);


--
-- Name: batch_ope batch_op_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope
    ADD CONSTRAINT batch_op_pkey PRIMARY KEY (ba_id);


--
-- Name: batch batch_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (ba_id);


--
-- Name: biological_characteristic biological_characteristic_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.biological_characteristic
    ADD CONSTRAINT biological_characteristic_pkey PRIMARY KEY (bc_id);


--
-- Name: data_provider data_provider_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.data_provider
    ADD CONSTRAINT data_provider_pkey PRIMARY KEY (dp_id);


--
-- Name: gear_fishing gear_fishing_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.gear_fishing
    ADD CONSTRAINT gear_fishing_pkey PRIMARY KEY (gf_id);


--
-- Name: operation operation_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.operation
    ADD CONSTRAINT operation_pkey PRIMARY KEY (op_id);


--
-- Name: station station_pkey; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (sta_id);


--
-- Name: station uk_sta_id_original; Type: CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.station
    ADD CONSTRAINT uk_sta_id_original UNIQUE (sta_id_original);


--
-- Name: dbmig_batch_ix_ba_id; Type: INDEX; Schema: electrofishing; Owner: diaspara_admin
--

CREATE INDEX dbmig_batch_ix_ba_id ON electrofishing.batch USING btree (ba_id);


--
-- Name: dbmig_batch_ix_ba_ob_id; Type: INDEX; Schema: electrofishing; Owner: diaspara_admin
--

CREATE INDEX dbmig_batch_ix_ba_ob_id ON electrofishing.batch USING btree (ba_op_id);


--
-- Name: dbmig_biological_characteristic_ix_bc_ba_id; Type: INDEX; Schema: electrofishing; Owner: diaspara_admin
--

CREATE INDEX dbmig_biological_characteristic_ix_bc_ba_id ON electrofishing.biological_characteristic USING btree (bc_ba_id);


--
-- Name: electrofishing_station_ix_sta_id; Type: INDEX; Schema: electrofishing; Owner: diaspara_admin
--

CREATE INDEX electrofishing_station_ix_sta_id ON electrofishing.station USING btree (sta_id);


--
-- Name: index_geom; Type: INDEX; Schema: electrofishing; Owner: diaspara_admin
--

CREATE INDEX index_geom ON electrofishing.station USING gist (geom);


--
-- Name: batch fk_ba_ba_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT fk_ba_ba_id FOREIGN KEY (ba_ba_id) REFERENCES electrofishing.batch(ba_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_fish fk_ba_ba_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT fk_ba_ba_id FOREIGN KEY (ba_ba_id) REFERENCES electrofishing.batch_ope(ba_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch fk_ba_no_biol_char; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char) REFERENCES nomenclature.biological_characteristic_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_ope fk_ba_no_biol_char; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope
    ADD CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char) REFERENCES nomenclature.biological_characteristic_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_fish fk_ba_no_biol_char; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char) REFERENCES nomenclature.biological_characteristic_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch fk_ba_no_species; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species) REFERENCES nomenclature.species(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_ope fk_ba_no_species; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope
    ADD CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species) REFERENCES nomenclature.species(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_fish fk_ba_no_species; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species) REFERENCES nomenclature.species(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch fk_ba_no_stage; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage) REFERENCES nomenclature.stage(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_ope fk_ba_no_stage; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope
    ADD CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage) REFERENCES nomenclature.stage(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_fish fk_ba_no_stage; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage) REFERENCES nomenclature.stage(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch fk_ba_op_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch
    ADD CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) REFERENCES electrofishing.operation(op_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_ope fk_ba_op_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_ope
    ADD CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) REFERENCES electrofishing.operation(op_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: batch_fish fk_ba_op_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.batch_fish
    ADD CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) REFERENCES electrofishing.operation(op_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biological_characteristic fk_bc_no_biol_char; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.biological_characteristic
    ADD CONSTRAINT fk_bc_no_biol_char FOREIGN KEY (bc_no_biol_char) REFERENCES nomenclature.biological_characteristic_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biological_characteristic fk_bd_ba_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.biological_characteristic
    ADD CONSTRAINT fk_bd_ba_id FOREIGN KEY (bc_ba_id) REFERENCES electrofishing.batch_fish(ba_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: data_provider fk_dp_edmo_key; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.data_provider
    ADD CONSTRAINT fk_dp_edmo_key FOREIGN KEY (dp_edmo_key) REFERENCES ref."EDMO"("Key") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: gear_fishing fk_gf_dp_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.gear_fishing
    ADD CONSTRAINT fk_gf_dp_id FOREIGN KEY (gf_dp_id) REFERENCES electrofishing.data_provider(dp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishing fk_gf_no_effort_type; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.gear_fishing
    ADD CONSTRAINT fk_gf_no_effort_type FOREIGN KEY (gf_no_effort_type) REFERENCES nomenclature.effort_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishing fk_gf_no_gear_type; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.gear_fishing
    ADD CONSTRAINT fk_gf_no_gear_type FOREIGN KEY (gf_no_gear_type) REFERENCES nomenclature.gear_type(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishing fk_gf_sta_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.gear_fishing
    ADD CONSTRAINT fk_gf_sta_id FOREIGN KEY (gf_sta_id) REFERENCES electrofishing.station(sta_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: operation fk_op_dp_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.operation
    ADD CONSTRAINT fk_op_dp_id FOREIGN KEY (op_dp_id) REFERENCES electrofishing.data_provider(dp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: operation fk_op_method; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.operation
    ADD CONSTRAINT fk_op_method FOREIGN KEY (op_no_method) REFERENCES nomenclature.scientific_observation_method(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: operation fk_op_no_efishing_mean; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.operation
    ADD CONSTRAINT fk_op_no_efishing_mean FOREIGN KEY (op_no_efishing_mean) REFERENCES nomenclature.electrofishing_mean(no_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: operation fk_op_sta_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.operation
    ADD CONSTRAINT fk_op_sta_id FOREIGN KEY (op_sta_id) REFERENCES electrofishing.station(sta_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: station fk_sta_dp_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.station
    ADD CONSTRAINT fk_sta_dp_id FOREIGN KEY (sta_dp_id) REFERENCES electrofishing.data_provider(dp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: station fk_sta_sta_id; Type: FK CONSTRAINT; Schema: electrofishing; Owner: diaspara_admin
--

ALTER TABLE ONLY electrofishing.station
    ADD CONSTRAINT fk_sta_sta_id FOREIGN KEY (sta_sta_id) REFERENCES electrofishing.station(sta_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA electrofishing; Type: ACL; Schema: -; Owner: diaspara_admin
--

GRANT USAGE ON SCHEMA electrofishing TO diaspara_read;


--
-- Name: FUNCTION fk_id_batch_insert(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.fk_id_batch_insert() TO diaspara_read;


--
-- Name: FUNCTION fk_id_environmental_characteristic_insert(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.fk_id_environmental_characteristic_insert() TO diaspara_read;


--
-- Name: FUNCTION fk_id_observations_insert(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.fk_id_observations_insert() TO diaspara_read;


--
-- Name: FUNCTION integrity_observations_verify(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.integrity_observations_verify() TO diaspara_read;


--
-- Name: FUNCTION observation_id_place_insert(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.observation_id_place_insert() TO diaspara_read;


--
-- Name: FUNCTION observation_id_place_update(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.observation_id_place_update() TO diaspara_read;


--
-- Name: FUNCTION observations_id_insert(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.observations_id_insert() TO diaspara_read;


--
-- Name: FUNCTION observations_id_update(); Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT ALL ON FUNCTION electrofishing.observations_id_update() TO diaspara_read;


--
-- Name: TABLE batch; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.batch TO diaspara_read;


--
-- Name: TABLE batch_fish; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.batch_fish TO diaspara_read;


--
-- Name: TABLE batch_ope; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.batch_ope TO diaspara_read;


--
-- Name: TABLE biological_characteristic; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.biological_characteristic TO diaspara_read;


--
-- Name: TABLE data_provider; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.data_provider TO diaspara_read;


--
-- Name: TABLE gear_fishing; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.gear_fishing TO diaspara_read;


--
-- Name: TABLE operation; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.operation TO diaspara_read;


--
-- Name: TABLE station; Type: ACL; Schema: electrofishing; Owner: diaspara_admin
--

GRANT SELECT ON TABLE electrofishing.station TO diaspara_read;


--
-- PostgreSQL database dump complete
--

