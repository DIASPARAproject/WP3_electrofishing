 
  
 -- Electrofishing

--Create age table 

-- nomenclature.sex definition

-- Drop table

-- DROP TABLE nomenclature.sex;

CREATE TABLE nomenclature.age (
  CONSTRAINT age_id PRIMARY KEY (no_id)
)
INHERITS (nomenclature.nomenclature);

CREATE SEQUENCE seq;
SELECT SETVAL('seq', (SELECT max(no_id)+1 FROM nomenclature.nomenclature)); --344


DELETE FROM nomenclature.age 
INSERT INTO nomenclature.age (no_id,no_code,no_type,no_name)
  SELECT 
  nextval('seq') AS no_id,
  age_code AS no_code,
  'age' AS no_type,
  age_description AS no_name
  FROM ref.tr_age_age; --11

--Create maturity table 
  
CREATE TABLE nomenclature.maturity (
  CONSTRAINT maturity_id PRIMARY KEY (no_id)
)
INHERITS (nomenclature.nomenclature);  

SELECT SETVAL('seq', (SELECT max(no_id)+1 FROM nomenclature.nomenclature)); --346

INSERT INTO nomenclature.maturity (no_id,no_code,no_type,no_name)
  SELECT 
  nextval('seq') AS no_id,
  mat_code AS no_code,
  'maturity' AS no_type,
  mat_description AS no_name
  FROM ref.tr_maturity_mat ; --12

-- sex  
  
 /* 
180   Sex Unknown
181   Sex male
182   Sex female
183   Sex Unidentifed-- stage
*/
SELECT SETVAL('seq', (SELECT max(no_id)+1 FROM nomenclature.nomenclature)); --359  
SELECT * FROM "ref".tr_sex_sex
SELECT * FROM nomenclature.sex
INSERT INTO nomenclature.sex SELECT * FROM nomenclature_eda.sex; --4
UPDATE nomenclature.sex SET (no_code, no_name) = ('F', 'Female') WHERE no_id=182; 
UPDATE nomenclature.sex SET (no_code, no_name) = ('M', 'Male') WHERE no_id=181;   
INSERT INTO nomenclature.sex 
SELECT 
nextval('seq') AS no_id,
  sex_code AS no_code,
  'sex' AS no_type,
  sex_description AS no_name
FROM "ref".tr_sex_sex WHERE sex_code NOT IN ('F', 'M'); --5

UPDATE nomenclature.sex SET no_type='sex';
DELETE FROM nomenclature.sex WHERE no_id IN (180,183); --2 THESE ARE NO LONGER IN THE DB OK FOR COMPATIBILITY WITH SUDOANG :: will blocK ...

-- stage

/*
224   Stage Unknown
225   Stage Glass eel
226   Stage Yellow eel
227   Stage Silver eel
228   Stage Glass & yellow eel mixed
229   Stage Yellow & silver eel mixed
230   Stage G, Y & S eel mixed
*/
SELECT SETVAL('seq', (SELECT max(no_id)+1 FROM nomenclature.nomenclature)); --365  
SELECT * FROM "ref".tr_lifestage_lfs; 
SELECT * FROM nomenclature.stage;
INSERT INTO nomenclature.stage SELECT * FROM nomenclature_eda.stage; --7
ALTER TABLE nomenclature.stage ADD COLUMN spe_code CHARACTER VARYING(3);
ALTER TABLE nomenclature.species ADD CONSTRAINT uk_no_code UNIQUE(no_code);
ALTER TABLE nomenclature.stage ADD CONSTRAINT fk_species FOREIGN KEY (spe_code)
REFERENCES nomenclature.species(no_code) ON UPDATE CASCADE ON DELETE RESTRICT;

UPDATE nomenclature.stage SET (no_code, spe_code) = ('G', 'ANG') WHERE no_id =225 ;
UPDATE nomenclature.stage SET (no_code, spe_code) = ('Y', 'ANG') WHERE no_id =226 ;
UPDATE nomenclature.stage SET (no_code, spe_code) = ('S', 'ANG') WHERE no_id =227 ; 
UPDATE nomenclature.stage SET (no_code, spe_code) = ('GY', 'ANG') WHERE no_id =228 ; 
UPDATE nomenclature.stage SET (no_code, spe_code) = ('YS', 'ANG') WHERE no_id =229 ; 
UPDATE nomenclature.stage SET (no_code, spe_code) = ('AL', 'ANG') WHERE no_id =230 ; 
DELETE FROM nomenclature.stage WHERE no_id = 224;


INSERT INTO nomenclature.stage 
SELECT nextval('seq') AS no_id,
  lfs_code AS no_code,
  'stage' AS no_type,
  lfs_name AS no_name, 
  lfs_spe_code AS spe_code
FROM "ref".tr_lifestage_lfs 
WHERE lfs_spe_code IN ('SAL', 'TRS');--20


-- scientific_observation_method  
  
INSERT INTO nomenclature.scientific_observation_method  SELECT * FROM nomenclature_eda.scientific_observation_method; --16
UPDATE nomenclature.scientific_observation_method SET no_type = 'scientific_observation_method'; --16
SELECT * FROM nomenclature.scientific_observation_method;
--remove migration monitoring
--remove NA
DELETE FROM nomenclature.scientific_observation_method WHERE no_id IN (60,69);--2
--WH needs to be changed by Standard by foot (and then checked how many pass is done)
UPDATE nomenclature.scientific_observation_method SET (no_code, no_name, sc_definition) =
('ST', 'Standard by foot', 'Electrofishing by foot, specify the number of pass') WHERE no_id = 62;
UPDATE nomenclature.scientific_observation_method SET (no_code, no_name, sc_definition) =
('EE', 'Standard eel', 'Electrofishing by foot, eel specific, specify the number of pass') WHERE no_id = 302;

--electrofishing_mean OK
INSERT INTO nomenclature.electrofishing_mean  SELECT * FROM nomenclature_eda.electrofishing_mean; --4
UPDATE nomenclature.electrofishing_mean SET no_type = 'electrofishing_mean'; --16
SELECT * FROM nomenclature.electrofishing_mean;


-- -- data provider can reference EDMO if exists otherwise not
DROP TABLE IF EXISTS electrofishing.data_provider CASCADE;
CREATE TABLE electrofishing.data_provider (
  dp_id serial4 NOT NULL,
  dp_name varchar(60) NULL,
  dp_edmo_key int4 NULL,
  CONSTRAINT fk_dp_edmo_key FOREIGN KEY (dp_edmo_key) 
  REFERENCES ref."EDMO"("Key") ON UPDATE CASCADE ON DELETE RESTRICT,
  dp_establishment_name TEXT,
  CONSTRAINT data_provider_pkey PRIMARY KEY (dp_id)  
);


-- electrofishing.station definition

-- Drop table

-- DROP TABLE electrofishing.station;
-- TODO nomenclature country and foreign key 

DROP TABLE IF EXISTS electrofishing.station;
CREATE TABLE electrofishing.station (
  sta_id uuid DEFAULT uuid_generate_v4() NOT NULL,  
  sta_name text NULL,
  sta_sta_id uuid NULL,
  sta_dp_id int4 NULL,
  sta_id_original text NOT NULL,
  sta_country varchar(2) NULL,
  geom public.geometry NULL,
  CONSTRAINT station_pkey PRIMARY KEY (sta_id),
  CONSTRAINT uk_sta_id_original UNIQUE (sta_id_original),
  CONSTRAINT fk_sta_sta_id FOREIGN KEY (sta_sta_id) 
  REFERENCES electrofishing.station(sta_id) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_sta_dp_id FOREIGN KEY (sta_dp_id) 
  REFERENCES electrofishing.data_provider(dp_id) 
  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX electrofishing_station_ix_sta_id ON electrofishing.station USING btree (sta_id);
CREATE INDEX index_geom ON electrofishing.station USING gist (geom);

DROP TABLE IF EXISTS electrofishing.operation;
CREATE TABLE electrofishing.operation(
  op_id uuid DEFAULT uuid_generate_v4() NOT NULL,
  op_id_original TEXT NULL,
  op_sta_id uuid NOT NULL,
  op_starting_date date NOT NULL,
  op_ending_date date NULL,
  op_dp_id int4 NOT NULL,
  op_no_method int4 NULL,
  op_no_efishing_mean int4 NULL,
  op_wetted_area float4 NULL,
  op_fished_length float4 NULL,
  op_fished_width float4 NULL,
  op_duration float8 NULL,
  op_nbpas int4 NULL,
  CONSTRAINT operation_pkey PRIMARY KEY (op_id),
  CONSTRAINT fk_op_sta_id FOREIGN KEY (op_sta_id)
  REFERENCES electrofishing.station(sta_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_op_dp_id FOREIGN KEY (op_dp_id) 
  REFERENCES electrofishing.data_provider(dp_id) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_op_method FOREIGN KEY (op_no_method) 
  REFERENCES nomenclature.scientific_observation_method(no_id) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_op_no_efishing_mean FOREIGN KEY (op_no_efishing_mean) 
  REFERENCES nomenclature.electrofishing_mean(no_id) 
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_op_wetted_area CHECK (op_wetted_area >0),
  CONSTRAINT ck_op_nbpas CHECK (op_nbpas >0),
  CONSTRAINT ck_op_fished_length CHECK (op_fished_length >0),
  CONSTRAINT ck_op_fished_width CHECK (op_fished_width >0),
  CONSTRAINT ck_op_duration CHECK (op_duration >0)
);


-- electrofishing.batch definition

DROP TABLE IF EXISTS electrofishing.batch;
CREATE TABLE electrofishing.batch (
  ba_id uuid DEFAULT uuid_generate_v4() NOT NULL,
  ba_op_id uuid NOT NULL,
  ba_ba_id uuid NULL,
  ba_id_original TEXT NULL,
  ba_no_species int4 NULL,
  ba_no_stage int4 NULL,
  ba_no_biol_char int4 NULL,
  ba_quantity float4 NULL,
  ba_batch_level int4 NULL,
  CONSTRAINT batch_pkey PRIMARY KEY (ba_id),
  CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) 
  REFERENCES electrofishing.operation(op_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_ba_id FOREIGN KEY (ba_ba_id)
  REFERENCES electrofishing.batch(ba_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species)
  REFERENCES nomenclature.species(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage)
  REFERENCES nomenclature.stage(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char)
  REFERENCES nomenclature.biological_characteristic_type(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX dbmig_batch_ix_ba_id ON electrofishing.batch USING btree (ba_id);
CREATE INDEX dbmig_batch_ix_ba_ob_id ON electrofishing.batch USING btree (ba_op_id);

DROP TABLE IF EXISTS electrofishing.batch_ope;
CREATE TABLE  electrofishing.batch_ope (
  CONSTRAINT batch_op_pkey PRIMARY KEY (ba_id),
  CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) 
  REFERENCES electrofishing.operation(op_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species)
  REFERENCES nomenclature.species(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage)
  REFERENCES nomenclature.stage(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char)
  REFERENCES nomenclature.biological_characteristic_type(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT c_ck_ba_batch_level CHECK (ba_batch_level = 1),
  CONSTRAINT c_ck_ba_ba_id CHECK (ba_ba_id IS NULL)
) INHERITS (electrofishing.batch);

DROP TABLE IF EXISTS electrofishing.batch_fish;
CREATE TABLE  electrofishing.batch_fish (
  CONSTRAINT batch_fish_pkey PRIMARY KEY (ba_id),
  CONSTRAINT fk_ba_op_id FOREIGN KEY (ba_op_id) 
  REFERENCES electrofishing.operation(op_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_ba_id FOREIGN KEY (ba_ba_id)
  REFERENCES electrofishing.batch_ope(ba_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_species FOREIGN KEY (ba_no_species)
  REFERENCES nomenclature.species(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_stage FOREIGN KEY (ba_no_stage)
  REFERENCES nomenclature.stage(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ba_no_biol_char FOREIGN KEY (ba_no_biol_char)
  REFERENCES nomenclature.biological_characteristic_type(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT c_ck_ba_batch_level CHECK (ba_batch_level = 2)  
) INHERITS (electrofishing.batch);


DROP TABLE IF EXISTS electrofishing.biological_characteristic;
CREATE TABLE electrofishing.biological_characteristic (
  bc_id uuid DEFAULT uuid_generate_v4() NOT NULL,
  bc_ba_id uuid NOT NULL,
  bc_no_biol_char int4 NOT NULL,
  bc_numvalue float4 NULL,
  CONSTRAINT biological_characteristic_pkey PRIMARY KEY (bc_id),
  CONSTRAINT fk_bd_ba_id FOREIGN KEY (bc_ba_id)
  REFERENCES electrofishing.batch_fish (ba_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_bc_no_biol_char FOREIGN KEY (bc_no_biol_char)
  REFERENCES nomenclature.biological_characteristic_type(no_id)
  ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX dbmig_biological_characteristic_ix_bc_ba_id ON electrofishing.biological_characteristic (bc_ba_id);


INSERT INTO nomenclature.gear_type SELECT * FROM nomenclature_eda.gear_type ; --74


CREATE TABLE nomenclature.effort_type (
  CONSTRAINT effort_type_id PRIMARY KEY (no_id)
)
INHERITS (nomenclature.nomenclature);

-- Table Triggers

CREATE TRIGGER tr_effort_insert BEFORE INSERT ON
nomenclature.effort_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_insert();
CREATE TRIGGER tr_effort_update BEFORE UPDATE ON
nomenclature.effort_type FOR EACH ROW EXECUTE FUNCTION nomenclature.nomenclature_id_update();

INSERT INTO nomenclature.effort_type SELECT * FROM nomenclature_eda.effort_type ; --7

SELECT * FROM nomenclature.effort_type;
UPDATE nomenclature.effort_type SET (no_code, no_name) = ('nrd', 'Number of day (nr day)') WHERE no_id = 101;
UPDATE nomenclature.effort_type SET (no_code, no_name) = ('nd', 'Net-days (nd)') WHERE no_id = 104;
UPDATE nomenclature.effort_type SET (no_code, no_name) = ('gd', 'Gear-days (Fyke net, traps)') WHERE no_id = 100;
UPDATE nomenclature.effort_type SET no_code = 'm2' WHERE no_id = 102;
DELETE FROM nomenclature.effort_type WHERE no_id = 105;

DROP TABLE IF EXISTS electrofishing.gear_fishing;
CREATE TABLE electrofishing.gear_fishing (
  gf_id uuid DEFAULT uuid_generate_v4() NOT NULL,
  gf_id_original TEXT NULL,
  gf_sta_id uuid NOT NULL,
  gf_starting_date date NOT NULL,
  gf_ending_date date NULL,
  gf_dp_id int4 NOT NULL,  
  gf_no_gear_type int4 NULL,
  gf_gear_number int4 NULL,
  gf_no_effort_type int4 NULL,
  gf_effort_value float4 NULL , 
  CONSTRAINT gear_fishing_pkey PRIMARY KEY (gf_id),
  CONSTRAINT fk_gf_sta_id FOREIGN KEY (gf_sta_id)
   REFERENCES electrofishing.station(sta_id)
   ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_gf_dp_id FOREIGN KEY (gf_dp_id) 
   REFERENCES electrofishing.data_provider(dp_id) 
   ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_gf_no_gear_type FOREIGN KEY (gf_no_gear_type)
   REFERENCES nomenclature.gear_type (no_id)
   ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_gf_no_effort_type FOREIGN KEY (gf_no_effort_type)
   REFERENCES nomenclature.effort_type (no_id)
   ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_gf_gear_number CHECK (gf_gear_number>0),
  CONSTRAINT ck_gf_gf_effort_value CHECK (gf_effort_value>0)
);
