--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: pitch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pitch (
    id character varying(255) NOT NULL,
    note_letter character varying(255) NOT NULL,
    accidental character varying(255) NOT NULL,
    octave integer NOT NULL,
    midi_number integer NOT NULL,
    "position" integer NOT NULL
);


--
-- Name: quiz; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    difficulty character varying(255) NOT NULL,
    level double precision NOT NULL,
    description character varying(255) NOT NULL,
    transposition_id integer NOT NULL,
    length integer NOT NULL
);


--
-- Name: quiz_attempt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_attempt (
    id integer NOT NULL,
    user_id_id character varying NOT NULL,
    started_at timestamp(0) without time zone NOT NULL,
    completed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    seconds_to_complete integer,
    quiz_id integer NOT NULL
);


--
-- Name: COLUMN quiz_attempt.started_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_attempt.started_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN quiz_attempt.completed_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_attempt.completed_at IS '(DC2Type:datetime_immutable)';


--
-- Name: quiz_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_attempt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_pitch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_pitch (
    id integer NOT NULL,
    quiz_id integer NOT NULL,
    pitch_id character varying NOT NULL,
    transposed_answer_pitch_id character varying
);


--
-- Name: quiz_pitch_attempt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_pitch_attempt (
    id integer NOT NULL,
    quiz_attempt_id_id integer NOT NULL,
    started_at timestamp(0) without time zone NOT NULL,
    user_input character varying(255) DEFAULT NULL::character varying,
    correct boolean NOT NULL,
    quiz_pitch_id integer NOT NULL,
    ended_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


--
-- Name: COLUMN quiz_pitch_attempt.started_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_pitch_attempt.started_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN quiz_pitch_attempt.ended_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_pitch_attempt.ended_at IS '(DC2Type:datetime_immutable)';


--
-- Name: quiz_pitch_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_pitch_attempt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_pitch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_pitch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transposition; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transposition (
    "interval" integer NOT NULL,
    name character varying(255) NOT NULL,
    id integer
);


--
-- Name: transposition_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transposition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id character varying NOT NULL,
    email character varying(255),
    created_at timestamp(0) without time zone NOT NULL,
    display_name character varying(255) DEFAULT NULL::character varying,
    is_anonymous boolean
);


--
-- Name: COLUMN "user".created_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public."user".created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20220818202845	2022-08-18 20:34:23	90
DoctrineMigrations\\Version20220818203959	2022-08-18 20:40:09	127
DoctrineMigrations\\Version20220824184427	2022-08-24 18:44:44	133
DoctrineMigrations\\Version20220824193841	2022-08-24 19:40:14	87
DoctrineMigrations\\Version20220825203704	2022-08-25 20:37:54	136
DoctrineMigrations\\Version20220825204114	2022-08-25 20:41:23	67
DoctrineMigrations\\Version20220825204256	2022-08-25 20:43:06	69
DoctrineMigrations\\Version20220825204711	2022-08-25 20:47:20	84
DoctrineMigrations\\Version20220826194829	2022-08-26 20:03:03	129
DoctrineMigrations\\Version20220829165829	2022-09-01 20:38:23	82
DoctrineMigrations\\Version20220829204233	2022-09-01 20:38:23	0
DoctrineMigrations\\Version20220901203815	2022-09-01 20:39:12	136
DoctrineMigrations\\Version20220902185643	2022-09-02 18:56:53	97
DoctrineMigrations\\Version20220907192056	2022-09-07 19:21:35	98
DoctrineMigrations\\Version20220907192541	2022-09-07 19:26:05	81
DoctrineMigrations\\Version20220929170129	2022-09-29 17:04:53	119
DoctrineMigrations\\Version20220929170444	2022-09-29 17:13:04	95
DoctrineMigrations\\Version20221013133737	2022-10-13 13:38:34	71
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: pitch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pitch (id, note_letter, accidental, octave, midi_number, "position") FROM stdin;
cdf4tp	C	double-flat	4	58	1
cdf5tp	C	double-flat	5	70	1
cdf6tp	C	double-flat	6	82	1
cfl4tp	C	flat	4	59	2
cfl5tp	C	flat	5	71	2
cfl6tp	C	flat	6	83	2
cna4tp	C	natural	4	60	0
cna5tp	C	natural	5	72	0
cna6tp	C	natural	6	84	0
csh4tp	C	sharp	4	61	123
csh5tp	C	sharp	5	73	12
csh6tp	C	sharp	6	85	12
cds4tp	C	double-sharp	4	62	13
cds5tp	C	double-sharp	5	74	1
cds6tp	C	double-sharp	6	86	1
ddf4tp	D	double-flat	4	60	0
ddf5tp	D	double-flat	5	72	0
ddf6tp	D	double-flat	6	84	0
dfl4tp	D	flat	4	61	123
dfl5tp	D	flat	5	73	12
dfl6tp	D	flat	6	85	12
dna4tp	D	natural	4	62	13
dna5tp	D	natural	5	74	1
dna6tp	D	natural	6	86	1
dsh4tp	D	sharp	4	63	23
dsh5tp	D	sharp	5	75	2
dsh6tp	D	sharp	6	87	2
dds4tp	D	double-sharp	4	64	12
dds5tp	D	double-sharp	5	76	0
dds6tp	D	double-sharp	6	88	0
edf4tp	E	double-flat	4	62	13
edf5tp	E	double-flat	5	74	1
edf6tp	E	double-flat	6	86	1
efl4tp	E	flat	4	63	23
efl5tp	E	flat	5	75	2
efl6tp	E	flat	6	87	2
ena4tp	E	natural	4	64	12
ena5tp	E	natural	5	76	0
ena6tp	E	natural	6	88	0
esh4tp	E	sharp	4	65	1
esh5tp	E	sharp	5	77	1
esh6tp	E	sharp	6	89	1
eds4tp	E	double-sharp	4	66	2
eds5tp	E	double-sharp	5	78	2
fdf4tp	F	double-flat	4	63	23
fdf5tp	F	double-flat	5	75	2
fdf6tp	F	double-flat	6	87	2
ffl4tp	F	flat	4	64	12
ffl5tp	F	flat	5	76	0
ffl6tp	F	flat	6	88	0
fna4tp	F	natural	4	65	1
fna5tp	F	natural	5	77	1
fna6tp	F	natural	6	89	1
fsh3tp	F	sharp	3	54	123
fsh4tp	F	sharp	4	66	2
fsh5tp	F	sharp	5	78	2
fds3tp	F	double-sharp	3	55	13
fds4tp	F	double-sharp	4	67	0
fds5tp	F	double-sharp	5	79	0
gdf4tp	G	double-flat	4	65	1
gdf5tp	G	double-flat	5	77	1
gfl3tp	G	flat	3	54	123
gfl4tp	G	flat	4	66	2
gfl5tp	G	flat	5	78	2
gna3tp	G	natural	3	55	13
gna4tp	G	natural	4	67	0
gna5tp	G	natural	5	79	0
gsh3tp	G	sharp	3	56	23
gsh4tp	G	sharp	4	68	23
gsh5tp	G	sharp	5	70	23
gds3tp	G	double-sharp	3	57	12
gds4tp	G	double-sharp	4	69	12
gds5tp	G	double-sharp	5	71	12
adf3tp	A	double-flat	3	55	13
adf4tp	A	double-flat	4	67	0
adf5tp	A	double-flat	5	79	0
afl3tp	A	flat	3	56	23
afl4tp	A	flat	4	68	23
afl5tp	A	flat	5	70	23
ana3tp	A	natural	3	57	12
ana4tp	A	natural	4	69	12
ana5tp	A	natural	5	71	12
ash3tp	A	sharp	3	58	1
ash4tp	A	sharp	4	70	1
ash5tp	A	sharp	5	82	1
ads3tp	A	double-sharp	3	59	2
ads4tp	A	double-sharp	4	71	2
ads5tp	A	double-sharp	5	83	2
bdf3tp	B	double-flat	3	57	12
bdf4tp	B	double-flat	4	69	12
bdf5tp	B	double-flat	5	71	12
bfl3tp	B	flat	3	58	1
bfl4tp	B	flat	4	70	1
bfl5tp	B	flat	5	82	1
bna3tp	B	natural	3	59	2
bna4tp	B	natural	4	71	2
bna5tp	B	natural	5	83	2
bsh3tp	B	sharp	3	60	0
bsh4tp	B	sharp	4	72	0
bsh5tp	B	sharp	5	84	0
bds3tp	B	double-sharp	3	61	123
bds4tp	B	double-sharp	4	73	12
bds5tp	B	double-sharp	5	85	12
\.


--
-- Data for Name: quiz; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz (id, name, difficulty, level, description, transposition_id, length) FROM stdin;
1000	Introducing C, D, E	Learning the Basics	1	New Note	0	10
1001	Introducing Low B	Learning the Basics	2	New Note	0	12
1002	Introducing F	Learning the Basics	3	New Note	0	14
1003	Introducing G 	Learning the Basics	4	New Note	0	14
1004	Introducing A 	Learning the Basics	5	New Note	0	16
1005	Introducing B 	Learning the Basics	6	New Note	0	16
1006	Introducing C 	Learning the Basics	7	New Note	0	16
1007	C Major One Octave Scale	Learning the Basics	8	Scale	0	15
1008	Introducing D 	Learning the Basics	9	New Note	0	16
1009	Introducing E	Learning the Basics	10	New Note	0	18
1010	Unit Quiz	Learning the Basics	11	Unit Quiz	0	26
1100	Introducing Low Bb	Introduction to Flats and Sharps	12	New Note	0	14
1101	Introducing Low C#	Introduction to Flats and Sharps	13	New Note	0	14
1102	Introducing F# 	Introduction to Flats and Sharps	14	New Note	0	18
1103	Introducing Eb	Introduction to Flats and Sharps	15	New Note	0	16
1104	Reviewing New Low Accidentals	Introduction to Flats and Sharps	16	Review	0	20
1105	Introducing High Bb	Introduction to Flats and Sharps	17	New Note	0	14
1106	Introducing High C#	Introduction to Flats and Sharps	18	New Note	0	16
1107	Introducing High Eb	Introduction to Flats and Sharps	19	New Note	0	14
1108	Review New High Accidentals	Introduction to Flats and Sharps	20	Review	0	12
1109	Bb Major One Octave Scale	Introduction to Flats and Sharps	21	New Note	0	15
1110	D Major One Octave Scale	Introduction to Flats and Sharps	22	New Note	0	15
1111	Reviewing All New Notes	Introduction to Flats and Sharps	23	Review	0	20
1112	Unit Quiz 	Introduction to Flats and Sharps	24	Unit Quiz	0	42
1200	Introducing Low A	Expanding Outward	25	New Note	0	14
1201	Introducing Low G	Expanding Outward	26	New Note	0	14
1202	Introducing Low F#	Expanding Outward	27	New Note	0	14
1203	Reviewing New Low Notes	Expanding Outward	28	Review	0	10
1204	Reviewing All Low Notes	Expanding Outward	29	Review	0	24
1205	G Major One Octave Scale	Expanding Outward	30	Scale	0	15
1206	Introducing High F	Expanding Outward	31	New Note	0	14
1207	Introducing High F#	Expanding Outward	32	New Note	0	16
1208	Introducing High G	Expanding Outward	33	New Note	0	18
1209	Introducing High A	Expanding Outward	34	New Note	0	18
1210	Reviewing New High Notes	Expanding Outward	35	Review	0	12
1211	F Major Scale	Expanding Outward	36	Scale	0	15
1212	G Major Top Octave Scale	Expanding Outward	37	Scale	0	15
1213	Reviewing All New Notes	Expanding Outward	38	Review	0	22
1214	G Major Two Octave Scale	Expanding Outward	39	Scale	0	29
1215	Unit Quiz	Expanding Outward	40	Unit Quiz	0	56
1300	Introducing Low G#	Exploring More Accidentals	41	New Note	0	14
1301	Introducing Low Ab	Exploring More Accidentals	42	New Note	0	16
1302	Reviewing Bottom Register Notes	Exploring More Accidentals	43	Review	0	20
1303	Introducing Low D#	Exploring More Accidentals	44	New Note	0	16
1304	Introducing Low Db	Exploring More Accidentals	45	New Note	0	16
1305	Reviewing Medium Low Note Accidentals 	Exploring More Accidentals	46	Review	0	24
1306	Reviewing Low Accidentals	Exploring More Accidentals	47	Review	0	18
1307	Introducing Ab 	Exploring More Accidentals	48	New Note	0	12
1308	Introducing G# 	Exploring More Accidentals	49	New Note	0	14
1309	Eb Major Scale	Exploring More Accidentals	50	Scale	0	15
1310	E Major Scale	Exploring More Accidentals	51	Scale	0	15
1311	A Major One Octave Scale	Exploring More Accidentals	52	Scale	0	15
1312	Ab Major One Octave Scale 	Exploring More Accidentals	53	Scale	0	15
1313	Reviewing Accidentals in the Bottom Half of the Staff 	Exploring More Accidentals	54	Review	0	15
1314	Introducing Db 	Exploring More Accidentals	55	New Note	0	15
1315	Introducing D# 	Exploring More Accidentals	56	New Note	0	15
1316	Introducing High G# 	Exploring More Accidentals	57	New Note	0	14
1317	Introducing High Ab 	Exploring More Accidentals	58	New Note	0	16
1318	A Major Top Octave Scale	Exploring More Accidentals	59	Scale	0	15
1319	E Major Scale	Exploring More Accidentals	60	Scale	0	15
1320	Ab Major Top Octave Scale	Exploring More Accidentals	61	Scale	0	15
1321	Reviewing C, D, and E Accidentals in the Staff	Exploring More Accidentals	62	Review	0	18
1322	Reviewing New Notes	Exploring More Accidentals	63	Review	0	22
1323	Reviewing New Notes and Previous Accidentals	Exploring More Accidentals	64	Review	0	32
1324	A Major Two Octave Scale	Exploring More Accidentals	65	Scale	0	29
1325	Ab Major Two Octave Scale	Exploring More Accidentals	66	Scale	0	29
1326	Unit Quiz	Exploring More Accidentals	67	Unit Quiz	0	50
1400	Introducing high B and Bb	Going Up	68	New Note	0	14
1401	Introducing high C 	Going Up	69	New Note	0	14
1402	Scale: Bb Major 2 octave	Going Up	70	Scale	0	29
1403	Scale: C Major 2 octave	Going Up	71	Scale	0	29
1404	Introducing high C#	Going Up	72	New Note	0	14
1405	Introducing high D	Going Up	73	New Note	0	14
1406	Scale: D Major 2 octave 	Going Up	74	Scale	0	29
1407	Introducing high Db	Going Up	75	New Note	0	14
1408	Introducing high D#	Going Up	76	New Note	0	14
1409	Introducing high E	Going Up	77	New Note	0	16
1410	Introducing high Eb	Going Up	78	New Note	0	14
1411	Introducing high F	Going Up	79	New Note	0	14
1412	Unit Quiz	Going Up	80	Unit Quiz	0	24
1500	Introducing Gb	Adding Enharmonics	81	New Note	0	16
1501	Introducing Cb	Adding Enharmonics	82	New Note	0	20
1502	Introducing Fb	Adding Enharmonics	83	New Note	0	22
1503	Scale: Db Major 2 octave	Adding Enharmonics	84	Scale	0	29
1504	Reviewing Enharmonic Flats	Adding Enharmonics	85	Review	0	22
1505	Introducing A#	Adding Enharmonics	86	New Note	0	22
1506	Introducing E#	Adding Enharmonics	87	New Note	0	26
1507	Introducing B#	Adding Enharmonics	88	New Note	0	22
1508	F# Major Two Octave Scale 	Adding Enharmonics	89	Scale	0	29
1509	Gb Major Two Octave Scale	Adding Enharmonics	90	Scale	0	29
1510	Reviewing Enharmonic Sharps	Adding Enharmonics	91	Review	0	18
1511	Reviewing Enharmonic Notes	Adding Enharmonics	92	Review	0	32
1512	Unit Quiz	Adding Enharmonics	93	Unit Quiz	0	60
1600	Introducing Double Flats	Double Flats and Sharps	94	New Note	0	22
1601	Introducing Double Sharps	Double Flats and Sharps	95	New Note	0	22
1602	High Double Flats	Double Flats and Sharps	96	New Note	0	30
1603	High Double Sharps	Double Flats and Sharps	97	New Note	0	30
1604	Low Double Flats	Double Flats and Sharps	98	New Note	0	24
1605	Low Double Sharps	Double Flats and Sharps	99	New Note	0	28
1606	Unit Quiz	Double Flats and Sharps	100	Unit Quiz	0	50
1700	The Impossible Level Lite	The Impossible Level	101	Unit Quiz	0	30
1701	The Impossible Level.	The Impossible Level	102	Unit Quiz	0	150
2000	Introducing C, D, E	Introduction to Transposing down a Major Second	103	New Note	-2	10
3001	Introducing C, D, E	Introduction to Transposing up a Tritone	104	New Note	6	10
\.


--
-- Data for Name: quiz_attempt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_attempt (id, user_id_id, started_at, completed_at, seconds_to_complete, quiz_id) FROM stdin;
893	ItoU9jZDn3gboaz1OPbAdHavcc93	2022-12-06 05:03:19	2022-12-06 05:05:16	104	1602
894	ItoU9jZDn3gboaz1OPbAdHavcc93	2022-12-06 05:05:44	2022-12-06 05:06:59	63	1700
895	ItoU9jZDn3gboaz1OPbAdHavcc93	2022-12-06 05:19:45	2022-12-06 05:20:18	22	3001
\.


--
-- Data for Name: quiz_pitch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_pitch (id, quiz_id, pitch_id, transposed_answer_pitch_id) FROM stdin;
30000	1200	ana3tp	\N
30001	1200	bna3tp	\N
30002	1200	bfl3tp	\N
30003	1200	cna4tp	\N
30004	1200	csh4tp	\N
30005	1201	gna3tp	\N
30006	1201	ana3tp	\N
30007	1201	bfl3tp	\N
30008	1201	bna3tp	\N
30009	1201	cna4tp	\N
30010	1202	fsh3tp	\N
30011	1202	gna3tp	\N
30012	1202	ana3tp	\N
30013	1202	bfl3tp	\N
30014	1202	bna3tp	\N
30015	1203	fsh3tp	\N
30016	1203	gna3tp	\N
30017	1203	ana3tp	\N
30018	1204	fsh3tp	\N
30019	1204	gsh3tp	\N
30020	1204	ana3tp	\N
30021	1204	bna3tp	\N
30022	1204	bfl3tp	\N
30023	1204	cna4tp	\N
30024	1204	csh4tp	\N
30025	1204	dna4tp	\N
30026	1204	ena4tp	\N
30027	1204	efl4tp	\N
30028	1205	gna3tp	\N
30029	1205	ana3tp	\N
30030	1205	bna3tp	\N
30031	1205	cna4tp	\N
30032	1205	dna4tp	\N
30033	1205	ena4tp	\N
30034	1205	fsh4tp	\N
30035	1205	gna4tp	\N
30036	1205	fsh4tp	\N
10000	1000	cna4tp	\N
10001	1000	dna4tp	\N
10002	1000	ena4tp	\N
10003	1001	cna4tp	\N
10004	1001	dna4tp	\N
10005	1001	ena4tp	\N
10006	1001	bna3tp	\N
10007	1002	bna3tp	\N
10008	1002	cna4tp	\N
10009	1002	dna4tp	\N
10010	1002	ena4tp	\N
10011	1002	fna4tp	\N
10012	1003	bna3tp	\N
10013	1003	cna4tp	\N
10014	1003	dna4tp	\N
10015	1003	ena4tp	\N
10016	1003	fna4tp	\N
10017	1003	gna4tp	\N
10018	1004	cna4tp	\N
10019	1004	dna4tp	\N
10020	1004	ena4tp	\N
10021	1004	fna4tp	\N
10022	1004	gna4tp	\N
10023	1004	ana4tp	\N
10024	1005	bna3tp	\N
10025	1005	ena4tp	\N
10026	1005	fna4tp	\N
10027	1005	gna4tp	\N
10028	1005	ana4tp	\N
10029	1005	bna4tp	\N
10030	1006	ena4tp	\N
10031	1006	fna4tp	\N
10032	1006	gna4tp	\N
10033	1006	ana4tp	\N
10034	1006	bna4tp	\N
10035	1006	cna5tp	\N
10036	1007	cna4tp	\N
10037	1007	dna4tp	\N
10038	1007	ena4tp	\N
10039	1007	fna4tp	\N
10040	1007	gna4tp	\N
10041	1007	ana4tp	\N
10042	1007	bna4tp	\N
10043	1007	cna5tp	\N
10044	1007	bna4tp	\N
10045	1007	ana4tp	\N
10046	1007	gna4tp	\N
10047	1007	fna4tp	\N
10048	1007	ena4tp	\N
10049	1007	dna4tp	\N
10050	1007	cna4tp	\N
10051	1008	gna4tp	\N
10052	1008	ana4tp	\N
10053	1008	bna4tp	\N
10054	1008	cna5tp	\N
10055	1008	dna5tp	\N
10056	1009	gna4tp	\N
10057	1009	ana4tp	\N
10058	1009	bna4tp	\N
10059	1009	cna5tp	\N
10060	1009	dna5tp	\N
10061	1009	ena5tp	\N
10062	1010	bna3tp	\N
10063	1010	cna4tp	\N
10064	1010	dna4tp	\N
10065	1010	ena4tp	\N
10066	1010	fna4tp	\N
10067	1010	gna4tp	\N
10068	1010	ana4tp	\N
10069	1010	bna4tp	\N
10070	1010	cna5tp	\N
10071	1010	dna5tp	\N
10072	1010	ena5tp	\N
20000	1100	bfl3tp	\N
20001	1100	bna3tp	\N
20002	1100	cna4tp	\N
20003	1100	dna4tp	\N
20004	1100	ena4tp	\N
20005	1101	bfl3tp	\N
20006	1101	bna3tp	\N
20007	1101	cna4tp	\N
20008	1101	csh4tp	\N
20009	1101	dna4tp	\N
20010	1101	ena4tp	\N
20011	1102	bna3tp	\N
20012	1102	bfl3tp	\N
20013	1102	cna4tp	\N
20014	1102	csh4tp	\N
20015	1102	dna4tp	\N
20016	1102	ena4tp	\N
20017	1102	fsh4tp	\N
20018	1103	cna4tp	\N
20019	1103	ena4tp	\N
30037	1205	ena4tp	\N
30038	1205	dna4tp	\N
20020	1103	efl4tp	\N
20021	1103	fna4tp	\N
20022	1103	fsh4tp	\N
20023	1104	bfl3tp	\N
20024	1104	csh4tp	\N
20025	1104	fsh4tp	\N
20026	1104	efl4tp	\N
20027	1105	ana4tp	\N
20028	1105	bfl4tp	\N
20029	1105	cna5tp	\N
20030	1105	gna4tp	\N
20031	1105	dna5tp	\N
20032	1106	ana4tp	\N
20033	1106	bfl4tp	\N
20034	1106	bna4tp	\N
20035	1106	cna5tp	\N
20036	1106	csh5tp	\N
20037	1106	dna5tp	\N
20038	1107	cna5tp	\N
20039	1107	csh5tp	\N
20040	1107	dna5tp	\N
20041	1107	ena5tp	\N
20042	1107	efl5tp	\N
20043	1108	bfl4tp	\N
20044	1108	csh5tp	\N
20045	1108	efl5tp	\N
20046	1109	bfl3tp	\N
20047	1109	cna4tp	\N
20048	1109	dna4tp	\N
20049	1109	efl4tp	\N
20050	1109	fna4tp	\N
20051	1109	gna4tp	\N
20052	1109	ana4tp	\N
20053	1109	bfl4tp	\N
20054	1109	ana4tp	\N
20055	1109	gna4tp	\N
20056	1109	fna4tp	\N
20057	1109	efl4tp	\N
20058	1109	dna4tp	\N
20059	1109	cna4tp	\N
20060	1109	bfl3tp	\N
20061	1110	dna4tp	\N
20062	1110	ena4tp	\N
20063	1110	fsh4tp	\N
20064	1110	gna4tp	\N
20065	1110	ana4tp	\N
20066	1110	bna4tp	\N
20067	1110	csh5tp	\N
20068	1110	dna5tp	\N
20069	1110	csh5tp	\N
20070	1110	bna4tp	\N
20071	1110	ana4tp	\N
20072	1110	gna4tp	\N
20073	1110	fsh4tp	\N
20074	1110	ena4tp	\N
20075	1110	dna4tp	\N
20076	1111	bfl3tp	\N
20077	1111	bfl4tp	\N
20078	1111	csh4tp	\N
20079	1111	csh5tp	\N
20080	1111	fsh4tp	\N
20081	1111	efl4tp	\N
20082	1111	efl5tp	\N
20083	1112	bfl3tp	\N
20084	1112	bna3tp	\N
20085	1112	cna4tp	\N
20086	1112	csh4tp	\N
20087	1112	dna4tp	\N
20088	1112	ena4tp	\N
20089	1112	efl4tp	\N
20090	1112	fna4tp	\N
20091	1112	fsh4tp	\N
20092	1112	gna4tp	\N
20093	1112	ana4tp	\N
20094	1112	bfl4tp	\N
20095	1112	bna4tp	\N
20096	1112	cna5tp	\N
20097	1112	csh5tp	\N
20098	1112	dna5tp	\N
20099	1112	ena5tp	\N
20100	1112	efl5tp	\N
30039	1205	cna4tp	\N
30040	1205	bna3tp	\N
30041	1205	ana3tp	\N
30042	1205	gna3tp	\N
30043	1206	cna5tp	\N
30044	1206	dna5tp	\N
30045	1206	ena5tp	\N
30046	1206	fna5tp	\N
30047	1207	cna5tp	\N
30048	1207	dna5tp	\N
30049	1207	ena5tp	\N
30050	1207	fna5tp	\N
30051	1207	fsh5tp	\N
30052	1208	dna5tp	\N
30053	1208	ena5tp	\N
30054	1208	fna5tp	\N
30055	1208	fsh5tp	\N
30056	1208	gna5tp	\N
30057	1209	ena5tp	\N
30058	1209	fna5tp	\N
30059	1209	fsh5tp	\N
30060	1209	gna5tp	\N
30061	1209	ana5tp	\N
30062	1210	fna5tp	\N
30063	1210	fsh5tp	\N
30064	1210	gna5tp	\N
30065	1210	ana5tp	\N
30066	1211	fna4tp	\N
30067	1211	gna4tp	\N
30068	1211	ana4tp	\N
30069	1211	bfl4tp	\N
30070	1211	cna5tp	\N
30071	1211	dna5tp	\N
30072	1211	ena5tp	\N
30073	1211	fna5tp	\N
30074	1211	ena5tp	\N
30075	1211	dna5tp	\N
30076	1211	cna5tp	\N
30077	1211	bfl4tp	\N
30078	1211	ana4tp	\N
30079	1211	gna4tp	\N
30080	1211	fna4tp	\N
30081	1212	gna4tp	\N
30082	1212	ana4tp	\N
30083	1212	bna4tp	\N
30084	1212	cna5tp	\N
30085	1212	dna5tp	\N
30086	1212	ena5tp	\N
30087	1212	fsh5tp	\N
30088	1212	gna5tp	\N
30089	1212	fsh5tp	\N
30090	1212	ena5tp	\N
30091	1212	dna5tp	\N
30092	1212	cna5tp	\N
30093	1212	bna4tp	\N
30094	1212	ana4tp	\N
30095	1212	gna4tp	\N
30096	1213	fsh3tp	\N
30097	1213	gna3tp	\N
30098	1213	ana3tp	\N
30099	1213	fna5tp	\N
30100	1213	fsh5tp	\N
30101	1213	gna5tp	\N
30102	1213	ana5tp	\N
30103	1214	gna3tp	\N
30104	1214	ana3tp	\N
30105	1214	bna3tp	\N
30106	1214	cna4tp	\N
30107	1214	dna4tp	\N
30108	1214	ena4tp	\N
30109	1214	fsh4tp	\N
30110	1214	gna4tp	\N
30111	1214	ana4tp	\N
30112	1214	bna4tp	\N
30113	1214	cna5tp	\N
30114	1214	dna5tp	\N
30115	1214	ena5tp	\N
30116	1214	fsh5tp	\N
30117	1214	gna5tp	\N
30118	1214	fsh5tp	\N
30119	1214	ena5tp	\N
30120	1214	dna5tp	\N
30121	1214	cna5tp	\N
30122	1214	bna4tp	\N
30123	1214	ana4tp	\N
30124	1214	gna4tp	\N
30125	1214	fsh4tp	\N
30126	1214	ena4tp	\N
30127	1214	dna4tp	\N
30128	1214	cna4tp	\N
30129	1214	bna3tp	\N
30130	1214	ana3tp	\N
30131	1214	gna3tp	\N
30132	1215	fsh3tp	\N
30133	1215	gna3tp	\N
30134	1215	ana3tp	\N
30135	1215	bfl3tp	\N
30136	1215	bna3tp	\N
30137	1215	cna4tp	\N
30138	1215	csh4tp	\N
30139	1215	dna4tp	\N
30140	1215	ena4tp	\N
30141	1215	efl4tp	\N
30142	1215	ffl4tp	\N
30143	1215	fsh4tp	\N
30144	1215	gna4tp	\N
30145	1215	ana4tp	\N
30146	1215	bfl4tp	\N
30147	1215	bna4tp	\N
30148	1215	cna5tp	\N
30149	1215	csh5tp	\N
30150	1215	dna5tp	\N
30151	1215	ena5tp	\N
30152	1215	efl5tp	\N
30153	1215	fna5tp	\N
30154	1215	fsh5tp	\N
30155	1215	gna5tp	\N
30156	1215	fsh5tp	\N
40000	1300	gsh3tp	\N
40001	1300	ana3tp	\N
40002	1300	fsh3tp	\N
40003	1300	gna3tp	\N
40004	1301	afl3tp	\N
40005	1301	gsh3tp	\N
40006	1301	fsh3tp	\N
40007	1301	bfl3tp	\N
40008	1301	ana3tp	\N
40009	1301	gna3tp	\N
40010	1302	fsh3tp	\N
40011	1302	gna3tp	\N
40012	1302	ana3tp	\N
40013	1302	afl3tp	\N
40014	1302	bfl3tp	\N
40015	1302	bna3tp	\N
40016	1302	cna4tp	\N
40017	1302	csh4tp	\N
40018	1303	dsh4tp	\N
40019	1303	efl4tp	\N
40020	1303	dna4tp	\N
40021	1303	csh4tp	\N
40022	1304	dfl4tp	\N
40023	1304	efl4tp	\N
40024	1304	dna4tp	\N
40025	1304	csh4tp	\N
40026	1305	dsh4tp	\N
40027	1305	dna4tp	\N
40028	1305	dfl4tp	\N
40029	1305	efl4tp	\N
40030	1305	ena4tp	\N
40031	1305	csh4tp	\N
40032	1305	cna4tp	\N
40033	1306	fsh3tp	\N
40034	1306	gsh3tp	\N
40035	1306	afl3tp	\N
40036	1306	bfl3tp	\N
40037	1306	csh4tp	\N
40038	1307	afl4tp	\N
40039	1307	gna4tp	\N
40040	1307	ana4tp	\N
40041	1307	bfl4tp	\N
40042	1308	gsh4tp	\N
40043	1308	afl4tp	\N
40044	1308	gna4tp	\N
40045	1308	ana4tp	\N
40046	1308	bfl4tp	\N
40047	1309	efl4tp	\N
40048	1309	fna4tp	\N
40049	1309	gna4tp	\N
40050	1309	afl4tp	\N
40051	1309	bfl4tp	\N
40052	1309	cna5tp	\N
40053	1309	dna5tp	\N
40054	1309	efl5tp	\N
40055	1309	dna5tp	\N
40056	1309	cna5tp	\N
40057	1309	bfl4tp	\N
40058	1309	afl4tp	\N
40059	1309	gna4tp	\N
40060	1309	fna4tp	\N
40061	1309	efl4tp	\N
40062	1310	ena4tp	\N
40063	1310	fsh4tp	\N
40064	1310	gsh4tp	\N
40065	1310	ana4tp	\N
40066	1310	bna4tp	\N
40067	1310	csh5tp	\N
40068	1310	dsh5tp	\N
40069	1310	ena5tp	\N
40070	1310	dsh5tp	\N
40071	1310	csh5tp	\N
40072	1310	bna4tp	\N
40073	1310	ana4tp	\N
40074	1310	gsh4tp	\N
40075	1310	fsh4tp	\N
40076	1310	ena4tp	\N
40077	1311	ana3tp	\N
40078	1311	bna3tp	\N
40079	1311	csh4tp	\N
40080	1311	dna4tp	\N
40081	1311	ena4tp	\N
40082	1311	fsh4tp	\N
40083	1311	gsh4tp	\N
40084	1311	ana4tp	\N
40085	1311	gsh4tp	\N
40086	1311	fsh4tp	\N
40087	1311	ena4tp	\N
40088	1311	dna4tp	\N
40089	1311	csh4tp	\N
40090	1311	bna3tp	\N
40091	1311	ana3tp	\N
40092	1312	afl3tp	\N
40093	1312	bfl3tp	\N
40094	1312	cna4tp	\N
40095	1312	dfl4tp	\N
40096	1312	efl4tp	\N
40097	1312	fna4tp	\N
40098	1312	gna4tp	\N
40099	1312	afl4tp	\N
40100	1312	gna4tp	\N
40101	1312	fna4tp	\N
40102	1312	efl4tp	\N
40103	1312	dfl4tp	\N
40104	1312	cna4tp	\N
40105	1312	bfl3tp	\N
40106	1312	afl3tp	\N
40107	1313	efl4tp	\N
40108	1313	ena4tp	\N
40109	1313	fsh4tp	\N
40110	1313	gna4tp	\N
40111	1313	afl4tp	\N
40112	1313	bfl4tp	\N
40113	1313	bna4tp	\N
40114	1314	dfl5tp	\N
40115	1314	cna5tp	\N
40116	1314	bfl4tp	\N
40117	1314	efl5tp	\N
40118	1315	dsh5tp	\N
40119	1315	csh5tp	\N
40120	1315	bna4tp	\N
40121	1315	efl5tp	\N
40122	1316	gsh5tp	\N
40123	1316	gna5tp	\N
40124	1316	fsh5tp	\N
40125	1316	ana5tp	\N
40126	1317	afl5tp	\N
40127	1317	gna5tp	\N
40128	1317	gsh5tp	\N
40129	1317	ana5tp	\N
40130	1317	fsh5tp	\N
40131	1318	ana4tp	\N
40132	1318	bna4tp	\N
40133	1318	csh5tp	\N
40134	1318	dna5tp	\N
40135	1318	ena5tp	\N
40136	1318	fsh5tp	\N
40137	1318	gsh5tp	\N
40138	1318	ana5tp	\N
40139	1318	gsh5tp	\N
40140	1318	fsh5tp	\N
40141	1318	ena5tp	\N
40142	1318	dna5tp	\N
40143	1318	csh5tp	\N
40144	1318	bna4tp	\N
40145	1318	ana4tp	\N
40146	1319	ena4tp	\N
40147	1319	fsh4tp	\N
40148	1319	gsh4tp	\N
40149	1319	ana4tp	\N
40150	1319	bna4tp	\N
40151	1319	csh5tp	\N
40152	1319	dsh5tp	\N
40153	1319	ena5tp	\N
40154	1319	dsh5tp	\N
40155	1319	csh5tp	\N
40156	1319	bna4tp	\N
40157	1319	ana4tp	\N
40158	1319	gsh4tp	\N
40159	1319	fsh4tp	\N
40160	1319	ena4tp	\N
40161	1320	afl4tp	\N
40162	1320	bfl4tp	\N
40163	1320	cna5tp	\N
40164	1320	dfl5tp	\N
40165	1320	efl5tp	\N
40166	1320	fna5tp	\N
40167	1320	gna5tp	\N
40168	1320	afl5tp	\N
40169	1320	gna5tp	\N
40170	1320	fna5tp	\N
40171	1320	efl5tp	\N
40172	1320	dfl5tp	\N
40173	1320	cna5tp	\N
40174	1320	bfl4tp	\N
40175	1320	afl4tp	\N
40176	1321	cna5tp	\N
40177	1321	csh5tp	\N
40178	1321	dsh5tp	\N
40179	1321	dna5tp	\N
40180	1321	dfl5tp	\N
40181	1321	efl5tp	\N
40182	1321	ena5tp	\N
40183	1322	gsh3tp	\N
40184	1322	gsh4tp	\N
40185	1322	gsh5tp	\N
40186	1322	afl3tp	\N
40187	1322	afl4tp	\N
40188	1322	afl5tp	\N
40189	1322	dsh4tp	\N
40190	1322	dsh5tp	\N
40191	1322	dfl4tp	\N
40192	1322	dfl5tp	\N
40193	1323	gsh3tp	\N
40194	1323	gsh4tp	\N
40195	1323	gsh5tp	\N
40196	1323	afl3tp	\N
40197	1323	afl4tp	\N
40198	1323	afl5tp	\N
40199	1323	dsh4tp	\N
40200	1323	dsh5tp	\N
40201	1323	dfl4tp	\N
40202	1323	dfl5tp	\N
40203	1323	fsh3tp	\N
40204	1323	fsh4tp	\N
40205	1323	bfl3tp	\N
40206	1323	bfl4tp	\N
40207	1323	csh4tp	\N
40208	1323	csh5tp	\N
40209	1323	efl4tp	\N
40210	1323	efl5tp	\N
40211	1324	ana3tp	\N
40212	1324	bna3tp	\N
40213	1324	csh4tp	\N
40214	1324	dna4tp	\N
40215	1324	ena4tp	\N
40216	1324	fsh4tp	\N
40217	1324	gsh4tp	\N
40218	1324	ana4tp	\N
40219	1324	bna4tp	\N
40220	1324	csh5tp	\N
40221	1324	dna5tp	\N
40222	1324	ena5tp	\N
40223	1324	fsh5tp	\N
40224	1324	gsh5tp	\N
40225	1324	ana5tp	\N
40226	1324	gsh5tp	\N
40227	1324	fsh5tp	\N
40228	1324	ena5tp	\N
40229	1324	dna5tp	\N
40230	1324	csh5tp	\N
40231	1324	bna4tp	\N
40232	1324	ana4tp	\N
40233	1324	gsh4tp	\N
40234	1324	fsh4tp	\N
40235	1324	ena4tp	\N
40236	1324	dna4tp	\N
40237	1324	csh4tp	\N
40238	1324	bna3tp	\N
40239	1324	ana3tp	\N
40240	1325	afl3tp	\N
40241	1325	bfl3tp	\N
40242	1325	cna4tp	\N
40243	1325	dfl4tp	\N
40244	1325	efl4tp	\N
40245	1325	fna4tp	\N
40246	1325	gna4tp	\N
40247	1325	afl4tp	\N
40248	1325	bfl4tp	\N
40249	1325	cna5tp	\N
40250	1325	dfl5tp	\N
40251	1325	efl5tp	\N
40252	1325	fna5tp	\N
40253	1325	gna5tp	\N
40254	1325	afl5tp	\N
40255	1325	gna5tp	\N
40256	1325	fna5tp	\N
40257	1325	efl5tp	\N
40258	1325	dfl5tp	\N
40259	1325	cna5tp	\N
40260	1325	bfl4tp	\N
40261	1325	afl4tp	\N
40262	1325	gna4tp	\N
40263	1325	fna4tp	\N
40264	1325	efl4tp	\N
40265	1325	dfl4tp	\N
40266	1325	cna4tp	\N
40267	1325	bfl3tp	\N
40268	1325	afl3tp	\N
40269	1326	fsh3tp	\N
40270	1326	gna3tp	\N
40271	1326	gsh3tp	\N
40272	1326	afl3tp	\N
40273	1326	ana3tp	\N
40274	1326	bna3tp	\N
40275	1326	bfl3tp	\N
40276	1326	cna4tp	\N
40277	1326	csh4tp	\N
40278	1326	dfl4tp	\N
40279	1326	dsh4tp	\N
40280	1326	dna4tp	\N
40281	1326	efl4tp	\N
40282	1326	ena4tp	\N
40283	1326	fna4tp	\N
40284	1326	fsh4tp	\N
40285	1326	gna4tp	\N
40286	1326	gsh4tp	\N
40287	1326	afl4tp	\N
40288	1326	ana4tp	\N
40289	1326	bfl4tp	\N
40290	1326	bna4tp	\N
40291	1326	cna5tp	\N
40292	1326	csh5tp	\N
40293	1326	dfl5tp	\N
40294	1326	dna5tp	\N
40295	1326	dsh5tp	\N
40296	1326	efl5tp	\N
40297	1326	ena5tp	\N
40298	1326	fna5tp	\N
40299	1326	fsh5tp	\N
40300	1326	gna5tp	\N
40301	1326	gsh5tp	\N
40302	1326	afl5tp	\N
40303	1326	ana5tp	\N
50000	1400	bfl5tp	\N
50001	1400	bna5tp	\N
50002	1400	ana5tp	\N
50003	1400	gna5tp	\N
50004	1401	bfl5tp	\N
50005	1401	bna5tp	\N
50006	1401	ana5tp	\N
50007	1401	cna6tp	\N
50008	1402	bfl3tp	\N
50009	1402	cna4tp	\N
50010	1402	dna4tp	\N
50011	1402	efl4tp	\N
50012	1402	fna4tp	\N
50013	1402	gna4tp	\N
50014	1402	ana4tp	\N
50015	1402	bfl4tp	\N
50016	1402	cna5tp	\N
50017	1402	dna5tp	\N
50018	1402	efl5tp	\N
50019	1402	fna5tp	\N
50020	1402	gna5tp	\N
50021	1402	ana5tp	\N
50022	1402	bfl5tp	\N
50023	1402	ana5tp	\N
50024	1402	gna5tp	\N
50025	1402	fna5tp	\N
50026	1402	efl5tp	\N
50027	1402	dna5tp	\N
50028	1402	cna5tp	\N
50029	1402	bfl4tp	\N
50030	1402	ana4tp	\N
50031	1402	gna4tp	\N
50032	1402	fna4tp	\N
50033	1402	efl4tp	\N
50034	1402	dna4tp	\N
50035	1402	cna4tp	\N
50036	1402	bfl3tp	\N
50037	1403	cna4tp	\N
50038	1403	dna4tp	\N
50039	1403	ena4tp	\N
50040	1403	fna4tp	\N
50041	1403	gna4tp	\N
50042	1403	ana4tp	\N
50043	1403	bna4tp	\N
50044	1403	cna5tp	\N
50045	1403	dna5tp	\N
50046	1403	ena5tp	\N
50047	1403	fna5tp	\N
50048	1403	gna5tp	\N
50049	1403	ana5tp	\N
50050	1403	bna5tp	\N
50051	1403	cna6tp	\N
50052	1403	bna5tp	\N
50053	1403	ana5tp	\N
50054	1403	gna5tp	\N
50055	1403	fna5tp	\N
50056	1403	ena5tp	\N
50057	1403	dna5tp	\N
50058	1403	cna5tp	\N
50059	1403	bna4tp	\N
50060	1403	ana4tp	\N
50061	1403	gna4tp	\N
50062	1403	fna4tp	\N
50063	1403	ena4tp	\N
50064	1403	dna4tp	\N
50065	1403	cna4tp	\N
50066	1404	bfl5tp	\N
50067	1404	bna5tp	\N
50068	1404	cna6tp	\N
50069	1404	csh6tp	\N
50070	1405	bna5tp	\N
50071	1405	csh6tp	\N
50072	1405	cna6tp	\N
50073	1405	dna6tp	\N
50074	1406	dna4tp	\N
50075	1406	ena4tp	\N
50076	1406	fsh4tp	\N
50077	1406	gna4tp	\N
50078	1406	ana4tp	\N
50079	1406	bna4tp	\N
50080	1406	csh5tp	\N
50081	1406	dna5tp	\N
50082	1406	ena5tp	\N
50083	1406	fsh5tp	\N
50084	1406	gna5tp	\N
50085	1406	ana5tp	\N
50086	1406	bna5tp	\N
50087	1406	csh6tp	\N
50088	1406	dna6tp	\N
50089	1406	csh6tp	\N
50090	1406	bna5tp	\N
50091	1406	ana5tp	\N
50092	1406	gna5tp	\N
50093	1406	fsh5tp	\N
50094	1406	ena5tp	\N
50095	1406	dna5tp	\N
50096	1406	csh5tp	\N
50097	1406	bna4tp	\N
50098	1406	ana4tp	\N
50099	1406	gna4tp	\N
50100	1406	fsh4tp	\N
50101	1406	ena4tp	\N
50102	1406	dna4tp	\N
50103	1407	bfl5tp	\N
50104	1407	dfl6tp	\N
50105	1407	dna6tp	\N
50106	1407	cna6tp	\N
50107	1408	bna5tp	\N
50108	1408	csh6tp	\N
50109	1408	dna6tp	\N
50110	1408	dsh6tp	\N
50111	1409	bna5tp	\N
50112	1409	csh6tp	\N
50113	1409	dna6tp	\N
50114	1409	dsh6tp	\N
50115	1409	ena6tp	\N
50116	1410	csh6tp	\N
50117	1410	dna6tp	\N
50118	1410	ena6tp	\N
50119	1410	efl6tp	\N
50120	1411	cna6tp	\N
50121	1411	dna6tp	\N
50122	1411	ena6tp	\N
50123	1411	fna6tp	\N
50124	1412	bfl5tp	\N
50125	1412	bna5tp	\N
50126	1412	cna6tp	\N
50127	1412	csh6tp	\N
50128	1412	dfl6tp	\N
50129	1412	dna6tp	\N
50130	1412	dsh6tp	\N
50131	1412	efl6tp	\N
50132	1412	ena6tp	\N
50133	1412	fna6tp	\N
80000	1700	cdf4tp	\N
80001	1700	cdf5tp	\N
80002	1700	cdf6tp	\N
80003	1700	cfl4tp	\N
80004	1700	cfl5tp	\N
80005	1700	cfl6tp	\N
80006	1700	cna4tp	\N
80007	1700	cna5tp	\N
80008	1700	cna6tp	\N
80009	1700	csh4tp	\N
80010	1700	csh5tp	\N
80011	1700	csh6tp	\N
80012	1700	cds4tp	\N
80013	1700	cds5tp	\N
80014	1700	cds6tp	\N
80015	1700	ddf4tp	\N
80016	1700	ddf5tp	\N
80017	1700	ddf6tp	\N
80018	1700	dfl4tp	\N
80019	1700	dfl5tp	\N
80020	1700	dfl6tp	\N
80021	1700	dna4tp	\N
80022	1700	dna5tp	\N
80023	1700	dna6tp	\N
80024	1700	dsh4tp	\N
80025	1700	dsh5tp	\N
80026	1700	dsh6tp	\N
80027	1700	dds4tp	\N
80028	1700	dds5tp	\N
80029	1700	dds6tp	\N
80030	1700	edf4tp	\N
80031	1700	edf5tp	\N
80032	1700	edf6tp	\N
80033	1700	efl4tp	\N
80034	1700	efl5tp	\N
80035	1700	efl6tp	\N
80036	1700	ena4tp	\N
80037	1700	ena5tp	\N
80038	1700	ena6tp	\N
80039	1700	esh4tp	\N
80040	1700	esh5tp	\N
80041	1700	esh6tp	\N
80042	1700	eds4tp	\N
80043	1700	eds5tp	\N
80044	1700	fdf4tp	\N
80045	1700	fdf5tp	\N
80046	1700	fdf6tp	\N
80047	1700	ffl4tp	\N
80048	1700	ffl5tp	\N
80049	1700	ffl6tp	\N
80050	1700	fna4tp	\N
80051	1700	fna5tp	\N
80052	1700	fna6tp	\N
80053	1700	fsh3tp	\N
80054	1700	fsh4tp	\N
80055	1700	fsh5tp	\N
80056	1700	fds3tp	\N
80057	1700	fds4tp	\N
80058	1700	fds5tp	\N
80059	1700	gdf4tp	\N
80060	1700	gdf5tp	\N
80061	1700	gfl3tp	\N
80062	1700	gfl4tp	\N
80063	1700	gfl5tp	\N
80064	1700	gna3tp	\N
80065	1700	gna4tp	\N
80066	1700	gna5tp	\N
80067	1700	gsh3tp	\N
80068	1700	gsh4tp	\N
70000	1600	cdf4tp	\N
70001	1600	ddf4tp	\N
70002	1600	edf4tp	\N
70003	1600	fdf4tp	\N
70004	1600	gdf4tp	\N
70005	1600	adf4tp	\N
70006	1600	bdf4tp	\N
70007	1601	cds4tp	\N
70008	1601	dds4tp	\N
70009	1601	eds4tp	\N
70010	1601	fds4tp	\N
70011	1601	gds4tp	\N
70012	1601	ads4tp	\N
70013	1601	bds4tp	\N
70014	1602	cdf5tp	\N
70015	1602	ddf5tp	\N
70016	1602	edf5tp	\N
70017	1602	fdf5tp	\N
70018	1602	gdf5tp	\N
70019	1602	adf5tp	\N
70020	1602	bdf5tp	\N
70021	1602	cdf6tp	\N
70022	1602	ddf6tp	\N
70023	1602	edf6tp	\N
70024	1603	cds5tp	\N
70025	1603	dds5tp	\N
70026	1603	eds5tp	\N
70027	1603	fds5tp	\N
70028	1603	gds5tp	\N
70029	1603	ads5tp	\N
70030	1603	bds5tp	\N
70031	1603	cds6tp	\N
70032	1603	dds6tp	\N
70034	1604	adf3tp	\N
70035	1604	bdf3tp	\N
70036	1604	cdf4tp	\N
70037	1604	ddf4tp	\N
70038	1604	edf4tp	\N
70039	1604	fdf4tp	\N
70040	1605	fds3tp	\N
70041	1605	gds3tp	\N
70042	1605	ads3tp	\N
70043	1605	bds3tp	\N
70044	1605	cds4tp	\N
70045	1605	dds4tp	\N
70046	1605	eds4tp	\N
70047	1605	fds4tp	\N
70048	1606	cdf4tp	\N
70049	1606	cna4tp	\N
70050	1606	cds4tp	\N
70051	1606	ddf4tp	\N
70052	1606	dna4tp	\N
70053	1606	dds4tp	\N
70054	1606	edf4tp	\N
70055	1606	ena4tp	\N
70056	1606	eds4tp	\N
70057	1606	fds4tp	\N
70058	1606	fna4tp	\N
70059	1606	fds4tp	\N
70060	1606	gdf4tp	\N
70061	1606	gna4tp	\N
70062	1606	gds4tp	\N
70063	1606	ads4tp	\N
70064	1606	ana4tp	\N
70065	1606	ads4tp	\N
70066	1606	bdf4tp	\N
70067	1606	bna4tp	\N
70068	1606	bds4tp	\N
80069	1700	gsh5tp	\N
80070	1700	gds3tp	\N
80071	1700	gds4tp	\N
80072	1700	gds5tp	\N
80073	1700	adf3tp	\N
80074	1700	adf4tp	\N
80075	1700	adf5tp	\N
80076	1700	afl3tp	\N
80077	1700	afl4tp	\N
80078	1700	afl5tp	\N
80079	1700	ana3tp	\N
80080	1700	ana4tp	\N
80081	1700	ana5tp	\N
80082	1700	ash3tp	\N
80083	1700	ash4tp	\N
80084	1700	ash5tp	\N
80085	1700	ads3tp	\N
80086	1700	ads4tp	\N
80087	1700	ads5tp	\N
80088	1700	bdf3tp	\N
80089	1700	bdf4tp	\N
80090	1700	bdf5tp	\N
80091	1700	bfl3tp	\N
80092	1700	bfl4tp	\N
80093	1700	bfl5tp	\N
80094	1700	bna3tp	\N
80095	1700	bna4tp	\N
80096	1700	bna5tp	\N
80097	1700	bsh3tp	\N
80098	1700	bsh4tp	\N
80099	1700	bsh5tp	\N
80100	1700	bds3tp	\N
80101	1700	bds4tp	\N
80102	1700	bds5tp	\N
80103	1701	cdf4tp	\N
80104	1701	cdf5tp	\N
80105	1701	cdf6tp	\N
80106	1701	cfl4tp	\N
80107	1701	cfl5tp	\N
80108	1701	cfl6tp	\N
80109	1701	cna4tp	\N
80110	1701	cna5tp	\N
80111	1701	cna6tp	\N
80112	1701	csh4tp	\N
80113	1701	csh5tp	\N
80114	1701	csh6tp	\N
80115	1701	cds4tp	\N
80116	1701	cds5tp	\N
80117	1701	cds6tp	\N
80118	1701	ddf4tp	\N
80119	1701	ddf5tp	\N
80120	1701	ddf6tp	\N
80121	1701	dfl4tp	\N
80122	1701	dfl5tp	\N
80123	1701	dfl6tp	\N
80124	1701	dna4tp	\N
80125	1701	dna5tp	\N
80126	1701	dna6tp	\N
80127	1701	dsh4tp	\N
80128	1701	dsh5tp	\N
80129	1701	dsh6tp	\N
80130	1701	dds4tp	\N
80131	1701	dds5tp	\N
80132	1701	dds6tp	\N
80133	1701	edf4tp	\N
80134	1701	edf5tp	\N
80135	1701	edf6tp	\N
80136	1701	efl4tp	\N
80137	1701	efl5tp	\N
80138	1701	efl6tp	\N
80139	1701	ena4tp	\N
80140	1701	ena5tp	\N
80141	1701	ena6tp	\N
80142	1701	esh4tp	\N
80143	1701	esh5tp	\N
80144	1701	esh6tp	\N
80145	1701	eds4tp	\N
80146	1701	eds5tp	\N
80147	1701	fdf4tp	\N
80148	1701	fdf5tp	\N
80149	1701	fdf6tp	\N
80150	1701	ffl4tp	\N
80151	1701	ffl5tp	\N
80152	1701	ffl6tp	\N
80153	1701	fna4tp	\N
80154	1701	fna5tp	\N
80155	1701	fna6tp	\N
80156	1701	fsh3tp	\N
80157	1701	fsh4tp	\N
80158	1701	fsh5tp	\N
80159	1701	fds3tp	\N
80160	1701	fds4tp	\N
80161	1701	fds5tp	\N
80162	1701	gdf4tp	\N
80163	1701	gdf5tp	\N
80164	1701	gfl3tp	\N
80165	1701	gfl4tp	\N
80166	1701	gfl5tp	\N
80167	1701	gna3tp	\N
80168	1701	gna4tp	\N
80169	1701	gna5tp	\N
80170	1701	gsh3tp	\N
80171	1701	gsh4tp	\N
80172	1701	gsh5tp	\N
80173	1701	gds3tp	\N
80174	1701	gds4tp	\N
80175	1701	gds5tp	\N
80176	1701	adf3tp	\N
80177	1701	adf4tp	\N
80178	1701	adf5tp	\N
80179	1701	afl3tp	\N
80180	1701	afl4tp	\N
80181	1701	afl5tp	\N
80182	1701	ana3tp	\N
80183	1701	ana4tp	\N
80184	1701	ana5tp	\N
80185	1701	ash3tp	\N
80186	1701	ash4tp	\N
80187	1701	ash5tp	\N
80188	1701	ads3tp	\N
80189	1701	ads4tp	\N
80190	1701	ads5tp	\N
80191	1701	bdf3tp	\N
80192	1701	bdf4tp	\N
80193	1701	bdf5tp	\N
80194	1701	bfl3tp	\N
80195	1701	bfl4tp	\N
80196	1701	bfl5tp	\N
80197	1701	bna3tp	\N
80198	1701	bna4tp	\N
80199	1701	bna5tp	\N
80200	1701	bsh3tp	\N
80201	1701	bsh4tp	\N
80202	1701	bsh5tp	\N
80203	1701	bds3tp	\N
80204	1701	bds4tp	\N
80205	1701	bds5tp	\N
60000	1500	gfl3tp	\N
60001	1500	gfl4tp	\N
60002	1500	gfl5tp	\N
60003	1500	gna3tp	\N
60004	1500	gna4tp	\N
60005	1500	gna5tp	\N
60006	1501	cfl4tp	\N
60007	1501	cfl5tp	\N
60008	1501	cfl6tp	\N
60009	1501	bfl3tp	\N
60010	1501	bfl4tp	\N
60011	1501	bfl5tp	\N
60012	1501	dfl4tp	\N
60013	1501	dfl5tp	\N
60014	1501	dfl6tp	\N
60015	1502	ffl4tp	\N
60016	1502	ffl5tp	\N
60017	1502	efl4tp	\N
60018	1502	efl5tp	\N
60019	1502	fna4tp	\N
60020	1502	fna5tp	\N
60021	1502	fsh4tp	\N
60022	1502	fsh5tp	\N
60023	1502	ena4tp	\N
60024	1502	ena5tp	\N
60025	1503	dfl4tp	\N
60026	1503	efl4tp	\N
60027	1503	fna4tp	\N
60028	1503	gfl4tp	\N
60029	1503	afl4tp	\N
60030	1503	bfl4tp	\N
60031	1503	cna5tp	\N
60032	1503	dfl5tp	\N
60033	1503	efl5tp	\N
60034	1503	fna5tp	\N
60035	1503	gfl5tp	\N
60036	1503	afl5tp	\N
60037	1503	bfl5tp	\N
60038	1503	cna6tp	\N
60039	1503	dfl6tp	\N
60040	1503	cna6tp	\N
60041	1503	bfl5tp	\N
60042	1503	afl5tp	\N
60043	1503	gfl5tp	\N
60044	1503	fna5tp	\N
60045	1503	efl5tp	\N
60046	1503	dfl5tp	\N
60047	1503	cna5tp	\N
60048	1503	bfl4tp	\N
60049	1503	afl4tp	\N
60050	1503	gfl4tp	\N
60051	1503	fna4tp	\N
60052	1503	efl4tp	\N
60053	1503	dfl4tp	\N
60054	1504	gfl3tp	\N
60055	1504	gfl4tp	\N
60056	1504	gfl5tp	\N
60057	1504	cfl4tp	\N
60058	1504	cfl5tp	\N
60059	1504	cfl6tp	\N
60060	1504	ffl4tp	\N
60061	1504	ffl5tp	\N
60062	1504	ffl6tp	\N
60063	1505	ash3tp	\N
60064	1505	ash4tp	\N
60065	1505	ash5tp	\N
60066	1505	gsh3tp	\N
60067	1505	gsh4tp	\N
60068	1505	gsh5tp	\N
60069	1505	fsh3tp	\N
60070	1505	fsh4tp	\N
60071	1505	fsh5tp	\N
60072	1506	esh4tp	\N
60073	1506	esh5tp	\N
60074	1506	ffl4tp	\N
60075	1506	ffl5tp	\N
60076	1506	fna4tp	\N
60077	1506	fna5tp	\N
60078	1506	fsh4tp	\N
60079	1506	fsh5tp	\N
60080	1506	dsh4tp	\N
60081	1506	dsh5tp	\N
60082	1506	efl4tp	\N
60083	1506	efl5tp	\N
60084	1507	bsh3tp	\N
60085	1507	bsh4tp	\N
60086	1507	bsh5tp	\N
60087	1507	csh4tp	\N
60088	1507	csh5tp	\N
60089	1507	csh6tp	\N
60090	1507	dsh4tp	\N
60091	1507	dsh5tp	\N
60092	1507	dsh6tp	\N
60093	1508	fsh3tp	\N
60094	1508	gsh3tp	\N
60095	1508	ash3tp	\N
60096	1508	bna3tp	\N
60097	1508	csh4tp	\N
60098	1508	dsh4tp	\N
60099	1508	esh4tp	\N
60100	1508	fsh4tp	\N
60101	1508	gsh4tp	\N
60102	1508	ash4tp	\N
60103	1508	bna4tp	\N
60104	1508	csh5tp	\N
60105	1508	dsh5tp	\N
60106	1508	esh5tp	\N
60107	1508	fsh5tp	\N
60108	1508	esh5tp	\N
60109	1508	dsh5tp	\N
60110	1508	csh5tp	\N
60111	1508	bna4tp	\N
60112	1508	ash4tp	\N
60113	1508	gsh4tp	\N
60114	1508	fsh4tp	\N
60115	1508	esh4tp	\N
60116	1508	dsh4tp	\N
60117	1508	csh4tp	\N
60118	1508	bna3tp	\N
60119	1508	ash3tp	\N
60120	1508	gsh3tp	\N
60121	1508	fsh3tp	\N
60122	1509	gfl3tp	\N
60123	1509	afl3tp	\N
60124	1509	bfl3tp	\N
60125	1509	cfl4tp	\N
60126	1509	dfl4tp	\N
60127	1509	efl4tp	\N
60128	1509	fna4tp	\N
60129	1509	gfl4tp	\N
60130	1509	afl4tp	\N
60131	1509	bfl4tp	\N
60132	1509	cfl5tp	\N
60133	1509	dfl5tp	\N
60134	1509	efl5tp	\N
60135	1509	fna5tp	\N
60136	1509	gfl5tp	\N
60137	1509	fna5tp	\N
60138	1509	efl5tp	\N
60139	1509	dfl5tp	\N
60140	1509	cfl5tp	\N
60141	1509	bfl4tp	\N
60142	1509	afl4tp	\N
60143	1509	gfl4tp	\N
60144	1509	fna4tp	\N
60145	1509	efl4tp	\N
60146	1509	dfl4tp	\N
60147	1509	cfl4tp	\N
60148	1509	bfl3tp	\N
60149	1509	afl3tp	\N
60150	1509	gfl3tp	\N
60151	1510	ash3tp	\N
60152	1510	ash4tp	\N
60153	1510	ash5tp	\N
60154	1510	esh4tp	\N
60155	1510	esh5tp	\N
60156	1510	bsh3tp	\N
60157	1510	bsh4tp	\N
60158	1510	bsh5tp	\N
60159	1511	ash3tp	\N
60160	1511	ash4tp	\N
60161	1511	ash5tp	\N
60162	1511	esh4tp	\N
60163	1511	esh5tp	\N
60164	1511	bsh3tp	\N
60165	1511	bsh4tp	\N
60166	1511	bsh5tp	\N
60167	1511	gfl3tp	\N
60168	1511	gfl4tp	\N
60169	1511	gfl5tp	\N
60170	1511	cfl4tp	\N
60171	1511	cfl5tp	\N
60172	1511	cfl6tp	\N
60173	1511	ffl4tp	\N
60174	1511	ffl5tp	\N
60175	1511	ffl6tp	\N
60176	1512	ash3tp	\N
60177	1512	ash4tp	\N
60178	1512	ash5tp	\N
60179	1512	esh4tp	\N
60180	1512	esh5tp	\N
60181	1512	bsh3tp	\N
60182	1512	bsh4tp	\N
60183	1512	bsh5tp	\N
60184	1512	gfl3tp	\N
60185	1512	gfl4tp	\N
60186	1512	gfl5tp	\N
60187	1512	cfl4tp	\N
60188	1512	cfl5tp	\N
60189	1512	cfl6tp	\N
60190	1512	ffl4tp	\N
60191	1512	ffl5tp	\N
60192	1512	afl3tp	\N
60193	1512	afl4tp	\N
60194	1512	afl5tp	\N
60195	1512	dfl4tp	\N
60196	1512	dfl5tp	\N
60197	1512	dfl6tp	\N
60198	1512	gsh3tp	\N
60199	1512	gsh4tp	\N
60200	1512	gsh5tp	\N
60201	1512	csh4tp	\N
60202	1512	csh5tp	\N
60203	1512	csh6tp	\N
60204	1512	fna4tp	\N
60205	1512	fna5tp	\N
60206	1512	efl4tp	\N
60207	1512	efl5tp	\N
90000	2000	cna4tp	bfl3tp
90001	2000	dna4tp	cna4tp
90002	2000	ena4tp	dna4tp
90003	2000	fna4tp	efl4tp
90004	2000	gna4tp	fna4tp
90005	2000	ana4tp	gna4tp
90006	2000	bna4tp	ana4tp
90007	2000	cna5tp	bfl4tp
100000	3001	cna4tp	fsh4tp
100001	3001	dna4tp	afl4tp
100002	3001	ena4tp	bfl4tp
100003	3001	fna4tp	bna4tp
100004	3001	gna4tp	dfl5tp
100005	3001	ana4tp	efl5tp
100006	3001	bna4tp	fna5tp
100007	3001	cna5tp	fsh5tp
\.


--
-- Data for Name: quiz_pitch_attempt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_pitch_attempt (id, quiz_attempt_id_id, started_at, user_input, correct, quiz_pitch_id, ended_at) FROM stdin;
3311	893	2022-12-06 05:05:12	0	t	70019	\N
3312	893	2022-12-06 05:05:12	1	t	70023	\N
3313	893	2022-12-06 05:05:12	2	t	70017	\N
3314	893	2022-12-06 05:05:12	0	t	70019	\N
3315	893	2022-12-06 05:05:12	0	t	70022	\N
3316	893	2022-12-06 05:05:12	0	t	70015	\N
3317	893	2022-12-06 05:05:12	0	t	70019	\N
3318	893	2022-12-06 05:05:12	1	t	70014	\N
3319	893	2022-12-06 05:05:12	0	t	70019	\N
3320	893	2022-12-06 05:05:12	1	t	70018	\N
3321	893	2022-12-06 05:05:12	0	t	70015	\N
3322	893	2022-12-06 05:05:12	2	t	70017	\N
3323	893	2022-12-06 05:05:12	1	t	70021	\N
3324	893	2022-12-06 05:05:12	2	t	70017	\N
3325	893	2022-12-06 05:05:12	1	t	70023	\N
3326	893	2022-12-06 05:05:12	1	f	70017	\N
3327	893	2022-12-06 05:05:12	0	f	70017	\N
3328	893	2022-12-06 05:05:12	2	t	70017	\N
3329	893	2022-12-06 05:05:12	1	t	70016	\N
3330	893	2022-12-06 05:05:12	2	t	70017	\N
3331	893	2022-12-06 05:05:12	0	t	70015	\N
3332	893	2022-12-06 05:05:12	2	t	70017	\N
3333	893	2022-12-06 05:05:12	1	t	70014	\N
3334	893	2022-12-06 05:05:12	0	t	70015	\N
3335	893	2022-12-06 05:05:12	1	t	70014	\N
3336	893	2022-12-06 05:05:12	0	t	70019	\N
3337	893	2022-12-06 05:05:12	1	t	70023	\N
3338	893	2022-12-06 05:05:12	0	t	70019	\N
3339	893	2022-12-06 05:05:12	1	t	70014	\N
3340	893	2022-12-06 05:05:12	1	t	70023	\N
3341	893	2022-12-06 05:05:12	2	f	70021	\N
3342	893	2022-12-06 05:05:12	0	f	70021	\N
3343	893	2022-12-06 05:05:12	1	t	70021	\N
3344	893	2022-12-06 05:05:12	1	t	70014	\N
3345	894	2022-12-06 05:06:55	1	t	80032	\N
3346	894	2022-12-06 05:06:55	1	t	80000	\N
3347	894	2022-12-06 05:06:55	12	t	80020	\N
3348	894	2022-12-06 05:06:55	0	t	80058	\N
3349	894	2022-12-06 05:06:55	12	t	80081	\N
3350	894	2022-12-06 05:06:55	0	t	80058	\N
3351	894	2022-12-06 05:06:55	2	t	80087	\N
3352	894	2022-12-06 05:06:55	2	t	80086	\N
3353	894	2022-12-06 05:06:55	0	t	80028	\N
3354	894	2022-12-06 05:06:55	1	t	80014	\N
3355	894	2022-12-06 05:06:55	2	t	80004	\N
3356	894	2022-12-06 05:06:55	1	t	80060	\N
3357	894	2022-12-06 05:06:55	13	t	80021	\N
3358	894	2022-12-06 05:06:55	13	t	80030	\N
3359	894	2022-12-06 05:06:55	0	t	80029	\N
3360	894	2022-12-06 05:06:55	23	t	80033	\N
3361	894	2022-12-06 05:06:55	12	t	80010	\N
3362	894	2022-12-06 05:06:55	12	t	80080	\N
3363	894	2022-12-06 05:06:55	1	t	80091	\N
3364	894	2022-12-06 05:06:55	0	t	80057	\N
3365	894	2022-12-06 05:06:55	0	t	80065	\N
3366	894	2022-12-06 05:06:55	12	t	80088	\N
3367	894	2022-12-06 05:06:55	123	t	80061	\N
3368	894	2022-12-06 05:06:55	12	t	80010	\N
3369	894	2022-12-06 05:06:55	1	t	80032	\N
3370	894	2022-12-06 05:06:55	1	t	80092	\N
3371	894	2022-12-06 05:06:55	2	t	80046	\N
3372	894	2022-12-06 05:06:55	0	t	80037	\N
3373	894	2022-12-06 05:06:55	2	t	80096	\N
3374	894	2022-12-06 05:06:55	0	t	80057	\N
3375	895	2022-12-06 05:20:14	2	t	100005	\N
3376	895	2022-12-06 05:20:14	1	t	100002	\N
3377	895	2022-12-06 05:20:14	2	t	100003	\N
3378	895	2022-12-06 05:20:14	2	t	100007	\N
3379	895	2022-12-06 05:20:14	2	t	100005	\N
3380	895	2022-12-06 05:20:14	12	t	100004	\N
3381	895	2022-12-06 05:20:14	2	t	100007	\N
3382	895	2022-12-06 05:20:14	1	t	100006	\N
3383	895	2022-12-06 05:20:14	2	t	100005	\N
3384	895	2022-12-06 05:20:15	23	t	100001	\N
\.


--
-- Data for Name: transposition; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transposition ("interval", name, id) FROM stdin;
0	None	0
-10	Down a Minor Seventh	-10
7	Up a Perfect Fifth	7
-8	Down a Minor Sixth	-8
-5	Down a Perfect Fourth	-5
9	Up a Major Sixth	9
-3	Down a Minor Third	-3
3	Up a Minor Third	3
-7	Down a Perfect Fifth	-7
-1	Down a Minor Second	-1
4	Up a Major Third	4
11	Up a Major Seventh	11
-9	Down a Major Sixth	-9
-4	Down a Major Third	-4
-2	Down a Major Second	-2
1	Up a Minor Second	1
6	Up a Tritone	6
-12	Down a Octave	-12
-6	Down a Tritone	-6
2	Up a Major Second	2
-11	Down a Major Seventh	-11
12	Up an Octave	12
10	Up a Minor Seventh	10
8	Up a Minor Sixth	8
5	Up a Perfect Fourth	5
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, email, created_at, display_name, is_anonymous) FROM stdin;
13	\N	2022-10-13 14:29:41	\N	t
14	\N	2022-10-13 14:32:42	\N	t
15	\N	2022-10-13 15:50:02	\N	t
16	\N	2022-10-13 15:50:59	\N	t
17	\N	2022-10-13 15:51:46	\N	t
18	\N	2022-10-13 15:52:04	\N	t
19	\N	2022-10-13 15:54:09	\N	t
20	\N	2022-10-13 15:54:36	\N	t
8	anon@email.com	2022-09-07 20:16:46	\N	\N
10	anon@email.com	2022-09-29 19:15:03	\N	\N
9	anon@email.com	2022-09-07 20:17:04	\N	\N
7	anon@email.com	2022-09-07 20:16:03	\N	\N
12347243587dksjaf	\N	2022-10-13 17:54:26		t
12347243587dksjaf1	\N	2022-10-13 17:55:26		t
12347243587dksjaf12	\N	2022-10-13 17:56:12		t
1IPiMGfiOBfSxrxO9R8vrYJHKIW2	\N	2022-10-13 17:59:18	\N	t
jVnmEL9blSPdF6rYSOh4BGygpGs1	\N	2022-10-13 18:25:34	\N	t
BEoyMSYumZZgOYsTnnGGNCPfd0l1	\N	2022-10-13 19:43:19	\N	t
EGXuLFosGRTtJmmSlPviOTLEwuJ2	john_cloeter@yahoo.com	2022-10-14 16:19:29	John C	f
KCzwlBbSkKR7IbIBQzm52cHEIHc2	johncloeter@gmail.com	2022-10-14 16:21:21	John Cloeter	f
stVftvijE9dHiC3CI1L4FTmefMS2	\N	2022-10-14 20:04:22	\N	t
gRjlNoRZvvgRmmd9DzWpUKGRkzs1	johncloeter@gmail.com	2022-10-17 20:08:40	John Cloeter	f
wgwAvQFrKUghc9QiC092zmkqC4r1	\N	2022-10-18 16:08:26	\N	t
4XawSB7eihON3FohwD1ucpgUrP02	jcloeter@kipsu.com	2022-10-17 15:03:48	John Cloeter	f
MPPU5l7gUsasrFk7kETRUuhbH4s2	\N	2022-10-19 16:36:26	\N	t
v0KLnX7ishYTTV8REHtq9yZfxPq1	\N	2022-10-20 18:31:36	\N	t
fc3YN9OldjUi6p89RbXdugiLF3w1	\N	2022-10-26 22:01:19	\N	t
r09IkPAkfuU1PkFFOOPezXzYwXt1	\N	2022-10-26 22:32:35	\N	t
mSh6Am7aHIWXtoKxBo8605pBXei2	\N	2022-10-26 23:04:02	\N	t
gaAhjpGuWxV7G0fm4sRVWe26x9n2	\N	2022-10-26 23:38:58	\N	t
e16pwiBTxseyVln7zP6DiSZmJ9H3	\N	2022-10-27 00:40:48	\N	t
c5rW0M1Z7VPlkvSYkIr8p2tj6W02	\N	2022-11-22 14:35:43	\N	t
9LyECK1z9KQRGhNq8sfFEPE5Clz1	\N	2022-11-25 16:28:39	\N	t
b1hslA1YpWPTAsFFoyWrwWbKmCJ2	\N	2022-11-28 14:38:59	\N	t
720jdTbms8QQNN21tvaCFjkw1Q43	\N	2022-11-28 21:16:07	\N	t
J5j7LhMijdeZYsfH0goVsEw7E9B3	\N	2022-12-02 15:00:55	\N	t
2SVUWFkiLwg17BX0I2TJA65a2rI2	\N	2022-12-02 15:10:08	\N	t
OyOF6h4wgmY9FPClpFqi8GDVUGD2	\N	2022-12-02 19:02:44	\N	t
Nj8UqF6N2DNxpREMmTpqPjw3jZv2	\N	2022-12-02 19:43:22	\N	t
ItoU9jZDn3gboaz1OPbAdHavcc93	\N	2022-12-06 05:02:46	\N	t
\.


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: quiz_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_attempt_id_seq', 895, true);


--
-- Name: quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_id_seq', 1, false);


--
-- Name: quiz_pitch_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_pitch_attempt_id_seq', 3384, true);


--
-- Name: quiz_pitch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_pitch_id_seq', 1, false);


--
-- Name: transposition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transposition_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 21, true);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: pitch pitch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch
    ADD CONSTRAINT pitch_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempt quiz_attempt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt
    ADD CONSTRAINT quiz_attempt_pkey PRIMARY KEY (id);


--
-- Name: quiz_pitch_attempt quiz_pitch_attempt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch_attempt
    ADD CONSTRAINT quiz_pitch_attempt_pkey PRIMARY KEY (id);


--
-- Name: quiz_pitch quiz_pitch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch
    ADD CONSTRAINT quiz_pitch_pkey PRIMARY KEY (id);


--
-- Name: quiz quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_pkey PRIMARY KEY (id);


--
-- Name: transposition transposition_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transposition
    ADD CONSTRAINT transposition_pkey PRIMARY KEY ("interval");


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_a412fa924926abe9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_a412fa924926abe9 ON public.quiz USING btree (transposition_id);


--
-- Name: idx_ab6afc6853cd175; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ab6afc6853cd175 ON public.quiz_attempt USING btree (quiz_id);


--
-- Name: idx_ab6afc69d86650f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ab6afc69d86650f ON public.quiz_attempt USING btree (user_id_id);


--
-- Name: idx_b0d43f42282b3f0e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_b0d43f42282b3f0e ON public.quiz_pitch_attempt USING btree (quiz_pitch_id);


--
-- Name: idx_b0d43f42f53413b5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_b0d43f42f53413b5 ON public.quiz_pitch_attempt USING btree (quiz_attempt_id_id);


--
-- Name: idx_dbecc7592dad0c8e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dbecc7592dad0c8e ON public.quiz_pitch USING btree (transposed_answer_pitch_id);


--
-- Name: idx_dbecc759853cd175; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dbecc759853cd175 ON public.quiz_pitch USING btree (quiz_id);


--
-- Name: idx_dbecc759feefc64b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dbecc759feefc64b ON public.quiz_pitch USING btree (pitch_id);


--
-- Name: transposition_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX transposition_id_uindex ON public.transposition USING btree (id);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: quiz_attempt fk_ab6afc6853cd175; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt
    ADD CONSTRAINT fk_ab6afc6853cd175 FOREIGN KEY (quiz_id) REFERENCES public.quiz(id);


--
-- Name: quiz_pitch_attempt fk_b0d43f42282b3f0e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch_attempt
    ADD CONSTRAINT fk_b0d43f42282b3f0e FOREIGN KEY (quiz_pitch_id) REFERENCES public.quiz_pitch(id);


--
-- Name: quiz_pitch_attempt fk_b0d43f42f53413b5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch_attempt
    ADD CONSTRAINT fk_b0d43f42f53413b5 FOREIGN KEY (quiz_attempt_id_id) REFERENCES public.quiz_attempt(id);


--
-- Name: quiz_pitch fk_dbecc7598337e7d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch
    ADD CONSTRAINT fk_dbecc7598337e7d7 FOREIGN KEY (quiz_id) REFERENCES public.quiz(id);


--
-- Name: quiz_pitch fk_quiz_pitch_pitch_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch
    ADD CONSTRAINT fk_quiz_pitch_pitch_id FOREIGN KEY (pitch_id) REFERENCES public.pitch(id);


--
-- Name: quiz_pitch fk_quiz_pitch_transposed_answer_pitch_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_pitch
    ADD CONSTRAINT fk_quiz_pitch_transposed_answer_pitch_id FOREIGN KEY (transposed_answer_pitch_id) REFERENCES public.pitch(id);


--
-- Name: quiz_attempt quiz_attempt_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt
    ADD CONSTRAINT quiz_attempt_user_id_fk FOREIGN KEY (user_id_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

