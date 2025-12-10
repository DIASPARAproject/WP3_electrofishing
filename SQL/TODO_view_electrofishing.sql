--
-- TOC entry 373 (class 1259 OID 2558481)
-- Name: view_electrofishing; Type: VIEW; Schema: dbmig; Owner: postgres
--

CREATE VIEW dbmig.view_electrofishing AS
 SELECT row_number() OVER () AS id,
    ob.op_id,
    ob.op_gis_layername,
    ob.op_placename,
    ob.ob_id,
    ob.ob_starting_date,
    ob.ef_wetted_area,
    ob.ef_nbpas,
    ob.ef_fished_length,
    ob.ef_fished_width,
    o1.no_name AS ob_origin,
    o2.no_name AS ob_type,
    o3.no_name AS ob_period,
    o4.no_name AS ef_fishingmethod,
    o5.no_name AS ef_electrofishing_mean,
    ob.dp_name AS ob_dp_name,
    ba1.ba_quantity AS density,
    ba2.ba_quantity AS totalnumber,
    ba3.ba_quantity AS nbp1,
    ba4.ba_quantity AS nbp2,
    ba5.ba_quantity AS nbp3,
    bc.count AS nb_size_measured,
    ob.the_geom
   FROM (((((((((((( SELECT observation_places.op_id,
            observation_places.op_gis_systemname,
            observation_places.op_gis_layername,
            observation_places.op_gislocation,
            observation_places.op_placename,
            observation_places.op_no_observationplacetype,
            observation_places.op_op_id,
            observation_places.the_geom,
            electrofishing.ob_id,
            electrofishing.ob_no_origin,
            electrofishing.ob_no_type,
            electrofishing.ob_no_period,
            electrofishing.ob_starting_date,
            electrofishing.ob_ending_date,
            electrofishing.ob_op_id,
            electrofishing.ob_dp_id,
            electrofishing.ef_no_fishingmethod,
            electrofishing.ef_no_electrofishing_mean,
            electrofishing.ef_wetted_area,
            electrofishing.ef_fished_length,
            electrofishing.ef_fished_width,
            electrofishing.ef_duration,
            electrofishing.ef_nbpas,
            data_provider.dp_id,
            data_provider.dp_name,
            data_provider.dp_et_id
           FROM ((dbmig.observation_places
             JOIN dbmig.electrofishing ON ((observation_places.op_id = electrofishing.ob_op_id)))
             JOIN dbmig.data_provider ON ((data_provider.dp_id = electrofishing.ob_dp_id)))) ob
     JOIN dbmig_nomenclature.nomenclature o1 ON ((ob.ob_no_origin = o1.no_id)))
     JOIN dbmig_nomenclature.nomenclature o2 ON ((ob.ob_no_type = o2.no_id)))
     JOIN dbmig_nomenclature.nomenclature o3 ON ((ob.ob_no_period = o3.no_id)))
     JOIN dbmig_nomenclature.nomenclature o4 ON ((ob.ef_no_fishingmethod = o4.no_id)))
     JOIN dbmig_nomenclature.nomenclature o5 ON ((ob.ef_no_electrofishing_mean = o5.no_id)))
     LEFT JOIN ( SELECT ba.ba_ob_id,
            ba.ba_quantity,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Density'::text))) ba1 ON ((ba1.ba_ob_id = ob.ob_id)))
     LEFT JOIN ( SELECT ba.ba_ob_id,
            ba.ba_quantity,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Number'::text) AND (ba.ba_batch_level = 1))) ba2 ON ((ba2.ba_ob_id = ob.ob_id)))
     LEFT JOIN ( SELECT ba.ba_ob_id,
            ba.ba_quantity,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Number p1'::text))) ba3 ON ((ba3.ba_ob_id = ob.ob_id)))
     LEFT JOIN ( SELECT ba.ba_ob_id,
            ba.ba_quantity,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Number p2'::text))) ba4 ON ((ba4.ba_ob_id = ob.ob_id)))
     LEFT JOIN ( SELECT ba.ba_ob_id,
            ba.ba_quantity,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Number p3'::text))) ba5 ON ((ba5.ba_ob_id = ob.ob_id)))
     LEFT JOIN ( SELECT electrofishing.ob_id,
            count(*) AS count
           FROM ((dbmig.electrofishing
             JOIN dbmig.batch ON ((electrofishing.ob_id = batch.ba_ob_id)))
             JOIN dbmig.biological_characteristic ON ((biological_characteristic.bc_ba_id = batch.ba_id)))
          WHERE (biological_characteristic.bc_no_characteristic_type = 39)
          GROUP BY electrofishing.ob_id) bc ON ((bc.ob_id = ob.ob_id)));


ALTER TABLE dbmig.view_electrofishing OWNER TO diaspara_admin;

--
-- TOC entry 377 (class 1259 OID 2558495)
-- Name: view_electrofishing_size; Type: VIEW; Schema: dbmig; Owner: postgres
--

CREATE VIEW dbmig.view_electrofishing_size AS
 WITH ba_number AS (
         SELECT ba.ba_ob_id,
            ba.ba_quantity AS totalnumber,
            ba.ba_batch_level,
            ba.ba_species,
            ba.ba_stage,
            ba.ba_value_type,
            ba.ba_biological_characteristic_type,
            ba.ba_individual_status
           FROM ( SELECT batch.ba_ob_id,
                    batch.ba_quantity,
                    batch.ba_batch_level,
                    b1.no_name AS ba_species,
                    b2.no_name AS ba_stage,
                    b3.no_name AS ba_value_type,
                    b4.no_name AS ba_biological_characteristic_type,
                    b5.no_name AS ba_individual_status
                   FROM (((((dbmig.batch
                     JOIN dbmig_nomenclature.nomenclature b1 ON ((batch.ba_no_species = b1.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b2 ON ((batch.ba_no_stage = b2.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b3 ON ((batch.ba_no_value_type = b3.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b4 ON ((batch.ba_no_biological_characteristic_type = b4.no_id)))
                     JOIN dbmig_nomenclature.nomenclature b5 ON ((batch.ba_no_individual_status = b5.no_id)))) ba
          WHERE (((ba.ba_species)::text = 'Anguilla anguilla'::text) AND (((ba.ba_stage)::text = 'Yellow eel'::text) OR ((ba.ba_stage)::text = 'Yellow & silver eel mixed'::text) OR ((ba.ba_stage)::text = 'G, Y & S eel mixed'::text)) AND ((ba.ba_biological_characteristic_type)::text = 'Number'::text) AND (ba.ba_batch_level = 1))
        ), taille AS (
         SELECT data_provider.dp_name,
            electrofishing.ob_id,
            bc.bc_id,
            bc.bc_ba_id,
            bc.bc_no_characteristic_type,
            bc.bc_no_value_type,
            bc.bc_numvalue,
            ba_number.totalnumber
           FROM ((((((((dbmig.biological_characteristic bc
             JOIN dbmig.batch ON ((bc.bc_ba_id = batch.ba_id)))
             JOIN dbmig.electrofishing ON ((batch.ba_ob_id = electrofishing.ob_id)))
             JOIN ba_number ON ((ba_number.ba_ob_id = electrofishing.ob_id)))
             JOIN dbmig.observation_places ON ((electrofishing.ob_op_id = observation_places.op_id)))
             JOIN dbmig.data_provider ON ((electrofishing.ob_dp_id = data_provider.dp_id)))
             JOIN dbmig_nomenclature.biological_characteristic_type ON ((bc.bc_no_characteristic_type = biological_characteristic_type.no_id)))
             JOIN dbmig_nomenclature.species ON ((batch.ba_no_species = species.no_id)))
             JOIN dbmig_nomenclature.value_type ON ((batch.ba_no_value_type = value_type.no_id)))
          WHERE (((species.no_name)::text = 'Anguilla anguilla'::text) AND ((biological_characteristic_type.no_name)::text = 'Length'::text) AND ((value_type.no_name)::text = 'Raw data or Individual data'::text) AND (bc.bc_numvalue > (50)::double precision) AND (bc.bc_numvalue < (1400)::double precision))
        ), test AS (
         SELECT taille.dp_name,
            taille.ob_id,
            min(taille.bc_numvalue) AS min,
            max(taille.bc_numvalue) AS max,
            count(*) AS count,
            taille.totalnumber
           FROM taille
          GROUP BY taille.ob_id, taille.dp_name, taille.totalnumber
        ), diag AS (
         SELECT test.ob_id,
                CASE
                    WHEN ((test.totalnumber < (10)::double precision) AND ((test.count)::double precision = test.totalnumber)) THEN 'ok1'::text
                    WHEN ((test.totalnumber >= (10)::double precision) AND ((test.count)::double precision >= ((0.80)::double precision * test.totalnumber))) THEN 'ok2'::text
                    WHEN ((test.totalnumber >= (50)::double precision) AND (test.count >= 30)) THEN 'ok3'::text
                    ELSE 'no'::text
                END AS diagnostic
           FROM test
          ORDER BY test.dp_name
        ), selected_length AS (
         SELECT taille.ob_id,
            taille.dp_name,
            taille.bc_id,
            taille.bc_ba_id,
            taille.bc_no_characteristic_type,
            taille.bc_no_value_type,
            taille.bc_numvalue,
            taille.totalnumber,
            diag.diagnostic
           FROM (taille
             JOIN diag USING (ob_id))
          WHERE (diag.diagnostic <> 'no'::text)
        ), length_class AS (
         SELECT selected_length.ob_id,
            selected_length.dp_name,
            selected_length.bc_id,
            selected_length.bc_ba_id,
            selected_length.bc_no_characteristic_type,
            selected_length.bc_no_value_type,
            selected_length.bc_numvalue,
            selected_length.totalnumber,
            selected_length.diagnostic,
                CASE
                    WHEN (selected_length.bc_numvalue < (50)::double precision) THEN '0 - error'::text
                    WHEN ((selected_length.bc_numvalue >= (50)::double precision) AND (selected_length.bc_numvalue < (150)::double precision)) THEN '1 - <150'::text
                    WHEN ((selected_length.bc_numvalue >= (150)::double precision) AND (selected_length.bc_numvalue < (300)::double precision)) THEN '2 - [150-300['::text
                    WHEN ((selected_length.bc_numvalue >= (300)::double precision) AND (selected_length.bc_numvalue < (450)::double precision)) THEN '3 - [300-450['::text
                    WHEN ((selected_length.bc_numvalue >= (450)::double precision) AND (selected_length.bc_numvalue < (600)::double precision)) THEN '4 - [450-600['::text
                    WHEN ((selected_length.bc_numvalue >= (600)::double precision) AND (selected_length.bc_numvalue < (750)::double precision)) THEN '5 - [600-750['::text
                    WHEN (selected_length.bc_numvalue >= (750)::double precision) THEN '6 - >=750'::text
                    ELSE NULL::text
                END AS length_class
           FROM selected_length
        ), count_class AS (
         SELECT length_class.ob_id,
            length_class.dp_name,
            length_class.length_class,
            count(*) AS nb_class
           FROM length_class
          GROUP BY length_class.ob_id, length_class.dp_name, length_class.length_class
          ORDER BY length_class.ob_id, length_class.dp_name, length_class.length_class
        ), combinaison_total AS (
         SELECT ob.ob_id,
            ob.dp_name,
            classe.length_class
           FROM ( SELECT DISTINCT length_class.ob_id,
                    length_class.dp_name
                   FROM length_class) ob,
            ( SELECT DISTINCT length_class.length_class
                   FROM length_class) classe
        )
 SELECT combinaison_total.ob_id,
    combinaison_total.dp_name,
    combinaison_total.length_class,
    COALESCE(count_class.nb_class, (0)::bigint) AS number
   FROM (combinaison_total
     LEFT JOIN count_class USING (ob_id, length_class, dp_name))
  ORDER BY combinaison_total.ob_id, combinaison_total.dp_name, combinaison_total.length_class;


ALTER TABLE dbmig.view_electrofishing_size OWNER TO diaspara_admin;
