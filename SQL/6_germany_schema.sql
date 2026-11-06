-- ***************************************************
-- Creating schema Germany (with diaspara_admin right)
-- ***************************************************

CREATE SCHEMA electrofishing_de;
ALTER SCHEMA electrofishing_de OWNER TO diaspara_admin;
GRANT USAGE ON SCHEMA electrofishing_de TO diaspara_read;
COMMENT ON SCHEMA electrofishing_de is 'Electrofishing data from Germany';



-- TABLE: electrofishing_de.data_provider definition
-- DROP TABLE electrofishing_de.data_provider CASCADE;

CREATE TABLE electrofishing_de.data_provider (
	CONSTRAINT data_provider_pkey PRIMARY KEY (dp_id),
	CONSTRAINT fk_dp_edmo_key FOREIGN KEY (dp_edmo_key) 
		REFERENCES "ref"."EDMO"("Key") ON DELETE RESTRICT ON UPDATE CASCADE
)
INHERITS (electrofishing.data_provider);

-- ALTER TABLE electrofishing_de.data_provider ADD CONSTRAINT fk_dp_edmo_key FOREIGN KEY (dp_edmo_key) 
		-- REFERENCES "ref"."EDMO"("Key") ON DELETE RESTRICT ON UPDATE CASCADE   

-- set owner/read rigths
ALTER TABLE electrofishing_de.data_provider OWNER TO diaspara_admin;
GRANT SELECT ON TABLE electrofishing_de.data_provider TO diaspara_read;


-------------------------------------------------------------------------------


-- TABLE: electrofishing_de.station definition
-- DROP TABLE electrofishing_de.station CASCADE;

CREATE TABLE electrofishing_de.station (
sta_bundesland TEXT,
sta_water_name TEXT,
sta_wk_id TEXT,
sta_n_operations BIGINT,
sta_coord_spread_m BIGINT,
	CONSTRAINT station_pkey PRIMARY KEY (sta_id),
	CONSTRAINT uk_sta_id_original UNIQUE (sta_id_original),
	CONSTRAINT fk_sta_dp_id FOREIGN KEY (sta_dp_id) 
		REFERENCES electrofishing_de.data_provider(dp_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_sta_sta_id FOREIGN KEY (sta_sta_id) 
		REFERENCES electrofishing_de.station(sta_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.station);


-- ALTER TABLE electrofishing_de.station ADD CONSTRAINT fk_sta_dp_id FOREIGN KEY (sta_dp_id) 
		-- REFERENCES electrofishing_de.data_provider(dp_id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX electrofishing_station_ix_sta_id ON electrofishing_de.station USING btree (sta_id);
CREATE INDEX index_geom ON electrofishing_de.station USING gist (geom);


--------------------------------------------------------------------------------


-- TABLE: electrofishing_de.operation definition
-- DROP TABLE electrofishing_de.operation CASCADE;

CREATE TABLE electrofishing_de.operation (
op_bundesland TEXT,
op_water_name TEXT,
op_wk_id TEXT,
op_stretch_id BIGINT,
op_stretch_name TEXT,
op_x NUMERIC,
op_y NUMERIC,
op_method_original TEXT,
op_method_label TEXT,
op_method_other TEXT,
op_gear_type TEXT,
op_coor_type TEXT,
op_area_source TEXT,
op_wetted_width_m NUMERIC,
op_mean_depth_m NUMERIC,
op_volume_m3 NUMERIC,
op_turbidity TEXT,
op_secchi_depth TEXT,
op_fish_region TEXT,
	CONSTRAINT ck_op_duration CHECK ((op_duration > (0)::double precision)),
	CONSTRAINT ck_op_fished_length CHECK ((op_fished_length > (0)::double precision)),
	CONSTRAINT ck_op_fished_width CHECK ((op_fished_width > (0)::double precision)),
	CONSTRAINT ck_op_nbpas CHECK ((op_nbpas > 0)),
	CONSTRAINT ck_op_wetted_area CHECK ((op_wetted_area > (0)::double precision)),
	CONSTRAINT operation_pkey PRIMARY KEY (op_id),
	CONSTRAINT fk_op_dp_id FOREIGN KEY (op_dp_id) 
		REFERENCES electrofishing_de.data_provider(dp_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_op_method FOREIGN KEY (op_no_method) 
		REFERENCES nomenclature.scientific_observation_method(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_op_no_efishing_mean FOREIGN KEY (op_no_efishing_mean) 
		REFERENCES nomenclature.electrofishing_mean(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_op_sta_id FOREIGN KEY (op_sta_id) 
		REFERENCES electrofishing_de.station(sta_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.operation);


------------------------------------------------------------------------------------------------------------


-- electrofishing_de.gear_fishing definition
-- DROP TABLE electrofishing_de.gear_fishing CASCADE;

CREATE TABLE electrofishing_de.gear_fishing (
gf_bundesland TEXT,
gf_water_name TEXT,
gf_wk_id TEXT,
gf_x NUMERIC,
gf_y NUMERIC,
gf_coord_type TEXT,
gf_gear_original TEXT,
gf_method_other TEXT,
gf_stretch_name TEXT,
gf_stretch_length_m NUMERIC,
gf_project TEXT,
gf_haul_nr BIGINT,
gf_season TEXT,
gf_time_start TIME,
gf_duration_h NUMERIC,
gf_net_aperture_m2 NUMERIC,
gf_mesh_mm NUMERIC,
gf_tidal_state TEXT,
gf_salinity TEXT,
gf_river_km NUMERIC,
gf_mean_depth_m NUMERIC,
	CONSTRAINT ck_gf_gear_number CHECK ((gf_gear_number > 0)),
	CONSTRAINT ck_gf_gf_effort_value CHECK ((gf_effort_value > (0)::double precision)),
	CONSTRAINT gear_fishing_pkey PRIMARY KEY (gf_id),
	CONSTRAINT fk_gf_dp_id FOREIGN KEY (gf_dp_id) 
		REFERENCES electrofishing_de.data_provider(dp_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_gf_no_effort_type FOREIGN KEY (gf_no_effort_type) 
		REFERENCES nomenclature.effort_type(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_gf_no_gear_type FOREIGN KEY (gf_no_gear_type) 
		REFERENCES nomenclature.gear_type(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_gf_sta_id FOREIGN KEY (gf_sta_id) 
		REFERENCES electrofishing_de.station(sta_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.gear_fishing);



------------------------------------------------------------------------------------------------------------


-- electrofishing_de.batch_ope definition
-- DROP TABLE electrofishing_de.batch_ope CASCADE;


CREATE TABLE electrofishing_de.batch_ope (
	ba_gf_id_original TEXT,
	ba_species_name TEXT,
	ba_species_de TEXT,
	CONSTRAINT batch_op_pkey PRIMARY KEY (ba_id),
	CONSTRAINT c_ck_ba_ba_id CHECK ((ba_ba_id IS NULL)),
	CONSTRAINT c_ck_ba_batch_level CHECK ((ba_batch_level = 1)),
	CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char) 
		REFERENCES nomenclature.biological_characteristic_type(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species) 
		REFERENCES nomenclature.species(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage) 
		REFERENCES nomenclature.stage(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) 
		REFERENCES electrofishing_de.operation(op_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.batch_ope);


------------------------------------------------------------------------------------------------------------


-- TABLE: electrofishing_de.batch_fish definition
-- DROP TABLE electrofishing_de.batch_fish;

CREATE TABLE electrofishing_de.batch_fish (
ba_gf_id_original TEXT,
ba_species_name TEXT,
ba_species_de TEXT,
entry_type TEXT,
stage_original TEXT,
remarks TEXT,
	CONSTRAINT batch_fish_pkey PRIMARY KEY (ba_id),
	CONSTRAINT c_ck_ba_batch_level CHECK ((ba_batch_level = 2)),
	CONSTRAINT fk_ba_ba_id FOREIGN KEY (ba_ba_id) 
		REFERENCES electrofishing_de.batch_ope(ba_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char) 
		REFERENCES nomenclature.biological_characteristic_type(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species) 
		REFERENCES nomenclature.species(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage) 
		REFERENCES nomenclature.stage(no_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) 
		REFERENCES electrofishing_de.operation(op_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.batch_fish);


------------------------------------------------------------------------------------------------------------

-- TABLE: electrofishing_de.biological_characteristic definition
DROP TABLE electrofishing_de.biological_characteristic;

CREATE TABLE electrofishing_de.biological_characteristic (
	CONSTRAINT biological_characteristic_pkey PRIMARY KEY (bc_id),
	CONSTRAINT fk_bc_no_biol_char FOREIGN KEY (bc_no_biol_char) 
		REFERENCES nomenclature.biological_characteristic_type(no_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_bd_ba_id FOREIGN KEY (bc_ba_id) 
		REFERENCES electrofishing_de.batch_fish(ba_id) ON DELETE CASCADE ON UPDATE CASCADE
)
INHERITS (electrofishing.biological_characteristic);

CREATE INDEX dbmig_biological_characteristic_ix_bc_ba_id ON electrofishing_de.biological_characteristic USING btree (bc_ba_id);
