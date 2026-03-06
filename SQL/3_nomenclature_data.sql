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
-- Data for Name: age; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.age (no_id, no_code, no_type, no_name) FROM stdin;
1	0FW	age	0 year in freshwater
2	1FW	age	1 year in freshwater
3	2FW	age	2 years in freshwater
4	3FW	age	3 years in freshwater
5	4FW	age	4 years in freshwater
6	5FW	age	5 years in freshwater
7	6FW	age	6 years in freshwater
8	1SW	age	1 year in seawater
9	2SW	age	2 years in seawater
10	MSW	age	Two years or more in seawater
11	1+	age	Older than one year in freshwater
\.


--
-- Data for Name: biological_characteristic_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.biological_characteristic_type (no_id, no_code, no_type, no_name, bc_label, bc_unit, bc_data_type) FROM stdin;
38	\N	Biological characteristic type	Unknown	Unknown	Unknown	Unknown
44	\N	Biological characteristic type	Sex	Sex	Dimensionless	nomenclature
45	\N	Biological characteristic type	Stage	stage	Dimensionless	nomenclature
48	\N	Biological characteristic type	Density	Density	nb/m²	real
41	\N	Biological characteristic type	Upper length	Total length - upper bound	mm	real
40	\N	Biological characteristic type	Lower length	Total length - lower bound	mm	real
47	\N	Biological characteristic type	Number	Number	Dimensionless	Integer
232	\N	Biological characteristic type	Number p2	Number in the second pass	Dimensionless	Integer
231	\N	Biological characteristic type	Number p1	Number in the first pass	Dimensionless	Integer
233	\N	Biological characteristic type	Number p3	Number in the 3rd pass	Dimensionless	Integer
234	\N	Biological characteristic type	Number p4	Number in the 4th pass	Dimensionless	Integer
235	\N	Biological characteristic type	Number p5	Number in the 5th pass	Dimensionless	Integer
236	\N	Biological characteristic type	Number p6	Number in the 6th pass	Dimensionless	Integer
265	\N	Biological characteristic type	Presence_neuromast	Presence of neuromasts along the lateral line	logical	boolean
266	\N	Biological characteristic type	Contrast	Contrasted colors between dorsal and ventral	logical	boolean
307	\N	Biological characteristic type	Eye_diam_mean_mm	Mean eye diameter	mm	real
42	\N	Biological characteristic type	Weightg	Weight in g	g	real
43	\N	Biological characteristic type	Ageyear	Age in year	year	integer
262	\N	Biological characteristic type	Eye_diam_vert_mm	Vertical eye diameter	mm	real
263	\N	Biological characteristic type	Eye_diam_horiz_mm	Horizontal eye diameter	mm	real
264	\N	Biological characteristic type	Pectoral_lengthmm	Length of the pectoral fin	mm	real
46	\N	Biological characteristic type	Rate	rate	Dimensionless	real
39	\N	Biological characteristic type	Lengthmm	Total length	mm	real
\.


--
-- Data for Name: downstream_mitigation_measure; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.downstream_mitigation_measure (no_id, no_code, no_type, no_name) FROM stdin;
282	\N	downstream mitigation measure	Water intake
283	\N	downstream mitigation measure	Fish friendly turbine
284	\N	downstream mitigation measure	Fish adapted Management
\.


--
-- Data for Name: effort_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.effort_type (no_id, no_code, no_type, no_name) FROM stdin;
99	\N	Effort type	Unknown
103	\N	Effort type	Volume in cubic meters
101	nrd	Effort type	Number of day (nr day)
104	nd	Effort type	Net-days (nd)
100	gd	Effort type	Gear-days (Fyke net, traps)
102	m2	Effort type	Area in square meters
\.


--
-- Data for Name: electrofishing_mean; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.electrofishing_mean (no_id, no_code, no_type, no_name, ef_definition) FROM stdin;
70	\N	electrofishing_mean	Unknown	\N
71	\N	electrofishing_mean	By foot	\N
72	\N	electrofishing_mean	By boat	\N
73	\N	electrofishing_mean	Mix	\N
\.


--
-- Data for Name: event_change; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.event_change (no_id, no_code, no_type, no_name) FROM stdin;
307	ST	Event change	Start (Default)
308	CO	Event change	Construction
309	SU	Event change	Start usage
310	ER	Event change	Erasement
311	EU	Event change	End usage
312	HC	Event change	Height change
313	PE	Event change	Partial erasement
332	FW	Event change	Fishway built or changed
\.


--
-- Data for Name: fishway_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.fishway_type (no_id, no_code, no_type, no_name) FROM stdin;
270	VS	Fishway type	Vertical slot fishway
271	PO	Fishway type	Pool type fishway
272	FL	Fishway type	Fish lock
273	D	Fishway type	Denil pass
275	RR	Fishway type	Rock ramp
276	ER	Fishway type	Eel ramp
277	LA	Fishway type	Lateral canal
278	AR	Fishway type	Artificial river
279	?	Fishway type	Unknown
280	S	Fishway type	Sluice
274	L	Fishway type	Fish lift
\.


--
-- Data for Name: gear_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.gear_type (no_id, no_code, no_type, no_name, isscfg_code, main_gear, eel_specific_gear) FROM stdin;
106	\N	Gear type	Unknown	01.0.0	SURROUNDING NETS	\N
107	\N	Gear type	Surrounding Nets with Purse Lines (Purse Seines)	01.1.0	SURROUNDING NETS	\N
108	\N	Gear type	Surrounding Nets with Purse Lines - one boat	01.1.1	SURROUNDING NETS	\N
109	\N	Gear type	Surrounding Nets with Purse Lines - two boats 	01.1.2	SURROUNDING NETS	\N
110	\N	Gear type	Surrounding Nets without Purse Lines	01.2.0	SURROUNDING NETS	\N
111	\N	Gear type	Unknown	02.0.0	SEINE NETS	\N
112	\N	Gear type	Beach Seines	02.1.0	SEINE NETS	\N
113	\N	Gear type	Boat Seines	02.2.0	SEINE NETS	\N
114	\N	Gear type	Boat Seines	02.2.1	SEINE NETS	\N
115	\N	Gear type	Boat Seines	02.2.2	SEINE NETS	\N
116	\N	Gear type	Boat Seines	02.2.3	SEINE NETS	\N
117	\N	Gear type	Boat Seines	02.9.0	SEINE NETS	\N
118	\N	Gear type	Unknown	03.0.0	TRAWLS	\N
119	\N	Gear type	Unknown	03.1.0	TRAWLS	\N
120	\N	Gear type	Beam trawls	03.1.1	TRAWL NETS	\N
121	\N	Gear type	Bottom otter trawls	03.1.2	TRAWL NETS	\N
122	\N	Gear type	Bottom pair trawls	03.1.3	TRAWL NETS	\N
123	\N	Gear type	Unknown	03.1.4	TRAWLS	\N
124	\N	Gear type	Unknown	03.1.5	TRAWLS	\N
125	\N	Gear type	Unknown	03.1.9	TRAWLS	\N
126	\N	Gear type	Unknown	03.2.0	TRAWLS	\N
127	\N	Gear type	Midwater otter trawls	03.2.1	TRAWL NETS	\N
128	\N	Gear type	Midwater pair trawls	03.2.2	TRAWL NETS	\N
129	\N	Gear type	Unknown	03.2.3	TRAWLS	\N
130	\N	Gear type	Unknown	03.2.9	TRAWLS	\N
131	\N	Gear type	0tter Twin Trawls	03.3.0	TRAWL NETS	\N
132	\N	Gear type	0tter Twin Trawls	03.4.9	TRAWL NETS	\N
133	\N	Gear type	0tter Twin Trawls	03.5.9	TRAWL NETS	\N
134	\N	Gear type	0tter Twin Trawls	03.9.0	TRAWL NETS	\N
135	\N	Gear type	Boat Dredges	04.0.0	DREDGES	\N
136	\N	Gear type	Boat Dredges	04.1.0	DREDGES	\N
137	\N	Gear type	Hand Dredges	04.2.0	DREDGES	\N
138	\N	Gear type	Portable Lift Nets	05.0.0	LIFT NETS	\N
139	\N	Gear type	Portable Lift Nets	05.1.0	LIFT NETS	\N
140	\N	Gear type	Boat Operated Lift Nets	05.2.0	LIFT NETS	\N
141	\N	Gear type	Shore Operated Lift Nets	05.3.0	LIFT NETS	\N
142	\N	Gear type	Shore Operated Lift Nets	05.9.0	LIFT NETS	\N
143	\N	Gear type	Cast Nets	06.0.0	FALLING GEAR	\N
144	\N	Gear type	Cast Nets	06.1.0	FALLING GEAR	\N
145	\N	Gear type	Falling Gear (Not Specified)	06.9.0	FALLING GEAR	\N
146	\N	Gear type	Set Gillnets (Anchored)	07.0.0	GILLNETS AND ENTANGLING NETS	\N
147	\N	Gear type	Set Gillnets (Anchored)	07.1.0	GILLNETS AND ENTANGLING NETS	\N
148	\N	Gear type	Drifting Gillnets (Driftnets)	07.2.0	GILLNETS AND ENTANGLING NETS	\N
149	\N	Gear type	Encircling gillnets	07.3.0	GILLNETS AND ENTANGLING NETS	\N
150	\N	Gear type	Fixed Gillnets (on Stakes)	07.4.0	GILLNETS AND ENTANGLING NETS	\N
151	\N	Gear type	Trammel Nets	07.5.0	GILLNETS AND ENTANGLING NETS	\N
152	\N	Gear type	Trammel Nets	07.6.0	GILLNETS AND ENTANGLING NETS	\N
153	\N	Gear type	Trammel Nets	07.9.0	GILLNETS AND ENTANGLING NETS	\N
154	\N	Gear type	Trammel Nets	07.9.1	GILLNETS AND ENTANGLING NETS	\N
155	\N	Gear type	Unknown	08.0.0	TRAPS	\N
156	\N	Gear type	Stationary Uncovered Pound Nets	08.1.0	TRAPS	\N
157	\N	Gear type	Pots	08.2.0	TRAPS	Eel pots
158	\N	Gear type	Fyke Nets	08.3.0	TRAPS	Eel fyke nets
159	\N	Gear type	Stow Nets	08.4.0	TRAPS	Dideau
160	\N	Gear type	Barriers, Fences, Weirs, Corrals, etc.	08.5.0	TRAPS	\N
161	\N	Gear type	Aerial Traps	08.6.0	TRAPS	\N
162	\N	Gear type	Aerial Traps	08.9.0	TRAPS	\N
163	\N	Gear type	Handlines and Pole-Lines (Hand Operated)	09.0.0	HOOKS AND LINES	\N
164	\N	Gear type	Handlines and Pole-Lines (Hand Operated)	09.1.0	HOOKS AND LINES	\N
165	\N	Gear type	Handlines and Pole-Lines (Mechanized)	09.2.0	HOOKS AND LINES	\N
166	\N	Gear type	Set Longlines	09.3.0	HOOKS AND LINES	\N
167	\N	Gear type	Drifting Longlines	09.4.0	HOOKS AND LINES	\N
168	\N	Gear type	Longlines (Not Specified)	09.5.0	HOOKS AND LINES	\N
169	\N	Gear type	Trolling Lines	09.6.0	HOOKS AND LINES	\N
170	\N	Gear type	Trolling Lines	09.9.0	HOOKS AND LINES	\N
171	\N	Gear type	Unknown	10.0.0	GRAPPLING AND WOUNDING	\N
172	\N	Gear type	Harpoons	10.1.0	GRAPPLING AND WOUNDING	\N
173	\N	Gear type	Pumps	11.0.0	HARVESTING GEAR	\N
174	\N	Gear type	Pumps	11.1.0	HARVESTING GEAR	\N
175	\N	Gear type	Mechanized Dredges	11.2.0	HARVESTING GEAR	\N
176	\N	Gear type	Pumps	11.9.0	HARVESTING GEAR	\N
177	\N	Gear type	Miscellaneous	20.0.0	MISCELLANEOUS	Glass eel scoop net and push net
178	\N	Gear type	Recreational fishing gear	25.0.0	RECREATIVE FISHING GEAR	\N
179	\N	Gear type	Unknown	99.0.0	UNKNOWN	\N
\.


--
-- Data for Name: maturity; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.maturity (no_id, no_code, no_type, no_name) FROM stdin;
347	A	maturity	Immature
348	B	maturity	Developing
349	Ba	maturity	Developing, but functionally immature (first-time developer)
350	Bb	maturity	Developing and functionally mature
351	C	maturity	Spawning
352	Ca	maturity	Actively spawning
353	Cb	maturity	Spawning capable
354	D	maturity	Regressing / Regenerating
355	Da	maturity	Regressing
356	Db	maturity	Regenerating
357	E	maturity	Omitted spawning
358	F	maturity	Abnormal
\.


--
-- Data for Name: migration_direction; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.migration_direction (no_id, no_code, no_type, no_name) FROM stdin;
\.


--
-- Data for Name: nomenclature; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.nomenclature (no_id, no_code, no_type, no_name) FROM stdin;
\.


--
-- Data for Name: obstruction_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.obstruction_type (no_id, no_code, no_type, no_name) FROM stdin;
218	UN	Obstruction type	Unknown
291	DA	Obstruction_type	Dam
292	WE	Obstruction_type	Weir
293	RR	Obstruction_type	Rock ramp
294	CU	Obstruction_type	Culvert
295	FO	Obstruction_type	Ford
296	BR	Obstruction_type	Bridge
297	OT	Obstruction_type	Other
298	DI	Obstruction_type	Dike
299	GR	Obstruction_type	Grid
300	PP	Obstruction_type	Penstock Pipe
314	WA	Obstruction type	Waterfall, Natural obstruction
\.


--
-- Data for Name: orient_flow; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.orient_flow (no_id, no_code, no_type, no_name) FROM stdin;
238	1	orient_flow	[70-90°]
239	2	orient_flow	[50-70°[
240	3	orient_flow	[30-50°[
241	4	orient_flow	<30°
\.


--
-- Data for Name: scientific_observation_method; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.scientific_observation_method (no_id, no_code, no_type, no_name, sc_observation_category, sc_definition) FROM stdin;
68	\N	scientific_observation_method	Unknown	Gear fishing	\N
61	UN	scientific_observation_method	Unknown	Electro-fishing	Electrofishing, method unknown
63	P1	scientific_observation_method	Partial1bank	Electro-fishing	Electrofishing, partial on one bank
64	P2	scientific_observation_method	Partial2banks	Electro-fishing	Electrofishing, partial on two banks
65	PR	scientific_observation_method	Partialrandom	Electro-fishing	Electrofishing, partial random
66	PR	scientific_observation_method	Partialprop	Electro-fishing	Electrofishing, partial proportional
67	OT	scientific_observation_method	Other	Electro-fishing	Electrofishing, other method
301	DH	scientific_observation_method	Deep habitat	Electro-fishing	Normalized method for deep habitat (Belliard et al.,2018)
303	PE	scientific_observation_method	Point sampling eel	Electro-fishing	Electrofishing, eel specific point sampling (Germis, 2009)
305	BB	scientific_observation_method	Boom boat	Electro-fishing	Boom boat (Pulsed)
304	TE	scientific_observation_method	TEF	Electro-fishing	Timed electrofishing, 10 min in Ireland
306	EP	scientific_observation_method	EPA	Electro-fishing	Partial point sampling with density current, protocol Feunteun, Rigaud
62	ST	scientific_observation_method	Standard by foot	Electro-fishing	Electrofishing by foot, specify the number of pass
302	EE	scientific_observation_method	Standard eel	Electro-fishing	Electrofishing by foot, eel specific, specify the number of pass
\.


--
-- Data for Name: sex; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.sex (no_id, no_code, no_type, no_name) FROM stdin;
182	F	sex	Female
181	M	sex	Male
360	H	sex	Hermaphrodite
361	I	sex	Immature - attempt made but sex could not be destinguished
362	T	sex	Transitional
363	U	sex	Undetermined - no attempt made
364	X	sex	Mixed
\.


--
-- Data for Name: species; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.species (no_id, no_code, no_type, no_name, sp_vernacular_name) FROM stdin;
333	CIV	Species	Anguilla_anguilla (glass eel)	European eel (glass eel stage)
315	127186	Species	Salmo salar	Atlantic salmon
317	126413	Species	Alosa alosa	Twait shad
318	126415	Species	Alosa fallax	Allis shad
319	101174	Species	Petromyzon marinus	Sea lamprey
320	101172	Species	Lampretra fluviatilis	European river lamprey
30	126281	Species	Anguilla anguilla	European eel
316	127187	Species	Salmo trutta	Sea trout
\.


--
-- Data for Name: stage; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.stage (no_id, no_code, no_type, no_name, spe_code) FROM stdin;
225	G	Stage	Glass eel	126281
226	Y	Stage	Yellow eel	126281
227	S	Stage	Silver eel	126281
228	GY	Stage	Glass & yellow eel mixed	126281
229	YS	Stage	Yellow & silver eel mixed	126281
230	AL	Stage	G, Y & S eel mixed	126281
426	E	stage	Egg	127187
427	EE	stage	Eyed egg	127187
428	ALV	stage	Alevin with the yolk sac	127187
429	FR	stage	Fry	127187
430	P	stage	Parr	127187
431	SM	stage	Smolt	127187
432	PS	stage	Post Smolt	127187
433	A	stage	Adult	127187
434	AL	stage	All stages	127187
435	_	stage	No life stage	127187
416	E	stage	Egg	127186
417	EE	stage	Eyed egg	127186
418	ALV	stage	Alevin with the yolk sac	127186
419	FR	stage	Fry	127186
420	P	stage	Parr	127186
421	SM	stage	Smolt	127186
422	PS	stage	Post Smolt	127186
423	A	stage	Adult	127186
424	AL	stage	All stages	127186
425	_	stage	No life stage	127186
\.


--
-- Data for Name: turbine_type; Type: TABLE DATA; Schema: nomenclature; Owner: diaspara_admin
--

COPY nomenclature.turbine_type (no_id, no_code, no_type, no_name) FROM stdin;
242	\N	Turbine type	Horizontal axis Kaplan (bulb)
243	\N	Turbine type	Other (please specify)
244	\N	Turbine type	Double Francis (spiral case)
245	\N	Turbine type	Francis unspecified
246	\N	Turbine type	Turbine with fixed blade propeller and vertical axis
247	\N	Turbine type	Kaplan not specified
248	\N	Turbine type	Pelton
249	\N	Turbine type	Reversible
250	\N	Turbine type	Kaplan (model of S-turbine)
251	\N	Turbine type	Turbine with fixed blade propeller and horizontal axis
252	\N	Turbine type	Unknown
253	\N	Turbine type	Vertical axis Kaplan
254	\N	Turbine type	Francis without volute
255	\N	Turbine type	Francis (spiral case)
256	\N	Turbine type	Banki-Michell (cross-flow)
257	\N	Turbine type	VLH
258	\N	Turbine type	Archimedean screw turbine
259	\N	Turbine type	Water wheel turbine (aqualienne)
260	\N	Turbine type	Water wheel turbine (others)
261	\N	Turbine type	Propeller unspecified
\.


--
-- Name: nomenclature_no_id_seq; Type: SEQUENCE SET; Schema: nomenclature; Owner: diaspara_admin
--

SELECT pg_catalog.setval('nomenclature.nomenclature_no_id_seq', 333, true);


--
-- PostgreSQL database dump complete
--

