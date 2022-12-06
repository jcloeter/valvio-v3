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
1	Your first 3 pitches	Early Beginner	1	Basic practice with notes C, D, E	0	10
2	Adding F	Early Beginner	2	Basic practice with notes C, D, E, F	0	12
3	Adding G	Early Beginner	3	Basic practice with notes C, D, E, F, G	0	15
4	Adding B	Early Beginner	4	Basic practice with notes C, D, E, F, G, B	0	18
5	Introducing Flats	Early Beginner	5	Basic practice with notes C, G, B, Bb	0	15
6	Your first double flats 	Advanced	100	Introduction to double flats G, Gb, Gx, C, Cb, Cx, D, Db, Dx	0	20
7	Basic transposition down Major 2nd	Transposition Beginner	500	Introduction to transposition down major 2nd C, D, E, F, G, A, B	-2	30
8	Basic transposition up Major 2nd	Transposition Beginner	600	Introduction to transposition up major 2nd C, D, E, F, G, A, B	2	24
9	Transposition on doubleflats up Major 5th	Transposition Advanced	700	Practice transposing up a Perfect 5th on double flats	7	40
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
507	7	2022-10-05 13:38:56	2022-10-05 13:41:31	149	8
511	7	2022-10-05 14:19:28	\N	\N	5
515	7	2022-10-05 14:27:45	\N	\N	2
519	7	2022-10-05 14:32:46	\N	\N	5
523	7	2022-10-05 14:53:46	2022-10-05 14:54:21	29	5
527	7	2022-10-05 15:01:59	\N	\N	3
531	7	2022-10-05 15:10:47	\N	\N	3
535	7	2022-10-05 15:24:37	2022-10-05 15:26:09	70	6
539	7	2022-10-05 16:46:57	\N	\N	4
543	7	2022-10-05 18:19:29	2022-10-05 18:20:37	55	1
547	7	2022-10-05 18:54:10	\N	\N	1
551	7	2022-10-05 19:01:25	\N	\N	7
555	7	2022-10-05 19:42:21	2022-10-05 19:43:05	37	5
559	7	2022-10-05 19:55:21	2022-10-05 20:03:32	57	8
563	7	2022-10-05 20:15:25	2022-10-05 20:16:48	75	6
567	7	2022-10-05 20:24:34	\N	\N	1
571	7	2022-10-05 20:31:55	2022-10-05 20:32:48	45	3
575	7	2022-10-06 00:11:40	\N	\N	7
579	7	2022-10-06 13:23:26	\N	\N	2
583	7	2022-10-06 14:11:48	\N	\N	9
587	7	2022-10-06 14:28:06	\N	\N	7
591	7	2022-10-06 15:10:19	\N	\N	6
595	7	2022-10-06 15:13:33	\N	\N	7
599	7	2022-10-06 15:34:50	\N	\N	7
603	7	2022-10-06 15:46:35	2022-10-06 15:48:19	96	1
607	7	2022-10-06 16:59:58	\N	\N	1
611	7	2022-10-07 13:55:39	2022-10-07 13:56:16	32	3
615	7	2022-10-07 13:58:30	\N	\N	7
619	7	2022-10-07 15:29:18	\N	\N	4
623	7	2022-10-07 20:25:34	\N	\N	2
41	7	2022-09-29 20:25:47	\N	\N	7
39	7	2022-09-29 19:59:05	2022-09-29 20:33:36	42	7
40	7	2022-09-29 20:25:44	2022-09-30 13:48:55	42	7
42	7	2022-09-30 18:33:39	2022-09-30 18:34:13	33	1
43	7	2022-09-30 18:34:54	2022-09-30 18:35:40	33	2
44	7	2022-09-30 18:36:55	2022-09-30 18:37:51	34	3
45	7	2022-09-30 20:37:23	\N	\N	3
46	7	2022-09-30 20:37:23	\N	\N	3
47	7	2022-09-30 20:37:23	\N	\N	3
48	7	2022-09-30 20:37:27	\N	\N	3
49	7	2022-09-30 20:37:27	\N	\N	3
50	7	2022-09-30 20:37:27	\N	\N	3
51	7	2022-09-30 20:37:32	\N	\N	3
52	7	2022-09-30 20:37:33	\N	\N	3
53	7	2022-09-30 20:37:33	\N	\N	3
54	7	2022-09-30 20:37:36	\N	\N	3
55	7	2022-09-30 20:37:36	\N	\N	3
56	7	2022-09-30 20:37:37	\N	\N	3
627	7	2022-10-10 13:17:08	2022-10-10 13:18:27	54	7
631	7	2022-10-11 13:54:22	\N	\N	1
635	7	2022-10-11 13:56:40	\N	\N	1
639	7	2022-10-11 13:57:38	\N	\N	1
643	7	2022-10-11 15:58:24	\N	\N	2
508	7	2022-10-05 14:11:42	\N	\N	5
512	7	2022-10-05 14:20:27	\N	\N	8
516	7	2022-10-05 14:28:49	\N	\N	4
520	7	2022-10-05 14:35:41	\N	\N	4
524	7	2022-10-05 14:55:43	\N	\N	6
528	7	2022-10-05 15:02:47	\N	\N	3
532	7	2022-10-05 15:12:07	\N	\N	3
536	7	2022-10-05 16:42:37	\N	\N	5
540	7	2022-10-05 18:05:29	\N	\N	7
544	7	2022-10-05 18:26:16	2022-10-05 18:35:16	297	2
548	7	2022-10-05 18:56:43	\N	\N	2
552	7	2022-10-05 19:01:28	\N	\N	6
556	7	2022-10-05 19:50:52	\N	\N	5
560	7	2022-10-05 20:06:56	\N	\N	6
564	7	2022-10-05 20:16:58	\N	\N	1
568	7	2022-10-05 20:26:03	2022-10-05 20:27:14	57	3
572	7	2022-10-05 20:33:21	2022-10-05 20:34:16	50	4
576	7	2022-10-06 00:13:20	\N	\N	3
580	7	2022-10-06 13:34:40	2022-10-06 13:36:01	65	7
584	7	2022-10-06 14:12:48	\N	\N	8
588	7	2022-10-06 14:34:14	\N	\N	7
592	7	2022-10-06 15:10:40	\N	\N	8
596	7	2022-10-06 15:14:34	\N	\N	7
600	7	2022-10-06 15:35:41	\N	\N	4
604	7	2022-10-06 15:48:26	\N	\N	6
608	7	2022-10-06 17:57:05	2022-10-06 18:19:09	1306	7
612	7	2022-10-07 13:56:23	2022-10-07 13:56:50	23	5
616	7	2022-10-07 13:58:37	2022-10-07 13:59:11	29	8
620	7	2022-10-07 19:18:50	\N	\N	1
624	7	2022-10-07 20:34:53	\N	\N	1
628	7	2022-10-11 13:45:29	2022-10-11 13:48:47	191	9
632	7	2022-10-11 13:54:58	\N	\N	3
636	7	2022-10-11 13:56:42	\N	\N	1
640	7	2022-10-11 13:57:40	\N	\N	1
644	7	2022-10-12 01:36:27	2022-10-12 01:37:15	17	3
509	7	2022-10-05 14:13:04	\N	\N	7
513	7	2022-10-05 14:21:40	\N	\N	1
517	7	2022-10-05 14:30:29	\N	\N	2
521	7	2022-10-05 14:37:51	\N	\N	5
525	7	2022-10-05 14:56:54	\N	\N	4
529	7	2022-10-05 15:03:57	\N	\N	4
533	7	2022-10-05 15:15:41	\N	\N	3
537	7	2022-10-05 16:43:55	\N	\N	4
541	7	2022-10-05 18:09:33	\N	\N	5
545	7	2022-10-05 18:51:00	\N	\N	1
549	7	2022-10-05 19:00:01	\N	\N	3
553	7	2022-10-05 19:28:32	\N	\N	2
557	7	2022-10-05 19:53:19	\N	\N	6
561	7	2022-10-05 20:07:35	2022-10-05 20:09:25	67	8
565	7	2022-10-05 20:18:07	2022-10-05 20:18:31	18	1
569	7	2022-10-05 20:28:14	\N	\N	2
573	7	2022-10-05 20:39:59	2022-10-05 20:40:35	30	3
577	7	2022-10-06 00:51:02	\N	\N	6
581	7	2022-10-06 13:39:25	\N	\N	1
585	7	2022-10-06 14:19:57	\N	\N	8
589	7	2022-10-06 14:36:50	\N	\N	8
593	7	2022-10-06 15:11:32	\N	\N	8
597	7	2022-10-06 15:26:06	\N	\N	7
601	7	2022-10-06 15:41:11	\N	\N	1
605	7	2022-10-06 15:50:26	2022-10-06 16:00:39	70	5
609	7	2022-10-06 20:27:59	2022-10-06 20:28:36	30	1
613	7	2022-10-07 13:57:19	2022-10-07 13:57:59	36	8
617	7	2022-10-07 14:00:41	2022-10-07 14:01:07	21	5
621	7	2022-10-07 19:33:55	\N	\N	1
625	7	2022-10-07 20:51:16	\N	\N	2
629	7	2022-10-11 13:52:47	\N	\N	1
633	7	2022-10-11 13:56:26	\N	\N	1
637	7	2022-10-11 13:57:19	\N	\N	2
641	7	2022-10-11 15:09:43	\N	\N	4
510	7	2022-10-05 14:14:29	\N	\N	5
514	7	2022-10-05 14:23:18	\N	\N	5
518	7	2022-10-05 14:31:21	\N	\N	5
522	7	2022-10-05 14:39:02	\N	\N	3
526	7	2022-10-05 15:00:11	\N	\N	1
530	7	2022-10-05 15:10:00	2022-10-05 15:10:36	29	3
534	7	2022-10-05 15:21:36	2022-10-05 15:22:15	33	3
538	7	2022-10-05 16:45:53	\N	\N	5
542	7	2022-10-05 18:12:45	\N	\N	3
546	7	2022-10-05 18:53:35	\N	\N	1
550	7	2022-10-05 19:01:18	\N	\N	7
554	7	2022-10-05 19:39:42	\N	\N	3
558	7	2022-10-05 19:54:27	2022-10-05 19:55:06	32	2
562	7	2022-10-05 20:09:43	\N	\N	6
566	7	2022-10-05 20:18:37	2022-10-05 20:19:11	26	2
570	7	2022-10-05 20:28:57	\N	\N	2
574	7	2022-10-05 20:52:47	2022-10-05 20:53:48	55	7
578	7	2022-10-06 00:52:12	\N	\N	4
582	7	2022-10-06 14:09:19	\N	\N	8
586	7	2022-10-06 14:21:50	\N	\N	7
590	7	2022-10-06 15:07:39	\N	\N	7
594	7	2022-10-06 15:12:31	\N	\N	7
598	7	2022-10-06 15:30:59	\N	\N	7
602	7	2022-10-06 15:41:15	\N	\N	3
606	7	2022-10-06 16:03:14	2022-10-06 16:03:57	28	3
610	7	2022-10-06 20:28:43	\N	\N	2
614	7	2022-10-07 13:58:20	\N	\N	7
618	7	2022-10-07 15:26:44	\N	\N	3
622	7	2022-10-07 20:01:18	\N	\N	1
626	7	2022-10-07 20:57:03	\N	\N	5
630	7	2022-10-11 13:53:39	\N	\N	1
634	7	2022-10-11 13:56:39	\N	\N	1
638	7	2022-10-11 13:57:29	\N	\N	1
642	7	2022-10-11 15:10:31	\N	\N	4
505	7	2022-10-04 20:44:04	2022-10-04 20:45:33	79	4
506	7	2022-10-04 20:47:09	2022-10-04 20:47:50	35	5
645	7	2022-10-13 18:30:06	2022-10-13 18:30:51	32	1
646	7	2022-10-13 18:31:31	2022-10-13 18:32:03	17	2
647	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:40:10	\N	\N	1
648	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:42:35	\N	\N	1
649	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:42:42	2022-10-13 18:43:10	20	1
650	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:44:02	2022-10-13 18:44:44	30	1
651	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:44:56	2022-10-13 18:46:18	21	2
652	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:47:08	\N	\N	3
653	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:47:14	\N	\N	3
654	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:51:33	\N	\N	3
655	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:51:42	\N	\N	3
656	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:52:51	\N	\N	3
657	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:52:58	\N	\N	3
658	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 18:53:18	\N	\N	3
659	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:00:51	\N	\N	3
660	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:00:51	\N	\N	3
661	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:01:01	\N	\N	4
662	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:01:11	\N	\N	4
663	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:02:16	\N	\N	4
664	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:02:26	\N	\N	5
665	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:02:36	\N	\N	5
666	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:02:39	\N	\N	5
667	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:12:24	\N	\N	5
668	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:12:44	\N	\N	4
669	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:12:55	\N	\N	4
670	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:12:58	\N	\N	4
671	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:14:06	\N	\N	4
672	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:14:16	\N	\N	4
673	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:14:21	2022-10-13 19:15:06	31	4
674	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:17:41	\N	\N	5
675	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:17:48	2022-10-13 19:18:31	28	5
676	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:20:30	\N	\N	6
677	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:24:02	\N	\N	3
678	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:33:57	2022-10-13 19:35:23	74	6
679	jVnmEL9blSPdF6rYSOh4BGygpGs1	2022-10-13 19:39:59	2022-10-13 19:41:30	69	7
680	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:44:22	\N	\N	1
681	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:47:03	2022-10-13 19:47:36	22	1
682	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:47:52	\N	\N	2
683	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:48:21	\N	\N	4
684	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:48:31	2022-10-13 19:49:13	29	4
685	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 19:49:27	2022-10-13 19:50:15	25	3
686	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:08:04	\N	\N	2
687	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:08:27	\N	\N	2
688	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:19:27	\N	\N	5
689	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:34:00	\N	\N	2
690	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:39:45	2022-10-13 20:40:22	27	5
691	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:49:08	2022-10-13 20:49:50	30	2
711	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:59:09	\N	\N	1
692	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-13 20:50:41	2022-10-13 20:52:42	22	3
693	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:04:27	\N	\N	6
694	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:04:50	\N	\N	6
695	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:04:59	\N	\N	5
696	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:05:15	\N	\N	6
697	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:11:43	\N	\N	6
698	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:11:45	\N	\N	6
699	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:12:47	\N	\N	7
700	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:16:17	\N	\N	7
701	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:16:27	\N	\N	7
702	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:16:44	\N	\N	7
703	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:17:26	\N	\N	7
704	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:18:13	\N	\N	6
705	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:19:10	\N	\N	6
706	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:20:00	\N	\N	6
707	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:20:36	\N	\N	6
708	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:22:55	\N	\N	8
709	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:23:26	\N	\N	8
710	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 14:23:48	2022-10-14 14:24:39	40	8
712	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:22:36	\N	\N	1
713	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:25:11	\N	\N	1
714	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:26:42	\N	\N	1
716	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:29:06	\N	\N	2
717	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:35:31	\N	\N	1
718	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:37:18	\N	\N	1
719	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:47:43	\N	\N	1
720	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:50:23	\N	\N	1
721	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:53:12	\N	\N	1
722	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:54:50	\N	\N	1
723	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 15:58:05	2022-10-14 15:58:53	16	1
724	BEoyMSYumZZgOYsTnnGGNCPfd0l1	2022-10-14 16:02:28	2022-10-14 16:04:08	79	1
725	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 16:25:09	2022-10-14 16:26:09	40	1
726	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 16:51:16	2022-10-14 16:52:41	73	1
727	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 16:52:55	2022-10-14 16:53:24	16	3
728	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 16:53:37	\N	\N	3
729	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 16:56:03	\N	\N	4
730	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:08:52	2022-10-14 19:23:39	818	5
731	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:03	\N	\N	2
732	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:04	\N	\N	2
733	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:27	\N	\N	2
734	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:27	\N	\N	2
735	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:33	\N	\N	2
736	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:26:39	\N	\N	6
737	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:27:45	\N	\N	6
738	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:27:45	\N	\N	6
775	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 15:18:41	2022-10-19 15:19:36	17	3
776	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 15:19:50	2022-10-19 15:20:25	14	2
777	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 15:20:39	2022-10-19 15:21:26	23	4
778	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 16:30:41	2022-10-19 16:33:13	113	3
779	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 16:34:11	\N	\N	9
780	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-19 16:39:33	\N	\N	1
781	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-19 16:40:09	\N	\N	1
784	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-20 15:57:40	\N	\N	3
785	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-20 16:54:15	\N	\N	2
786	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:32:05	2022-10-20 18:33:30	35	1
739	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-14 19:28:04	2022-10-14 19:35:59	26	4
740	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:05:34	2022-10-14 20:07:02	58	5
741	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:21:57	\N	\N	1
742	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:23:35	\N	\N	1
743	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:24:27	2022-10-14 20:24:59	19	2
744	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:25:05	2022-10-14 20:25:48	12	1
745	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:30:05	2022-10-14 20:30:35	18	3
746	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 20:31:06	\N	\N	9
747	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-14 21:07:42	2022-10-14 21:08:12	16	3
748	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-16 00:03:57	\N	\N	5
749	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-16 00:04:33	\N	\N	3
750	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:33:40	2022-10-17 16:34:34	38	8
751	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:37:37	2022-10-17 16:38:20	28	4
752	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:43:15	\N	\N	6
753	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:48:52	2022-10-17 16:49:42	36	6
754	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:50:50	2022-10-17 16:51:38	34	7
755	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:52:45	2022-10-17 16:53:16	17	3
756	stVftvijE9dHiC3CI1L4FTmefMS2	2022-10-17 16:53:57	2022-10-17 16:54:37	26	6
757	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-17 19:55:39	2022-10-17 19:56:17	13	5
758	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-17 19:57:45	2022-10-17 19:58:51	35	4
759	KCzwlBbSkKR7IbIBQzm52cHEIHc2	2022-10-17 19:59:52	2022-10-17 20:00:32	21	6
760	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-17 20:10:45	2022-10-17 20:11:08	10	1
761	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-17 20:12:44	2022-10-17 20:13:22	11	2
762	wgwAvQFrKUghc9QiC092zmkqC4r1	2022-10-18 16:09:03	2022-10-18 16:09:49	32	6
763	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-18 18:21:24	\N	\N	2
764	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-18 18:21:42	2022-10-18 18:22:23	18	3
765	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-18 19:12:22	2022-10-18 19:13:02	21	5
766	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-18 19:25:09	2022-10-18 19:25:54	11	1
767	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-18 19:26:15	2022-10-18 19:27:01	24	6
768	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-19 13:56:31	2022-10-19 13:57:41	22	2
769	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-19 13:58:22	2022-10-19 13:58:55	18	2
770	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-19 13:59:08	2022-10-19 14:00:01	17	2
771	EGXuLFosGRTtJmmSlPviOTLEwuJ2	2022-10-19 14:01:51	2022-10-19 14:02:35	18	1
772	gRjlNoRZvvgRmmd9DzWpUKGRkzs1	2022-10-19 15:13:06	2022-10-19 15:13:58	29	4
773	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 15:16:38	2022-10-19 15:17:07	12	1
774	4XawSB7eihON3FohwD1ucpgUrP02	2022-10-19 15:17:20	2022-10-19 15:18:06	17	2
787	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:34:05	2022-10-20 18:35:50	90	7
788	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:36:29	\N	\N	9
789	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:42:00	\N	\N	2
790	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:42:43	\N	\N	3
791	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:45:31	\N	\N	3
792	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:48:39	\N	\N	2
793	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:56:57	\N	\N	2
794	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:59:18	\N	\N	2
795	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 18:59:51	\N	\N	2
796	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:00:41	\N	\N	2
797	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:01:04	\N	\N	2
798	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:01:25	\N	\N	2
799	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:30:29	\N	\N	2
800	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:44:12	\N	\N	2
801	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:46:19	\N	\N	6
802	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:59:16	\N	\N	4
803	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 19:59:49	\N	\N	4
804	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 20:05:30	\N	\N	2
805	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 20:07:07	2022-10-20 20:07:52	31	3
806	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-20 20:10:23	\N	\N	2
807	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 14:29:00	\N	\N	3
808	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 16:03:59	2022-10-21 16:04:32	15	2
809	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 19:37:02	\N	\N	4
810	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 19:41:28	\N	\N	1
811	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 19:45:32	\N	\N	4
812	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 20:00:01	\N	\N	4
813	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 20:00:53	\N	\N	4
814	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 20:01:55	\N	\N	4
815	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-21 20:04:31	\N	\N	4
816	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 17:56:17	\N	\N	6
817	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:14:23	\N	\N	4
818	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:21:59	\N	\N	5
819	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:24:23	\N	\N	5
820	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:29:25	\N	\N	5
821	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:30:25	\N	\N	4
822	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:32:10	\N	\N	4
823	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:34:59	\N	\N	5
824	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 18:38:12	2022-10-24 18:39:04	36	5
825	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 19:27:07	\N	\N	7
826	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 19:29:58	2022-10-24 19:36:12	360	4
827	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 19:36:35	\N	\N	6
828	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 19:40:15	2022-10-24 19:40:55	26	4
829	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 19:47:40	\N	\N	7
830	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 20:13:44	\N	\N	6
831	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 20:14:49	\N	\N	7
832	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 20:16:46	\N	\N	4
833	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 20:18:03	\N	\N	4
834	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-24 20:20:13	2022-10-24 20:20:41	15	5
835	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:04:55	\N	\N	6
836	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:05:22	\N	\N	6
837	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:05:58	2022-10-25 18:07:03	49	6
838	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:09:49	\N	\N	2
839	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:12:22	\N	\N	1
840	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:13:19	2022-10-25 18:13:48	14	5
841	v0KLnX7ishYTTV8REHtq9yZfxPq1	2022-10-25 18:13:59	\N	\N	5
842	fc3YN9OldjUi6p89RbXdugiLF3w1	2022-10-26 22:01:36	2022-10-26 22:03:02	47	1
843	r09IkPAkfuU1PkFFOOPezXzYwXt1	2022-10-26 22:33:03	2022-10-26 22:34:17	33	1
844	r09IkPAkfuU1PkFFOOPezXzYwXt1	2022-10-26 22:35:58	\N	\N	8
845	r09IkPAkfuU1PkFFOOPezXzYwXt1	2022-10-26 22:36:59	\N	\N	9
846	mSh6Am7aHIWXtoKxBo8605pBXei2	2022-10-26 23:04:50	2022-10-26 23:06:32	54	5
847	gaAhjpGuWxV7G0fm4sRVWe26x9n2	2022-10-26 23:40:13	2022-10-26 23:41:36	41	4
848	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-27 00:41:18	2022-10-27 00:42:44	39	3
849	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-27 00:44:34	\N	\N	9
850	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 14:01:39	\N	\N	1
851	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:49:33	\N	\N	1
852	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:50:14	\N	\N	1
853	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:54:55	\N	\N	1
854	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:55:00	\N	\N	1
856	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:58:35	\N	\N	1
857	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:59:03	\N	\N	1
858	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:59:34	\N	\N	2
859	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 20:59:52	\N	\N	1
862	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:03:54	\N	\N	1
863	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:03:59	\N	\N	1
864	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:04:04	\N	\N	6
865	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:05:03	\N	\N	2
866	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:06:27	\N	\N	2
867	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:10:49	\N	\N	2
868	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:12:16	\N	\N	1
869	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-28 21:13:09	\N	\N	3
870	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-10-31 18:52:43	2022-10-31 18:53:31	12	1
871	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-11-01 19:25:56	2022-11-01 19:27:45	90	2
872	e16pwiBTxseyVln7zP6DiSZmJ9H3	2022-11-01 19:28:43	\N	\N	9
873	c5rW0M1Z7VPlkvSYkIr8p2tj6W02	2022-11-22 14:45:36	2022-11-22 14:46:04	13	2
874	9LyECK1z9KQRGhNq8sfFEPE5Clz1	2022-11-25 16:29:55	2022-11-25 16:31:21	59	1
875	4XawSB7eihON3FohwD1ucpgUrP02	2022-11-28 14:38:44	\N	\N	3
876	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:29:37	\N	\N	1103
877	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:36:20	2022-11-28 20:36:47	13	1000
878	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:50:17	2022-11-28 20:50:47	18	1308
879	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:51:24	2022-11-28 20:51:55	18	1317
880	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:52:05	2022-11-28 20:52:30	14	1203
881	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:53:14	\N	\N	1410
882	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:53:43	2022-11-28 20:54:09	15	1210
883	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:54:25	2022-11-28 20:54:51	15	1211
884	b1hslA1YpWPTAsFFoyWrwWbKmCJ2	2022-11-28 20:55:16	2022-11-28 20:56:24	55	1326
885	720jdTbms8QQNN21tvaCFjkw1Q43	2022-11-28 21:42:36	\N	\N	1215
886	720jdTbms8QQNN21tvaCFjkw1Q43	2022-11-28 21:42:48	\N	\N	1215
887	720jdTbms8QQNN21tvaCFjkw1Q43	2022-11-28 21:46:04	2022-11-28 21:46:33	16	1300
888	J5j7LhMijdeZYsfH0goVsEw7E9B3	2022-12-02 15:01:12	2022-12-02 15:01:38	13	1
889	OyOF6h4wgmY9FPClpFqi8GDVUGD2	2022-12-02 19:05:08	2022-12-02 19:05:32	9	1
890	OyOF6h4wgmY9FPClpFqi8GDVUGD2	2022-12-02 19:06:51	2022-12-02 19:07:19	13	2
891	Nj8UqF6N2DNxpREMmTpqPjw3jZv2	2022-12-02 20:52:44	2022-12-02 20:53:28	18	1200
892	Nj8UqF6N2DNxpREMmTpqPjw3jZv2	2022-12-02 21:58:23	2022-12-02 21:58:55	18	3
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
1	1	cna4tp	\N
2	1	dna4tp	\N
3	1	ena4tp	\N
4	2	cna4tp	\N
5	2	dna4tp	\N
6	2	dna4tp	\N
7	2	fna4tp	\N
8	3	cna4tp	\N
9	3	dna4tp	\N
10	3	ena4tp	\N
11	3	fna4tp	\N
12	3	gna4tp	\N
13	4	cna4tp	\N
14	4	dna4tp	\N
15	4	ena4tp	\N
16	4	fna4tp	\N
17	4	gna4tp	\N
18	4	bna3tp	\N
19	5	cna4tp	\N
20	5	gna4tp	\N
21	5	bna3tp	\N
22	5	bfl3tp	\N
23	6	gna4tp	\N
24	6	gfl4tp	\N
25	6	gdf4tp	\N
26	6	cna5tp	\N
27	6	cfl5tp	\N
28	6	cdf5tp	\N
29	6	dfl5tp	\N
30	6	ddf5tp	\N
31	7	cna4tp	bfl3tp
32	7	dna4tp	cna4tp
33	7	ena4tp	dna4tp
34	7	fna4tp	efl4tp
35	7	gna4tp	fna4tp
36	7	ana4tp	gna4tp
37	7	bna4tp	ana4tp
38	8	cna4tp	dna4tp
39	8	dna4tp	ena4tp
40	8	ena4tp	fsh4tp
41	8	fna4tp	gna4tp
42	8	gna4tp	ana4tp
43	8	ana4tp	bna4tp
44	8	bna4tp	csh5tp
45	9	ddf4tp	adf4tp
46	9	edf4tp	bdf4tp
47	9	fdf4tp	cdf5tp
48	9	gdf4tp	ddf5tp
49	9	adf4tp	edf5tp
50	9	bdf4tp	fdf5tp
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
\.


--
-- Data for Name: quiz_pitch_attempt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_pitch_attempt (id, quiz_attempt_id_id, started_at, user_input, correct, quiz_pitch_id, ended_at) FROM stdin;
73	39	2022-09-29 20:09:41	2	t	21	\N
74	39	2022-09-29 20:33:09	2	f	20	\N
75	39	2022-09-29 20:33:13	2	f	20	\N
76	39	2022-09-29 20:33:15	2	f	20	\N
77	39	2022-09-29 20:33:18	2	f	20	\N
78	39	2022-09-29 20:33:20	2	f	20	\N
79	40	2022-09-30 13:48:04	2	f	31	\N
80	40	2022-09-30 13:48:07	2	f	31	\N
81	40	2022-09-30 13:48:10	2	f	31	\N
82	43	2022-09-30 18:35:30	2	t	31	\N
83	44	2022-09-30 18:37:30	2	t	9	\N
84	44	2022-09-30 18:37:32	2	t	9	\N
85	44	2022-09-30 18:37:35	2	t	9	\N
86	44	2022-09-30 18:37:37	2	t	9	\N
324	507	2022-10-05 13:39:43	12	t	44	\N
326	507	2022-10-05 13:40:21	2	f	38	\N
328	507	2022-10-05 13:40:30	3	f	38	\N
330	507	2022-10-05 13:40:33	123	f	38	\N
332	507	2022-10-05 13:40:37	0	t	41	\N
334	507	2022-10-05 13:40:40	12	t	39	\N
336	507	2022-10-05 13:40:43	123	f	40	\N
338	507	2022-10-05 13:40:46	2	t	40	\N
340	507	2022-10-05 13:40:49	2	f	38	\N
342	507	2022-10-05 13:40:53	13	t	38	\N
344	507	2022-10-05 13:40:57	13	t	38	\N
346	507	2022-10-05 13:41:01	2	t	40	\N
348	507	2022-10-05 13:41:06	12	f	43	\N
350	507	2022-10-05 13:41:08	12	t	44	\N
352	507	2022-10-05 13:41:10	2	t	40	\N
354	507	2022-10-05 13:41:13	12	t	39	\N
356	507	2022-10-05 13:41:17	2	t	43	\N
358	507	2022-10-05 13:41:19	12	t	44	\N
360	507	2022-10-05 13:41:23	0	t	41	\N
362	507	2022-10-05 13:41:29	13	t	38	\N
364	508	2022-10-05 14:11:57	1	t	22	\N
366	509	2022-10-05 14:13:11	1	t	35	\N
368	511	2022-10-05 14:19:38	12	f	19	\N
370	511	2022-10-05 14:19:44	12	f	19	\N
372	511	2022-10-05 14:19:47	12	f	19	\N
374	512	2022-10-05 14:20:40	2	t	40	\N
376	512	2022-10-05 14:20:48	13	t	38	\N
378	513	2022-10-05 14:21:46	1	f	1	\N
380	513	2022-10-05 14:21:52	3	f	1	\N
382	513	2022-10-05 14:22:09	3	f	1	\N
384	514	2022-10-05 14:23:36	3	f	22	\N
386	516	2022-10-05 14:29:06	1	t	16	\N
388	517	2022-10-05 14:30:52	2	f	5	\N
390	518	2022-10-05 14:32:06	3	f	21	\N
392	519	2022-10-05 14:33:18	3	f	20	\N
394	520	2022-10-05 14:35:51	3	f	15	\N
396	520	2022-10-05 14:36:00	12	t	15	\N
398	520	2022-10-05 14:36:06	12	t	15	\N
400	520	2022-10-05 14:36:09	12	f	13	\N
402	520	2022-10-05 14:36:12	12	f	13	\N
404	520	2022-10-05 14:36:16	12	f	13	\N
406	520	2022-10-05 14:36:19	12	f	13	\N
408	520	2022-10-05 14:36:21	123	f	13	\N
410	520	2022-10-05 14:36:24	2	f	13	\N
412	520	2022-10-05 14:36:26	0	t	13	\N
414	520	2022-10-05 14:36:29	2	t	18	\N
416	520	2022-10-05 14:36:34	2	t	18	\N
418	520	2022-10-05 14:36:35	1	f	17	\N
420	520	2022-10-05 14:36:41	1	f	17	\N
422	520	2022-10-05 14:36:43	1	f	17	\N
424	520	2022-10-05 14:36:46	1	f	17	\N
426	520	2022-10-05 14:36:48	1	f	17	\N
428	520	2022-10-05 14:36:51	1	f	17	\N
430	520	2022-10-05 14:36:54	2	f	17	\N
432	520	2022-10-05 14:36:56	12	f	17	\N
434	520	2022-10-05 14:37:00	23	f	17	\N
436	520	2022-10-05 14:37:02	23	f	17	\N
438	520	2022-10-05 14:37:04	23	f	17	\N
440	520	2022-10-05 14:37:08	23	f	17	\N
442	520	2022-10-05 14:37:13	23	f	17	\N
444	520	2022-10-05 14:37:15	23	f	17	\N
446	521	2022-10-05 14:37:58	0	t	19	\N
448	521	2022-10-05 14:38:08	0	t	19	\N
450	522	2022-10-05 14:39:35	13	t	9	\N
452	522	2022-10-05 14:39:52	1	f	12	\N
454	522	2022-10-05 14:40:02	1	f	12	\N
456	522	2022-10-05 14:40:04	3	f	12	\N
458	522	2022-10-05 14:40:12	12	f	12	\N
460	522	2022-10-05 14:40:16	12	f	12	\N
462	522	2022-10-05 14:40:19	12	f	12	\N
464	522	2022-10-05 14:40:21	12	f	12	\N
466	523	2022-10-05 14:53:59	0	t	20	\N
468	523	2022-10-05 14:54:02	0	t	19	\N
470	523	2022-10-05 14:54:06	2	t	21	\N
472	523	2022-10-05 14:54:08	1	t	22	\N
474	523	2022-10-05 14:54:12	0	t	20	\N
476	523	2022-10-05 14:54:14	2	t	21	\N
478	523	2022-10-05 14:54:17	2	t	21	\N
480	524	2022-10-05 14:55:49	0	f	27	\N
482	524	2022-10-05 14:56:00	0	f	27	\N
484	524	2022-10-05 14:56:07	0	f	27	\N
486	524	2022-10-05 14:56:11	0	f	27	\N
488	524	2022-10-05 14:56:14	0	f	27	\N
490	524	2022-10-05 14:56:16	0	f	27	\N
492	524	2022-10-05 14:56:20	0	f	27	\N
494	525	2022-10-05 14:57:10	0	f	18	\N
496	525	2022-10-05 14:57:24	0	f	18	\N
498	525	2022-10-05 14:57:27	0	f	18	\N
500	525	2022-10-05 14:57:32	2	t	18	\N
502	525	2022-10-05 14:58:57	12	t	15	\N
504	525	2022-10-05 14:59:05	0	f	18	\N
506	526	2022-10-05 15:00:28	0	t	1	\N
508	526	2022-10-05 15:00:43	13	t	2	\N
510	526	2022-10-05 15:00:53	0	t	1	\N
512	527	2022-10-05 15:02:07	1	f	10	\N
514	527	2022-10-05 15:02:11	0	f	10	\N
516	527	2022-10-05 15:02:11	12	t	10	\N
518	527	2022-10-05 15:02:15	1	t	11	\N
520	527	2022-10-05 15:02:19	1	f	10	\N
522	527	2022-10-05 15:02:19	0	f	11	\N
524	527	2022-10-05 15:02:23	0	f	9	\N
526	527	2022-10-05 15:02:27	13	t	9	\N
528	527	2022-10-05 15:02:28	1	f	10	\N
530	527	2022-10-05 15:02:32	3	f	9	\N
532	527	2022-10-05 15:02:36	1	f	10	\N
534	528	2022-10-05 15:02:53	12	t	10	\N
536	528	2022-10-05 15:03:06	0	f	10	\N
538	528	2022-10-05 15:03:06	12	t	10	\N
540	528	2022-10-05 15:03:10	1	t	11	\N
542	528	2022-10-05 15:03:13	1	f	9	\N
544	528	2022-10-05 15:03:13	0	f	10	\N
546	528	2022-10-05 15:03:16	12	t	10	\N
548	528	2022-10-05 15:03:20	1	t	11	\N
550	528	2022-10-05 15:03:20	1	f	9	\N
552	528	2022-10-05 15:03:23	0	t	8	\N
554	528	2022-10-05 15:03:27	12	t	10	\N
556	528	2022-10-05 15:03:28	0	f	11	\N
558	528	2022-10-05 15:03:31	0	f	9	\N
560	528	2022-10-05 15:03:36	13	t	9	\N
562	528	2022-10-05 15:03:36	0	f	10	\N
563	528	2022-10-05 15:03:39	1	f	10	\N
564	528	2022-10-05 15:03:39	12	t	10	\N
565	528	2022-10-05 15:03:39	0	f	11	\N
566	528	2022-10-05 15:03:42	1	t	11	\N
567	528	2022-10-05 15:03:42	0	f	9	\N
568	528	2022-10-05 15:03:42	1	f	9	\N
569	528	2022-10-05 15:03:45	13	t	9	\N
570	528	2022-10-05 15:03:45	0	t	8	\N
571	529	2022-10-05 15:04:14	0	t	13	\N
572	529	2022-10-05 15:04:16	0	t	13	\N
573	529	2022-10-05 15:04:16	1	f	15	\N
574	529	2022-10-05 15:04:17	12	t	15	\N
575	529	2022-10-05 15:04:19	0	t	13	\N
576	529	2022-10-05 15:04:19	1	f	15	\N
577	529	2022-10-05 15:04:20	12	t	15	\N
578	529	2022-10-05 15:04:22	0	t	13	\N
579	529	2022-10-05 15:04:22	0	t	13	\N
580	529	2022-10-05 15:04:24	1	f	15	\N
581	529	2022-10-05 15:04:25	12	t	15	\N
582	529	2022-10-05 15:04:26	0	t	13	\N
583	529	2022-10-05 15:04:27	2	f	15	\N
584	529	2022-10-05 15:04:29	12	t	15	\N
325	507	2022-10-05 13:40:01	12	t	42	\N
327	507	2022-10-05 13:40:28	12	f	38	\N
329	507	2022-10-05 13:40:31	23	f	38	\N
331	507	2022-10-05 13:40:34	13	t	38	\N
333	507	2022-10-05 13:40:39	2	f	39	\N
335	507	2022-10-05 13:40:41	12	t	44	\N
337	507	2022-10-05 13:40:45	23	f	40	\N
339	507	2022-10-05 13:40:47	2	f	38	\N
341	507	2022-10-05 13:40:50	2	f	38	\N
343	507	2022-10-05 13:40:55	0	t	41	\N
345	507	2022-10-05 13:40:59	0	t	41	\N
347	507	2022-10-05 13:41:04	12	t	39	\N
349	507	2022-10-05 13:41:06	2	t	43	\N
351	507	2022-10-05 13:41:09	12	f	40	\N
353	507	2022-10-05 13:41:12	12	t	44	\N
355	507	2022-10-05 13:41:16	12	f	43	\N
357	507	2022-10-05 13:41:17	2	t	43	\N
359	507	2022-10-05 13:41:21	12	f	41	\N
361	507	2022-10-05 13:41:25	12	t	42	\N
363	508	2022-10-05 14:11:48	2	f	22	\N
365	508	2022-10-05 14:11:59	2	t	21	\N
367	510	2022-10-05 14:14:38	1	f	20	\N
369	511	2022-10-05 14:19:42	12	f	19	\N
371	511	2022-10-05 14:19:46	12	f	19	\N
373	512	2022-10-05 14:20:34	2	t	40	\N
375	512	2022-10-05 14:20:44	12	t	39	\N
377	512	2022-10-05 14:21:06	12	t	44	\N
379	513	2022-10-05 14:21:49	13	f	1	\N
381	513	2022-10-05 14:21:55	3	f	1	\N
383	514	2022-10-05 14:23:26	2	f	22	\N
385	516	2022-10-05 14:28:57	0	f	16	\N
387	517	2022-10-05 14:30:34	1	f	5	\N
389	518	2022-10-05 14:31:59	1	f	21	\N
391	519	2022-10-05 14:33:09	1	f	20	\N
393	520	2022-10-05 14:35:48	1	f	15	\N
395	520	2022-10-05 14:35:54	2	f	15	\N
397	520	2022-10-05 14:36:04	3	f	15	\N
399	520	2022-10-05 14:36:08	12	f	13	\N
401	520	2022-10-05 14:36:11	12	f	13	\N
403	520	2022-10-05 14:36:15	12	f	13	\N
405	520	2022-10-05 14:36:16	12	f	13	\N
407	520	2022-10-05 14:36:21	12	f	13	\N
409	520	2022-10-05 14:36:23	1	f	13	\N
411	520	2022-10-05 14:36:25	3	f	13	\N
413	520	2022-10-05 14:36:28	12	t	15	\N
415	520	2022-10-05 14:36:31	13	t	14	\N
417	520	2022-10-05 14:36:35	1	t	16	\N
419	520	2022-10-05 14:36:38	1	f	17	\N
421	520	2022-10-05 14:36:42	1	f	17	\N
423	520	2022-10-05 14:36:44	1	f	17	\N
425	520	2022-10-05 14:36:47	1	f	17	\N
427	520	2022-10-05 14:36:50	1	f	17	\N
429	520	2022-10-05 14:36:52	1	f	17	\N
431	520	2022-10-05 14:36:55	3	f	17	\N
433	520	2022-10-05 14:36:59	23	f	17	\N
286	505	2022-10-04 20:44:17	0	t	13	\N
287	505	2022-10-04 20:44:43	0	t	13	\N
288	505	2022-10-04 20:45:00	0	t	13	\N
289	505	2022-10-04 20:45:02	2	t	18	\N
290	505	2022-10-04 20:45:05	13	t	14	\N
291	505	2022-10-04 20:45:07	1	t	16	\N
292	505	2022-10-04 20:45:08	0	t	13	\N
293	505	2022-10-04 20:45:09	2	t	18	\N
294	505	2022-10-04 20:45:11	0	t	17	\N
295	505	2022-10-04 20:45:13	0	t	17	\N
296	505	2022-10-04 20:45:14	13	t	14	\N
297	505	2022-10-04 20:45:16	1	t	16	\N
298	505	2022-10-04 20:45:19	2	t	18	\N
299	505	2022-10-04 20:45:20	13	t	14	\N
300	505	2022-10-04 20:45:22	12	t	15	\N
301	505	2022-10-04 20:45:24	0	t	17	\N
302	505	2022-10-04 20:45:26	0	t	17	\N
303	505	2022-10-04 20:45:28	0	t	17	\N
304	506	2022-10-04 20:47:15	0	t	20	\N
305	506	2022-10-04 20:47:19	0	t	19	\N
306	506	2022-10-04 20:47:21	1	t	22	\N
307	506	2022-10-04 20:47:23	0	t	20	\N
308	506	2022-10-04 20:47:24	0	t	20	\N
309	506	2022-10-04 20:47:26	1	t	22	\N
310	506	2022-10-04 20:47:29	12	f	21	\N
311	506	2022-10-04 20:47:30	12	f	21	\N
312	506	2022-10-04 20:47:30	12	f	21	\N
313	506	2022-10-04 20:47:32	1	f	21	\N
314	506	2022-10-04 20:47:33	2	t	21	\N
315	506	2022-10-04 20:47:35	0	f	21	\N
316	506	2022-10-04 20:47:36	2	t	21	\N
317	506	2022-10-04 20:47:38	1	t	22	\N
318	506	2022-10-04 20:47:41	0	t	20	\N
319	506	2022-10-04 20:47:43	0	t	19	\N
320	506	2022-10-04 20:47:44	2	t	21	\N
321	506	2022-10-04 20:47:45	0	t	20	\N
322	506	2022-10-04 20:47:47	0	t	19	\N
323	506	2022-10-04 20:47:48	1	t	22	\N
435	520	2022-10-05 14:37:01	23	f	17	\N
437	520	2022-10-05 14:37:03	23	f	17	\N
439	520	2022-10-05 14:37:06	23	f	17	\N
441	520	2022-10-05 14:37:10	23	f	17	\N
443	520	2022-10-05 14:37:14	23	f	17	\N
445	520	2022-10-05 14:37:17	23	f	17	\N
447	521	2022-10-05 14:38:00	0	t	20	\N
449	521	2022-10-05 14:38:13	2	t	21	\N
451	522	2022-10-05 14:39:45	1	t	11	\N
453	522	2022-10-05 14:39:59	1	f	12	\N
455	522	2022-10-05 14:40:03	1	f	12	\N
457	522	2022-10-05 14:40:08	3	f	12	\N
459	522	2022-10-05 14:40:14	12	f	12	\N
461	522	2022-10-05 14:40:18	12	f	12	\N
463	522	2022-10-05 14:40:20	12	f	12	\N
465	523	2022-10-05 14:53:55	1	t	22	\N
467	523	2022-10-05 14:54:01	2	t	21	\N
469	523	2022-10-05 14:54:04	1	t	22	\N
471	523	2022-10-05 14:54:07	0	t	19	\N
473	523	2022-10-05 14:54:10	1	t	22	\N
475	523	2022-10-05 14:54:13	1	t	22	\N
477	523	2022-10-05 14:54:15	0	t	19	\N
479	523	2022-10-05 14:54:19	0	t	20	\N
481	524	2022-10-05 14:55:57	0	f	27	\N
483	524	2022-10-05 14:56:04	0	f	27	\N
485	524	2022-10-05 14:56:10	0	f	27	\N
487	524	2022-10-05 14:56:13	0	f	27	\N
489	524	2022-10-05 14:56:15	0	f	27	\N
491	524	2022-10-05 14:56:20	0	f	27	\N
493	524	2022-10-05 14:56:20	0	f	27	\N
495	525	2022-10-05 14:57:18	0	f	18	\N
497	525	2022-10-05 14:57:25	0	f	18	\N
499	525	2022-10-05 14:57:29	0	f	18	\N
501	525	2022-10-05 14:58:55	0	t	17	\N
503	525	2022-10-05 14:58:59	13	t	14	\N
505	526	2022-10-05 15:00:19	0	t	1	\N
507	526	2022-10-05 15:00:33	0	t	1	\N
509	526	2022-10-05 15:00:47	13	t	2	\N
511	527	2022-10-05 15:02:07	0	f	10	\N
513	527	2022-10-05 15:02:07	12	t	10	\N
515	527	2022-10-05 15:02:11	1	f	10	\N
517	527	2022-10-05 15:02:15	0	f	11	\N
519	527	2022-10-05 15:02:15	0	f	10	\N
521	527	2022-10-05 15:02:19	12	t	10	\N
523	527	2022-10-05 15:02:22	1	t	11	\N
525	527	2022-10-05 15:02:23	3	f	9	\N
527	527	2022-10-05 15:02:27	0	f	10	\N
529	527	2022-10-05 15:02:32	12	t	10	\N
531	527	2022-10-05 15:02:32	0	f	9	\N
533	527	2022-10-05 15:02:36	1	t	11	\N
535	528	2022-10-05 15:02:54	1	t	11	\N
537	528	2022-10-05 15:03:06	1	f	10	\N
539	528	2022-10-05 15:03:09	0	f	11	\N
541	528	2022-10-05 15:03:10	0	f	9	\N
543	528	2022-10-05 15:03:13	13	t	9	\N
545	528	2022-10-05 15:03:16	1	f	10	\N
547	528	2022-10-05 15:03:17	0	f	11	\N
549	528	2022-10-05 15:03:20	0	f	9	\N
551	528	2022-10-05 15:03:22	13	t	9	\N
553	528	2022-10-05 15:03:23	0	f	10	\N
555	528	2022-10-05 15:03:27	1	f	10	\N
557	528	2022-10-05 15:03:31	1	t	11	\N
559	528	2022-10-05 15:03:31	1	f	9	\N
561	528	2022-10-05 15:03:36	0	t	8	\N
585	529	2022-10-05 15:04:30	0	t	13	\N
586	529	2022-10-05 15:04:31	1	f	15	\N
587	529	2022-10-05 15:04:32	12	t	15	\N
588	529	2022-10-05 15:04:32	0	t	13	\N
589	529	2022-10-05 15:04:34	2	f	15	\N
590	529	2022-10-05 15:04:35	12	t	15	\N
591	529	2022-10-05 15:04:36	2	f	16	\N
592	529	2022-10-05 15:04:37	0	t	13	\N
593	529	2022-10-05 15:04:38	1	f	15	\N
594	529	2022-10-05 15:04:38	12	t	15	\N
595	529	2022-10-05 15:04:39	0	t	13	\N
596	529	2022-10-05 15:04:42	2	f	15	\N
597	529	2022-10-05 15:04:42	12	t	15	\N
598	529	2022-10-05 15:04:43	2	f	16	\N
599	529	2022-10-05 15:04:45	0	f	18	\N
600	529	2022-10-05 15:04:45	2	t	18	\N
601	530	2022-10-05 15:10:12	0	t	12	\N
602	530	2022-10-05 15:10:14	0	t	12	\N
603	530	2022-10-05 15:10:15	0	t	12	\N
604	530	2022-10-05 15:10:16	0	t	12	\N
605	530	2022-10-05 15:10:19	13	t	9	\N
606	530	2022-10-05 15:10:22	0	t	8	\N
607	530	2022-10-05 15:10:22	0	t	12	\N
608	530	2022-10-05 15:10:24	12	t	10	\N
609	530	2022-10-05 15:10:26	0	t	8	\N
610	530	2022-10-05 15:10:27	1	t	11	\N
611	530	2022-10-05 15:10:29	1	t	11	\N
612	530	2022-10-05 15:10:30	1	t	11	\N
613	530	2022-10-05 15:10:31	0	t	8	\N
614	530	2022-10-05 15:10:33	0	t	8	\N
615	530	2022-10-05 15:10:34	13	t	9	\N
616	531	2022-10-05 15:10:59	0	f	11	\N
617	531	2022-10-05 15:11:00	3	f	11	\N
618	531	2022-10-05 15:11:01	23	f	11	\N
619	531	2022-10-05 15:11:07	123	f	11	\N
620	531	2022-10-05 15:11:07	3	f	11	\N
621	531	2022-10-05 15:11:07	23	f	11	\N
622	531	2022-10-05 15:11:14	0	f	11	\N
623	531	2022-10-05 15:11:15	3	f	11	\N
624	531	2022-10-05 15:11:15	23	f	11	\N
625	531	2022-10-05 15:11:19	123	f	11	\N
626	531	2022-10-05 15:11:19	12	f	11	\N
627	531	2022-10-05 15:11:19	1	t	11	\N
628	531	2022-10-05 15:11:22	0	f	11	\N
629	531	2022-10-05 15:11:22	1	t	11	\N
630	531	2022-10-05 15:11:22	0	f	11	\N
631	531	2022-10-05 15:11:26	3	f	11	\N
632	531	2022-10-05 15:11:27	123	f	11	\N
633	531	2022-10-05 15:11:27	23	f	11	\N
634	531	2022-10-05 15:11:29	23	f	11	\N
635	531	2022-10-05 15:11:30	3	f	11	\N
636	531	2022-10-05 15:11:30	0	f	11	\N
637	531	2022-10-05 15:11:33	3	f	11	\N
638	531	2022-10-05 15:11:34	23	f	11	\N
639	531	2022-10-05 15:11:34	123	f	11	\N
640	531	2022-10-05 15:11:38	12	f	11	\N
641	531	2022-10-05 15:11:38	1	t	11	\N
642	531	2022-10-05 15:11:39	0	f	11	\N
643	531	2022-10-05 15:11:41	1	t	11	\N
644	531	2022-10-05 15:11:42	0	t	12	\N
645	531	2022-10-05 15:11:42	0	f	11	\N
646	531	2022-10-05 15:11:47	3	f	11	\N
647	531	2022-10-05 15:11:47	23	f	11	\N
648	531	2022-10-05 15:11:47	123	f	11	\N
649	531	2022-10-05 15:11:51	23	f	11	\N
650	531	2022-10-05 15:11:52	3	f	11	\N
651	531	2022-10-05 15:11:52	0	f	11	\N
652	531	2022-10-05 15:11:55	23	f	11	\N
653	531	2022-10-05 15:11:55	1	t	11	\N
654	531	2022-10-05 15:11:56	1	t	11	\N
655	531	2022-10-05 15:11:59	12	f	11	\N
656	532	2022-10-05 15:12:14	0	t	12	\N
657	532	2022-10-05 15:12:28	13	t	9	\N
658	532	2022-10-05 15:12:31	0	t	12	\N
659	532	2022-10-05 15:12:31	1	f	9	\N
660	532	2022-10-05 15:12:33	0	t	12	\N
661	532	2022-10-05 15:12:37	13	t	9	\N
662	532	2022-10-05 15:12:37	0	t	12	\N
663	532	2022-10-05 15:12:37	1	f	9	\N
664	532	2022-10-05 15:12:40	0	t	12	\N
665	532	2022-10-05 15:12:40	1	f	9	\N
666	532	2022-10-05 15:12:41	13	t	9	\N
667	532	2022-10-05 15:12:43	0	t	12	\N
668	532	2022-10-05 15:12:44	0	t	12	\N
669	532	2022-10-05 15:12:44	1	f	9	\N
670	532	2022-10-05 15:12:46	13	t	9	\N
671	532	2022-10-05 15:12:47	0	t	12	\N
672	532	2022-10-05 15:12:47	1	t	11	\N
673	532	2022-10-05 15:12:49	0	t	12	\N
674	532	2022-10-05 15:12:50	1	f	9	\N
675	532	2022-10-05 15:12:50	13	t	9	\N
676	532	2022-10-05 15:12:52	0	t	12	\N
677	532	2022-10-05 15:12:53	1	t	11	\N
678	532	2022-10-05 15:12:53	13	t	9	\N
679	533	2022-10-05 15:15:56	12	t	10	\N
680	533	2022-10-05 15:15:59	0	f	10	\N
681	533	2022-10-05 15:16:19	0	t	8	\N
682	533	2022-10-05 15:16:33	0	f	10	\N
683	533	2022-10-05 15:18:11	0	t	12	\N
684	533	2022-10-05 15:18:25	13	t	9	\N
685	533	2022-10-05 15:18:31	0	f	10	\N
686	533	2022-10-05 15:18:34	0	t	8	\N
687	533	2022-10-05 15:18:37	0	t	8	\N
688	533	2022-10-05 15:18:41	0	f	10	\N
689	533	2022-10-05 15:18:44	0	f	10	\N
690	533	2022-10-05 15:18:46	0	f	10	\N
691	533	2022-10-05 15:19:40	0	f	10	\N
692	533	2022-10-05 15:19:54	0	f	10	\N
693	533	2022-10-05 15:20:59	0	f	10	\N
694	534	2022-10-05 15:21:45	0	t	12	\N
695	534	2022-10-05 15:21:50	0	t	12	\N
696	534	2022-10-05 15:21:52	0	t	8	\N
697	534	2022-10-05 15:21:54	1	t	11	\N
698	534	2022-10-05 15:21:59	13	t	9	\N
699	534	2022-10-05 15:22:00	0	t	8	\N
700	534	2022-10-05 15:22:02	0	t	12	\N
701	534	2022-10-05 15:22:03	13	t	9	\N
702	534	2022-10-05 15:22:05	1	t	11	\N
703	534	2022-10-05 15:22:06	12	t	10	\N
704	534	2022-10-05 15:22:07	12	t	10	\N
705	534	2022-10-05 15:22:10	12	t	10	\N
706	534	2022-10-05 15:22:11	1	t	11	\N
707	534	2022-10-05 15:22:13	0	t	12	\N
708	534	2022-10-05 15:22:14	12	t	10	\N
709	535	2022-10-05 15:25:01	12	t	29	\N
710	535	2022-10-05 15:25:04	0	t	26	\N
711	535	2022-10-05 15:25:10	0	t	30	\N
712	535	2022-10-05 15:25:12	0	t	30	\N
713	535	2022-10-05 15:25:13	0	t	26	\N
714	535	2022-10-05 15:25:15	2	t	27	\N
715	535	2022-10-05 15:25:18	0	t	30	\N
716	535	2022-10-05 15:25:19	2	t	27	\N
717	535	2022-10-05 15:25:21	0	t	26	\N
718	535	2022-10-05 15:25:28	1	t	28	\N
719	535	2022-10-05 15:25:29	0	t	23	\N
720	535	2022-10-05 15:25:30	0	t	23	\N
721	535	2022-10-05 15:25:31	2	t	24	\N
722	535	2022-10-05 15:25:35	0	t	30	\N
723	535	2022-10-05 15:25:36	2	t	27	\N
724	535	2022-10-05 15:25:38	2	t	24	\N
725	535	2022-10-05 15:25:41	1	f	26	\N
726	535	2022-10-05 15:25:44	0	t	26	\N
727	535	2022-10-05 15:25:46	1	f	30	\N
728	535	2022-10-05 15:25:57	1	f	30	\N
729	535	2022-10-05 15:25:57	0	t	30	\N
730	535	2022-10-05 15:25:57	0	t	30	\N
731	535	2022-10-05 15:26:02	0	t	30	\N
732	536	2022-10-05 16:42:43	2	t	21	\N
733	536	2022-10-05 16:42:46	0	t	20	\N
734	536	2022-10-05 16:42:48	0	t	20	\N
735	536	2022-10-05 16:42:53	0	f	21	\N
736	536	2022-10-05 16:42:57	0	f	21	\N
737	536	2022-10-05 16:43:02	0	f	21	\N
738	536	2022-10-05 16:43:04	0	f	21	\N
739	536	2022-10-05 16:43:04	0	f	21	\N
740	536	2022-10-05 16:43:05	0	f	21	\N
741	536	2022-10-05 16:43:07	0	f	21	\N
742	536	2022-10-05 16:43:07	0	f	21	\N
743	536	2022-10-05 16:43:08	0	f	21	\N
744	536	2022-10-05 16:43:10	0	f	21	\N
745	536	2022-10-05 16:43:10	0	f	21	\N
746	536	2022-10-05 16:43:11	0	f	21	\N
747	536	2022-10-05 16:43:12	0	f	21	\N
748	536	2022-10-05 16:43:13	0	f	21	\N
749	536	2022-10-05 16:43:13	0	f	21	\N
750	537	2022-10-05 16:44:04	0	f	16	\N
751	537	2022-10-05 16:44:16	0	f	16	\N
752	537	2022-10-05 16:44:22	0	f	16	\N
753	537	2022-10-05 16:44:24	0	f	16	\N
754	537	2022-10-05 16:44:25	0	f	16	\N
755	537	2022-10-05 16:44:37	0	f	16	\N
756	537	2022-10-05 16:44:38	0	f	16	\N
757	537	2022-10-05 16:44:40	0	f	16	\N
758	537	2022-10-05 16:44:41	0	f	16	\N
759	537	2022-10-05 16:44:41	0	f	16	\N
760	537	2022-10-05 16:44:43	0	f	16	\N
761	537	2022-10-05 16:44:44	0	f	16	\N
762	537	2022-10-05 16:44:44	0	f	16	\N
763	537	2022-10-05 16:45:12	0	f	16	\N
764	538	2022-10-05 16:46:03	0	f	22	\N
765	538	2022-10-05 16:46:03	1	t	22	\N
766	538	2022-10-05 16:46:09	0	f	22	\N
767	538	2022-10-05 16:46:09	1	t	22	\N
768	538	2022-10-05 16:46:09	1	f	20	\N
769	538	2022-10-05 16:46:12	0	t	20	\N
770	538	2022-10-05 16:46:12	0	f	22	\N
771	538	2022-10-05 16:46:12	1	t	22	\N
772	538	2022-10-05 16:46:15	1	f	20	\N
773	538	2022-10-05 16:46:15	0	t	20	\N
774	538	2022-10-05 16:46:15	0	t	19	\N
775	538	2022-10-05 16:46:18	0	f	21	\N
776	538	2022-10-05 16:46:18	2	t	21	\N
777	538	2022-10-05 16:46:18	0	f	22	\N
778	538	2022-10-05 16:46:21	1	t	22	\N
779	538	2022-10-05 16:46:21	1	f	20	\N
780	538	2022-10-05 16:46:22	0	t	20	\N
781	538	2022-10-05 16:46:25	0	t	19	\N
782	538	2022-10-05 16:46:25	0	f	21	\N
783	538	2022-10-05 16:46:25	2	t	21	\N
784	538	2022-10-05 16:46:28	2	f	22	\N
785	538	2022-10-05 16:46:28	2	f	20	\N
786	538	2022-10-05 16:46:28	2	t	21	\N
787	538	2022-10-05 16:46:33	2	f	19	\N
788	538	2022-10-05 16:46:33	0	t	19	\N
789	538	2022-10-05 16:46:34	0	f	22	\N
790	538	2022-10-05 16:46:41	1	t	22	\N
791	538	2022-10-05 16:46:41	1	f	20	\N
792	538	2022-10-05 16:46:41	0	t	20	\N
793	538	2022-10-05 16:46:45	0	t	19	\N
794	538	2022-10-05 16:46:45	0	f	21	\N
795	538	2022-10-05 16:46:45	2	t	21	\N
796	538	2022-10-05 16:46:48	2	t	21	\N
797	538	2022-10-05 16:46:48	2	f	20	\N
798	539	2022-10-05 16:47:04	0	t	17	\N
799	539	2022-10-05 16:47:07	0	t	17	\N
800	539	2022-10-05 16:47:07	1	f	15	\N
801	539	2022-10-05 16:47:07	12	t	15	\N
802	539	2022-10-05 16:47:13	0	t	17	\N
803	539	2022-10-05 16:47:13	1	f	15	\N
804	539	2022-10-05 16:47:13	12	t	15	\N
805	539	2022-10-05 16:47:16	0	f	15	\N
806	539	2022-10-05 16:47:16	1	f	15	\N
807	539	2022-10-05 16:47:16	12	t	15	\N
808	539	2022-10-05 16:47:25	0	t	17	\N
809	539	2022-10-05 16:47:26	1	f	15	\N
810	539	2022-10-05 16:47:26	12	t	15	\N
811	539	2022-10-05 16:47:29	0	f	15	\N
812	539	2022-10-05 16:47:29	1	f	15	\N
813	539	2022-10-05 16:47:29	12	t	15	\N
814	539	2022-10-05 16:47:32	2	f	14	\N
815	539	2022-10-05 16:47:32	12	f	14	\N
816	539	2022-10-05 16:47:32	1	f	14	\N
817	539	2022-10-05 16:47:35	0	f	14	\N
818	539	2022-10-05 16:47:35	1	f	14	\N
819	539	2022-10-05 16:47:35	13	t	14	\N
820	539	2022-10-05 16:47:46	1	t	16	\N
821	539	2022-10-05 16:47:53	0	t	17	\N
822	539	2022-10-05 16:47:53	1	f	15	\N
823	539	2022-10-05 16:47:54	12	t	15	\N
824	539	2022-10-05 16:47:57	0	f	15	\N
825	539	2022-10-05 16:47:57	1	f	15	\N
826	539	2022-10-05 16:47:58	12	t	15	\N
827	539	2022-10-05 16:48:02	2	f	14	\N
828	539	2022-10-05 16:48:02	12	f	14	\N
829	539	2022-10-05 16:48:02	1	f	14	\N
830	539	2022-10-05 16:48:06	0	f	14	\N
831	539	2022-10-05 16:48:06	1	f	14	\N
832	539	2022-10-05 16:48:06	13	t	14	\N
833	539	2022-10-05 16:48:09	3	f	16	\N
834	539	2022-10-05 16:48:10	0	f	16	\N
835	539	2022-10-05 16:48:10	1	t	16	\N
836	539	2022-10-05 16:48:13	0	f	16	\N
837	539	2022-10-05 16:48:13	1	t	16	\N
838	539	2022-10-05 16:48:13	0	t	17	\N
839	539	2022-10-05 16:48:16	1	f	15	\N
840	539	2022-10-05 16:48:16	12	t	15	\N
841	539	2022-10-05 16:48:16	0	f	15	\N
842	539	2022-10-05 16:48:19	1	f	15	\N
843	539	2022-10-05 16:48:19	12	t	15	\N
844	539	2022-10-05 16:48:19	2	f	14	\N
845	539	2022-10-05 16:48:22	12	f	14	\N
846	539	2022-10-05 16:48:22	1	f	14	\N
847	539	2022-10-05 16:48:22	0	f	14	\N
848	539	2022-10-05 16:48:25	1	f	14	\N
849	539	2022-10-05 16:48:25	13	t	14	\N
850	539	2022-10-05 16:48:25	3	f	16	\N
851	539	2022-10-05 16:48:27	0	f	16	\N
852	539	2022-10-05 16:48:27	0	f	16	\N
853	539	2022-10-05 16:48:27	1	t	16	\N
854	539	2022-10-05 16:48:30	1	t	16	\N
855	539	2022-10-05 16:48:30	0	f	16	\N
856	539	2022-10-05 16:48:30	1	t	16	\N
857	540	2022-10-05 18:05:34	0	t	36	\N
858	540	2022-10-05 18:05:38	0	t	36	\N
859	540	2022-10-05 18:05:38	1	f	34	\N
860	540	2022-10-05 18:05:40	0	t	36	\N
861	540	2022-10-05 18:05:40	1	f	34	\N
862	540	2022-10-05 18:05:41	0	f	34	\N
863	540	2022-10-05 18:05:44	1	f	34	\N
864	540	2022-10-05 18:05:44	0	t	36	\N
865	540	2022-10-05 18:05:44	1	f	34	\N
866	540	2022-10-05 18:05:47	0	f	34	\N
867	540	2022-10-05 18:05:47	1	f	34	\N
868	540	2022-10-05 18:05:47	0	f	35	\N
869	540	2022-10-05 18:05:50	0	t	36	\N
870	540	2022-10-05 18:05:50	1	f	34	\N
871	540	2022-10-05 18:05:50	0	f	34	\N
872	540	2022-10-05 18:05:53	1	f	34	\N
873	540	2022-10-05 18:05:53	0	f	35	\N
874	540	2022-10-05 18:05:53	0	t	36	\N
875	540	2022-10-05 18:05:55	1	f	34	\N
876	540	2022-10-05 18:05:56	0	f	34	\N
877	540	2022-10-05 18:05:56	1	f	34	\N
878	540	2022-10-05 18:05:58	0	f	35	\N
879	540	2022-10-05 18:05:58	1	f	32	\N
880	540	2022-10-05 18:05:59	13	f	32	\N
881	540	2022-10-05 18:06:01	0	t	36	\N
882	540	2022-10-05 18:06:01	1	f	34	\N
883	540	2022-10-05 18:06:01	0	f	34	\N
884	540	2022-10-05 18:06:04	1	f	34	\N
885	540	2022-10-05 18:06:04	0	f	35	\N
886	540	2022-10-05 18:06:04	1	f	32	\N
887	540	2022-10-05 18:06:07	13	f	32	\N
888	540	2022-10-05 18:06:07	3	f	31	\N
889	540	2022-10-05 18:06:07	0	f	31	\N
890	540	2022-10-05 18:06:10	0	t	36	\N
891	540	2022-10-05 18:06:11	1	f	34	\N
892	540	2022-10-05 18:06:11	0	f	34	\N
893	540	2022-10-05 18:06:14	1	f	34	\N
894	540	2022-10-05 18:06:14	0	f	35	\N
895	540	2022-10-05 18:06:14	1	f	32	\N
896	540	2022-10-05 18:06:17	13	f	32	\N
897	540	2022-10-05 18:06:18	3	f	31	\N
898	540	2022-10-05 18:06:18	0	f	31	\N
899	540	2022-10-05 18:06:20	1	f	33	\N
900	540	2022-10-05 18:06:21	12	f	33	\N
901	540	2022-10-05 18:06:21	0	t	36	\N
902	540	2022-10-05 18:06:23	1	f	34	\N
903	540	2022-10-05 18:06:24	0	f	34	\N
904	540	2022-10-05 18:06:25	1	f	34	\N
905	540	2022-10-05 18:06:27	0	f	35	\N
906	540	2022-10-05 18:06:28	1	f	32	\N
907	540	2022-10-05 18:06:28	13	f	32	\N
908	540	2022-10-05 18:06:31	3	f	31	\N
909	540	2022-10-05 18:06:33	0	f	31	\N
910	540	2022-10-05 18:06:33	1	f	33	\N
911	540	2022-10-05 18:06:35	12	f	33	\N
912	540	2022-10-05 18:06:36	1	f	37	\N
913	540	2022-10-05 18:06:36	0	f	37	\N
914	540	2022-10-05 18:06:39	2	f	37	\N
915	540	2022-10-05 18:06:40	0	t	36	\N
916	540	2022-10-05 18:06:40	1	f	34	\N
917	540	2022-10-05 18:06:43	0	f	34	\N
918	540	2022-10-05 18:06:44	1	f	34	\N
919	540	2022-10-05 18:06:44	0	f	35	\N
920	540	2022-10-05 18:06:46	1	f	32	\N
921	540	2022-10-05 18:06:47	13	f	32	\N
922	540	2022-10-05 18:06:47	3	f	31	\N
923	540	2022-10-05 18:06:49	0	f	31	\N
924	540	2022-10-05 18:06:50	1	f	33	\N
925	540	2022-10-05 18:06:50	12	f	33	\N
926	540	2022-10-05 18:06:53	1	f	37	\N
927	540	2022-10-05 18:06:54	0	f	37	\N
928	540	2022-10-05 18:06:55	2	f	37	\N
929	540	2022-10-05 18:06:57	0	t	36	\N
930	540	2022-10-05 18:06:58	2	f	36	\N
931	540	2022-10-05 18:06:58	12	f	36	\N
932	540	2022-10-05 18:07:00	0	t	36	\N
933	540	2022-10-05 18:07:01	1	f	34	\N
934	540	2022-10-05 18:07:01	0	f	34	\N
935	540	2022-10-05 18:07:03	1	f	34	\N
936	540	2022-10-05 18:07:04	0	f	35	\N
937	540	2022-10-05 18:07:04	1	f	32	\N
938	540	2022-10-05 18:07:05	13	f	32	\N
939	540	2022-10-05 18:07:07	3	f	31	\N
940	540	2022-10-05 18:07:09	1	f	33	\N
941	540	2022-10-05 18:07:10	12	f	33	\N
942	540	2022-10-05 18:07:11	1	f	37	\N
943	540	2022-10-05 18:07:12	0	f	37	\N
944	540	2022-10-05 18:07:13	2	f	37	\N
945	540	2022-10-05 18:07:14	0	t	36	\N
946	540	2022-10-05 18:07:15	2	f	36	\N
947	540	2022-10-05 18:07:17	12	f	36	\N
948	540	2022-10-05 18:07:18	1	f	37	\N
949	540	2022-10-05 18:07:19	0	f	37	\N
950	540	2022-10-05 18:07:20	2	f	37	\N
951	540	2022-10-05 18:07:21	0	t	36	\N
952	540	2022-10-05 18:07:22	1	f	34	\N
953	540	2022-10-05 18:07:24	0	f	34	\N
954	540	2022-10-05 18:07:24	1	f	34	\N
955	540	2022-10-05 18:07:25	0	f	35	\N
956	540	2022-10-05 18:07:27	1	f	32	\N
957	540	2022-10-05 18:07:27	13	f	32	\N
958	540	2022-10-05 18:07:28	3	f	31	\N
959	540	2022-10-05 18:07:30	0	f	31	\N
960	540	2022-10-05 18:07:30	1	f	33	\N
961	540	2022-10-05 18:07:31	12	f	33	\N
962	540	2022-10-05 18:07:33	1	f	37	\N
963	540	2022-10-05 18:07:34	0	f	37	\N
964	540	2022-10-05 18:07:34	2	f	37	\N
965	540	2022-10-05 18:07:36	0	t	36	\N
966	540	2022-10-05 18:07:37	2	f	36	\N
967	540	2022-10-05 18:07:38	12	f	36	\N
968	540	2022-10-05 18:07:39	1	f	37	\N
969	540	2022-10-05 18:07:41	0	f	37	\N
970	540	2022-10-05 18:07:41	2	f	37	\N
971	540	2022-10-05 18:07:42	0	f	37	\N
972	540	2022-10-05 18:07:43	1	f	37	\N
973	540	2022-10-05 18:07:44	12	t	37	\N
974	540	2022-10-05 18:07:45	0	t	36	\N
975	540	2022-10-05 18:07:46	1	f	34	\N
976	540	2022-10-05 18:07:47	0	f	34	\N
977	540	2022-10-05 18:07:48	1	f	34	\N
978	540	2022-10-05 18:07:49	0	f	35	\N
979	540	2022-10-05 18:07:49	1	f	32	\N
980	540	2022-10-05 18:07:51	13	f	32	\N
981	540	2022-10-05 18:07:52	3	f	31	\N
982	540	2022-10-05 18:07:52	0	f	31	\N
983	540	2022-10-05 18:07:54	1	f	33	\N
984	540	2022-10-05 18:07:55	12	f	33	\N
985	540	2022-10-05 18:07:55	1	f	37	\N
986	540	2022-10-05 18:07:56	0	f	37	\N
987	540	2022-10-05 18:07:58	2	f	37	\N
988	540	2022-10-05 18:07:58	0	t	36	\N
989	540	2022-10-05 18:07:59	2	f	36	\N
990	540	2022-10-05 18:08:00	12	f	36	\N
991	540	2022-10-05 18:08:01	1	f	37	\N
992	540	2022-10-05 18:08:03	0	f	37	\N
993	540	2022-10-05 18:08:04	2	f	37	\N
994	540	2022-10-05 18:08:04	0	f	37	\N
995	540	2022-10-05 18:08:06	1	f	37	\N
996	540	2022-10-05 18:08:07	12	t	37	\N
997	540	2022-10-05 18:08:07	1	f	34	\N
998	540	2022-10-05 18:08:08	0	f	34	\N
999	540	2022-10-05 18:08:09	1	f	34	\N
1000	541	2022-10-05 18:10:57	0	t	20	\N
1001	541	2022-10-05 18:10:57	1	f	20	\N
1002	541	2022-10-05 18:10:57	12	f	20	\N
1003	541	2022-10-05 18:11:01	123	f	20	\N
1004	541	2022-10-05 18:11:01	13	f	20	\N
1005	541	2022-10-05 18:11:01	3	f	20	\N
1006	541	2022-10-05 18:11:05	23	f	20	\N
1007	541	2022-10-05 18:11:05	2	f	20	\N
1008	541	2022-10-05 18:11:05	0	t	20	\N
1009	541	2022-10-05 18:11:13	1	f	20	\N
1010	541	2022-10-05 18:11:13	12	f	20	\N
1011	541	2022-10-05 18:11:13	123	f	20	\N
1012	541	2022-10-05 18:11:24	13	f	20	\N
1013	541	2022-10-05 18:11:31	3	f	20	\N
1014	541	2022-10-05 18:11:31	23	f	20	\N
1015	541	2022-10-05 18:11:31	2	f	20	\N
1016	541	2022-10-05 18:11:35	2	f	20	\N
1017	541	2022-10-05 18:11:35	0	t	20	\N
1018	541	2022-10-05 18:11:35	12	f	20	\N
1019	541	2022-10-05 18:11:38	1	f	20	\N
1020	541	2022-10-05 18:11:38	13	f	20	\N
1021	541	2022-10-05 18:11:38	3	f	20	\N
1022	541	2022-10-05 18:11:41	23	f	20	\N
1023	541	2022-10-05 18:11:41	2	f	20	\N
1024	541	2022-10-05 18:11:41	0	t	20	\N
1025	541	2022-10-05 18:11:44	2	f	20	\N
1026	541	2022-10-05 18:11:44	12	f	20	\N
1027	541	2022-10-05 18:11:44	123	f	20	\N
1028	541	2022-10-05 18:11:46	13	f	20	\N
1029	541	2022-10-05 18:11:47	3	f	20	\N
1030	541	2022-10-05 18:11:47	0	t	20	\N
1031	541	2022-10-05 18:11:49	1	f	20	\N
1032	541	2022-10-05 18:11:50	12	f	20	\N
1033	541	2022-10-05 18:11:50	123	f	20	\N
1034	541	2022-10-05 18:11:52	23	f	20	\N
1035	541	2022-10-05 18:11:52	3	f	20	\N
1036	541	2022-10-05 18:11:53	0	t	20	\N
1037	541	2022-10-05 18:11:55	1	f	20	\N
1038	541	2022-10-05 18:11:55	12	f	20	\N
1039	541	2022-10-05 18:11:55	123	f	20	\N
1040	541	2022-10-05 18:11:58	23	f	20	\N
1041	541	2022-10-05 18:11:59	2	f	20	\N
1042	541	2022-10-05 18:11:59	0	t	20	\N
1043	541	2022-10-05 18:12:01	3	f	20	\N
1044	541	2022-10-05 18:12:02	23	f	20	\N
1045	541	2022-10-05 18:12:02	123	f	20	\N
1046	541	2022-10-05 18:12:04	12	f	20	\N
1047	541	2022-10-05 18:12:05	1	f	20	\N
1048	541	2022-10-05 18:12:05	0	t	20	\N
1049	541	2022-10-05 18:12:07	3	f	20	\N
1050	541	2022-10-05 18:12:08	23	f	20	\N
1051	541	2022-10-05 18:12:08	123	f	20	\N
1052	541	2022-10-05 18:12:10	12	f	20	\N
1053	541	2022-10-05 18:12:11	1	f	20	\N
1054	541	2022-10-05 18:12:11	0	t	20	\N
1055	541	2022-10-05 18:12:13	3	f	20	\N
1056	541	2022-10-05 18:12:14	23	f	20	\N
1057	541	2022-10-05 18:12:14	2	f	20	\N
1058	541	2022-10-05 18:12:16	0	t	20	\N
1059	541	2022-10-05 18:12:17	1	f	20	\N
1060	541	2022-10-05 18:12:17	12	f	20	\N
1061	541	2022-10-05 18:12:19	123	f	20	\N
1062	541	2022-10-05 18:12:20	13	f	20	\N
1063	541	2022-10-05 18:12:20	3	f	20	\N
1064	541	2022-10-05 18:12:22	23	f	20	\N
1065	541	2022-10-05 18:12:23	2	f	20	\N
1066	541	2022-10-05 18:12:23	0	t	20	\N
1067	541	2022-10-05 18:12:26	1	f	20	\N
1068	541	2022-10-05 18:12:26	12	f	20	\N
1069	541	2022-10-05 18:12:26	1	f	20	\N
1070	541	2022-10-05 18:12:29	13	f	20	\N
1071	541	2022-10-05 18:12:30	123	f	20	\N
1072	541	2022-10-05 18:12:30	13	f	20	\N
1073	541	2022-10-05 18:12:33	1	f	20	\N
1074	541	2022-10-05 18:12:34	12	f	20	\N
1075	541	2022-10-05 18:12:34	2	f	20	\N
1076	541	2022-10-05 18:12:36	12	f	20	\N
1077	541	2022-10-05 18:12:37	1	f	20	\N
1078	541	2022-10-05 18:12:37	13	f	20	\N
1079	542	2022-10-05 18:12:57	13	t	9	\N
1080	542	2022-10-05 18:13:19	0	t	8	\N
1081	542	2022-10-05 18:13:27	13	t	9	\N
1082	542	2022-10-05 18:13:36	13	t	9	\N
1083	542	2022-10-05 18:13:40	0	t	12	\N
1084	542	2022-10-05 18:13:43	13	t	9	\N
1085	542	2022-10-05 18:14:06	1	f	9	\N
1086	542	2022-10-05 18:14:06	0	f	9	\N
1087	542	2022-10-05 18:14:06	13	t	9	\N
1088	542	2022-10-05 18:14:13	0	t	8	\N
1089	542	2022-10-05 18:14:14	1	f	9	\N
1090	542	2022-10-05 18:14:14	13	t	9	\N
1091	542	2022-10-05 18:14:24	0	f	9	\N
1092	542	2022-10-05 18:14:24	1	f	9	\N
1093	542	2022-10-05 18:14:24	13	t	9	\N
1094	542	2022-10-05 18:14:33	0	t	12	\N
1095	542	2022-10-05 18:14:33	1	f	9	\N
1096	542	2022-10-05 18:14:34	13	t	9	\N
1097	542	2022-10-05 18:14:36	0	f	9	\N
1098	542	2022-10-05 18:14:36	1	f	9	\N
1099	542	2022-10-05 18:14:36	13	t	9	\N
1100	543	2022-10-05 18:20:04	12	t	3	\N
1101	543	2022-10-05 18:20:13	12	t	3	\N
1102	543	2022-10-05 18:20:18	13	t	2	\N
1103	543	2022-10-05 18:20:20	13	t	2	\N
1104	543	2022-10-05 18:20:22	13	t	2	\N
1105	543	2022-10-05 18:20:24	0	t	1	\N
1106	543	2022-10-05 18:20:24	12	t	3	\N
1107	543	2022-10-05 18:20:28	13	t	2	\N
1108	543	2022-10-05 18:20:28	0	t	1	\N
1109	543	2022-10-05 18:20:32	0	t	1	\N
1110	544	2022-10-05 18:27:05	0	f	7	\N
1111	544	2022-10-05 18:31:03	1	t	7	\N
1112	544	2022-10-05 18:31:04	13	t	5	\N
1113	544	2022-10-05 18:31:06	1	t	7	\N
1114	544	2022-10-05 18:31:07	0	t	4	\N
1115	544	2022-10-05 18:31:09	13	t	6	\N
1116	544	2022-10-05 18:31:10	1	t	7	\N
1117	544	2022-10-05 18:31:11	13	t	6	\N
1118	544	2022-10-05 18:31:14	13	t	6	\N
1119	544	2022-10-05 18:31:14	13	t	6	\N
1120	544	2022-10-05 18:31:15	13	t	6	\N
1121	544	2022-10-05 18:31:18	13	t	5	\N
1122	544	2022-10-05 18:31:19	1	t	7	\N
1123	555	2022-10-05 19:42:29	2	t	21	\N
1124	555	2022-10-05 19:42:32	2	t	21	\N
1125	555	2022-10-05 19:42:35	1	f	19	\N
1126	555	2022-10-05 19:42:37	1	f	19	\N
1127	555	2022-10-05 19:42:39	1	f	19	\N
1128	555	2022-10-05 19:42:40	2	f	19	\N
1129	555	2022-10-05 19:42:41	0	t	19	\N
1130	555	2022-10-05 19:42:45	3	f	21	\N
1131	555	2022-10-05 19:42:46	2	t	21	\N
1132	555	2022-10-05 19:42:48	0	t	20	\N
1133	555	2022-10-05 19:42:50	1	t	22	\N
1134	555	2022-10-05 19:42:52	2	t	21	\N
1135	555	2022-10-05 19:42:53	0	t	20	\N
1136	555	2022-10-05 19:42:54	0	t	20	\N
1137	555	2022-10-05 19:42:56	1	t	22	\N
1138	555	2022-10-05 19:42:58	0	t	20	\N
1139	555	2022-10-05 19:42:59	1	t	22	\N
1140	555	2022-10-05 19:43:00	0	t	20	\N
1141	555	2022-10-05 19:43:02	0	t	19	\N
1142	555	2022-10-05 19:43:03	1	t	22	\N
1143	556	2022-10-05 19:51:04	2	t	21	\N
1144	556	2022-10-05 19:53:03	0	t	19	\N
1145	557	2022-10-05 19:53:34	2	t	24	\N
1146	557	2022-10-05 19:53:42	0	t	23	\N
1147	558	2022-10-05 19:54:35	0	t	4	\N
1148	558	2022-10-05 19:54:39	1	t	7	\N
1149	558	2022-10-05 19:54:41	13	t	6	\N
1150	558	2022-10-05 19:54:43	13	t	5	\N
1151	558	2022-10-05 19:54:47	13	t	6	\N
1152	558	2022-10-05 19:54:49	1	t	7	\N
1153	558	2022-10-05 19:54:52	1	t	7	\N
1154	558	2022-10-05 19:54:53	1	t	7	\N
1155	558	2022-10-05 19:54:55	13	t	5	\N
1156	558	2022-10-05 19:55:01	13	t	6	\N
1157	558	2022-10-05 19:55:03	13	t	5	\N
1158	558	2022-10-05 19:55:04	0	t	4	\N
1159	559	2022-10-05 19:55:33	2	t	40	\N
1160	559	2022-10-05 19:55:36	13	t	38	\N
1161	559	2022-10-05 19:55:38	12	t	42	\N
1162	559	2022-10-05 19:55:41	2	t	43	\N
1163	559	2022-10-05 19:55:42	0	t	41	\N
1164	559	2022-10-05 19:55:44	12	t	44	\N
1165	559	2022-10-05 19:55:45	12	t	42	\N
1166	559	2022-10-05 19:55:47	2	t	43	\N
1167	559	2022-10-05 19:55:49	2	t	43	\N
1168	559	2022-10-05 19:55:51	12	t	42	\N
1169	559	2022-10-05 19:55:54	12	t	39	\N
1170	559	2022-10-05 19:55:56	0	t	41	\N
1171	559	2022-10-05 19:55:56	13	t	38	\N
1172	559	2022-10-05 19:55:58	13	t	38	\N
1173	559	2022-10-05 19:55:59	13	t	38	\N
1174	559	2022-10-05 19:56:01	12	t	44	\N
1175	559	2022-10-05 19:56:02	12	t	39	\N
1176	559	2022-10-05 19:56:04	2	t	43	\N
1177	559	2022-10-05 19:56:06	0	f	40	\N
1178	559	2022-10-05 19:56:07	0	f	40	\N
1179	559	2022-10-05 19:56:08	0	f	40	\N
1180	559	2022-10-05 19:56:10	0	f	40	\N
1181	559	2022-10-05 19:56:13	2	t	40	\N
1182	559	2022-10-05 19:56:15	13	t	38	\N
1183	559	2022-10-05 19:56:17	12	t	44	\N
1184	559	2022-10-05 19:56:18	12	t	39	\N
1185	559	2022-10-05 19:56:20	12	t	39	\N
1186	559	2022-10-05 19:56:22	12	t	42	\N
1187	561	2022-10-05 20:07:45	0	f	42	\N
1188	561	2022-10-05 20:07:46	0	f	42	\N
1189	561	2022-10-05 20:07:49	12	t	42	\N
1190	561	2022-10-05 20:07:52	12	t	39	\N
1191	561	2022-10-05 20:07:54	2	t	40	\N
1192	561	2022-10-05 20:07:55	0	t	41	\N
1193	561	2022-10-05 20:07:56	2	t	40	\N
1194	561	2022-10-05 20:07:58	12	t	42	\N
1195	561	2022-10-05 20:07:59	12	t	44	\N
1196	561	2022-10-05 20:08:00	13	t	38	\N
1197	561	2022-10-05 20:08:01	12	t	39	\N
1198	561	2022-10-05 20:08:03	12	t	39	\N
1199	561	2022-10-05 20:08:04	2	t	40	\N
1200	561	2022-10-05 20:08:05	13	t	38	\N
1201	561	2022-10-05 20:08:06	0	t	41	\N
1202	561	2022-10-05 20:08:08	2	t	43	\N
1203	561	2022-10-05 20:08:08	13	t	38	\N
1204	561	2022-10-05 20:08:29	12	t	42	\N
1205	561	2022-10-05 20:08:31	13	t	38	\N
1206	561	2022-10-05 20:08:33	0	t	41	\N
1207	561	2022-10-05 20:08:34	2	t	43	\N
1208	561	2022-10-05 20:08:35	12	t	39	\N
1209	561	2022-10-05 20:08:39	2	f	41	\N
1210	561	2022-10-05 20:08:40	0	t	41	\N
1211	561	2022-10-05 20:08:41	0	f	40	\N
1212	561	2022-10-05 20:08:42	0	f	40	\N
1213	561	2022-10-05 20:08:43	2	t	40	\N
1214	561	2022-10-05 20:08:44	12	t	44	\N
1215	561	2022-10-05 20:08:46	12	t	44	\N
1216	563	2022-10-05 20:15:47	1	t	28	\N
1217	563	2022-10-05 20:15:50	2	t	27	\N
1218	563	2022-10-05 20:15:52	2	t	24	\N
1219	563	2022-10-05 20:15:54	12	t	29	\N
1220	563	2022-10-05 20:15:57	1	t	28	\N
1221	563	2022-10-05 20:16:00	12	t	29	\N
1222	563	2022-10-05 20:16:01	0	t	23	\N
1223	563	2022-10-05 20:16:03	2	f	30	\N
1224	563	2022-10-05 20:16:10	0	t	30	\N
1225	563	2022-10-05 20:16:13	12	t	29	\N
1226	563	2022-10-05 20:16:15	0	t	23	\N
1227	563	2022-10-05 20:16:17	1	t	25	\N
1228	563	2022-10-05 20:16:20	1	t	28	\N
1229	563	2022-10-05 20:16:25	2	t	27	\N
1230	563	2022-10-05 20:16:28	0	f	27	\N
1231	563	2022-10-05 20:16:28	2	t	27	\N
1232	563	2022-10-05 20:16:32	0	t	30	\N
1233	563	2022-10-05 20:16:34	0	t	23	\N
1234	563	2022-10-05 20:16:36	0	t	30	\N
1235	563	2022-10-05 20:16:38	2	t	24	\N
1236	563	2022-10-05 20:16:40	0	t	26	\N
1237	563	2022-10-05 20:16:45	0	t	30	\N
1238	565	2022-10-05 20:18:15	0	t	1	\N
1239	565	2022-10-05 20:18:17	13	t	2	\N
1240	565	2022-10-05 20:18:18	12	t	3	\N
1241	565	2022-10-05 20:18:19	0	t	1	\N
1242	565	2022-10-05 20:18:20	0	t	1	\N
1243	565	2022-10-05 20:18:22	12	t	3	\N
1244	565	2022-10-05 20:18:25	12	t	3	\N
1245	565	2022-10-05 20:18:26	12	t	3	\N
1246	565	2022-10-05 20:18:28	0	t	1	\N
1247	565	2022-10-05 20:18:30	13	t	2	\N
1248	566	2022-10-05 20:18:49	13	t	5	\N
1249	566	2022-10-05 20:18:52	1	t	7	\N
1250	566	2022-10-05 20:18:53	13	t	6	\N
1251	566	2022-10-05 20:18:55	12	f	6	\N
1252	566	2022-10-05 20:18:57	12	f	6	\N
1253	566	2022-10-05 20:18:59	13	t	6	\N
1254	566	2022-10-05 20:19:00	0	t	4	\N
1255	566	2022-10-05 20:19:01	0	t	4	\N
1256	566	2022-10-05 20:19:02	13	t	5	\N
1257	566	2022-10-05 20:19:04	0	t	4	\N
1258	566	2022-10-05 20:19:06	13	t	6	\N
1259	566	2022-10-05 20:19:07	0	t	4	\N
1260	566	2022-10-05 20:19:08	1	t	7	\N
1261	566	2022-10-05 20:19:08	13	t	6	\N
1262	567	2022-10-05 20:24:48	0	t	1	\N
1263	567	2022-10-05 20:24:51	0	t	1	\N
1264	567	2022-10-05 20:24:54	0	t	1	\N
1265	567	2022-10-05 20:24:56	0	t	1	\N
1266	567	2022-10-05 20:24:57	0	t	1	\N
1267	567	2022-10-05 20:25:04	23	f	2	\N
1268	567	2022-10-05 20:25:09	13	t	2	\N
1269	567	2022-10-05 20:25:18	13	f	1	\N
1270	567	2022-10-05 20:25:22	0	t	1	\N
1271	567	2022-10-05 20:25:25	2	f	3	\N
1272	567	2022-10-05 20:25:26	1	f	3	\N
1273	567	2022-10-05 20:25:27	3	f	3	\N
1274	567	2022-10-05 20:25:28	23	f	3	\N
1275	567	2022-10-05 20:25:29	12	t	3	\N
1276	568	2022-10-05 20:26:35	12	f	8	\N
1277	568	2022-10-05 20:26:36	0	t	8	\N
1278	568	2022-10-05 20:26:40	0	f	11	\N
1279	568	2022-10-05 20:26:40	0	f	11	\N
1280	568	2022-10-05 20:26:41	0	f	11	\N
1281	568	2022-10-05 20:26:43	0	f	11	\N
1282	568	2022-10-05 20:26:44	0	f	11	\N
1283	568	2022-10-05 20:26:44	0	f	11	\N
1284	568	2022-10-05 20:26:47	0	f	11	\N
1285	568	2022-10-05 20:26:47	0	f	11	\N
1286	568	2022-10-05 20:26:50	0	f	11	\N
1287	568	2022-10-05 20:26:52	0	f	11	\N
1288	568	2022-10-05 20:26:53	0	f	11	\N
1289	568	2022-10-05 20:26:54	0	f	11	\N
1290	568	2022-10-05 20:26:57	0	f	11	\N
1291	568	2022-10-05 20:26:57	1	t	11	\N
1292	568	2022-10-05 20:26:58	0	t	12	\N
1293	568	2022-10-05 20:27:01	0	t	8	\N
1294	568	2022-10-05 20:27:01	12	t	10	\N
1295	568	2022-10-05 20:27:02	12	t	10	\N
1296	568	2022-10-05 20:27:04	1	t	11	\N
1297	568	2022-10-05 20:27:04	13	t	9	\N
1298	568	2022-10-05 20:27:05	0	t	12	\N
1299	568	2022-10-05 20:27:07	13	t	9	\N
1300	568	2022-10-05 20:27:08	0	t	12	\N
1301	568	2022-10-05 20:27:08	0	t	8	\N
1302	568	2022-10-05 20:27:10	13	t	9	\N
1303	568	2022-10-05 20:27:11	0	t	12	\N
1304	568	2022-10-05 20:27:11	12	t	10	\N
1305	570	2022-10-05 20:29:07	13	t	5	\N
1306	570	2022-10-05 20:29:10	13	t	6	\N
1307	570	2022-10-05 20:29:12	13	t	5	\N
1308	570	2022-10-05 20:29:14	123	f	6	\N
1309	570	2022-10-05 20:29:16	13	t	6	\N
1310	570	2022-10-05 20:29:17	23	f	4	\N
1311	570	2022-10-05 20:29:19	12	f	4	\N
1312	570	2022-10-05 20:29:20	0	t	4	\N
1313	570	2022-10-05 20:29:21	0	t	4	\N
1314	570	2022-10-05 20:29:22	0	f	6	\N
1315	571	2022-10-05 20:32:03	0	t	8	\N
1316	571	2022-10-05 20:32:05	0	t	8	\N
1317	571	2022-10-05 20:32:09	13	t	9	\N
1318	571	2022-10-05 20:32:12	1	f	9	\N
1319	571	2022-10-05 20:32:15	1	f	9	\N
1320	571	2022-10-05 20:32:16	1	f	9	\N
1321	571	2022-10-05 20:32:19	13	t	9	\N
1322	571	2022-10-05 20:32:22	13	t	9	\N
1323	571	2022-10-05 20:32:25	12	f	12	\N
1324	571	2022-10-05 20:32:27	0	t	12	\N
1325	571	2022-10-05 20:32:28	0	t	12	\N
1326	571	2022-10-05 20:32:30	1	t	11	\N
1327	571	2022-10-05 20:32:32	1	t	11	\N
1328	571	2022-10-05 20:32:34	12	t	10	\N
1329	571	2022-10-05 20:32:36	1	t	11	\N
1330	571	2022-10-05 20:32:38	12	t	10	\N
1331	571	2022-10-05 20:32:39	12	t	10	\N
1332	571	2022-10-05 20:32:42	0	t	12	\N
1333	571	2022-10-05 20:32:45	12	t	10	\N
1334	572	2022-10-05 20:33:28	2	t	18	\N
1335	572	2022-10-05 20:33:30	1	f	18	\N
1336	572	2022-10-05 20:33:34	1	f	18	\N
1337	572	2022-10-05 20:33:35	2	t	18	\N
1338	572	2022-10-05 20:33:38	13	t	14	\N
1339	572	2022-10-05 20:33:40	1	t	16	\N
1340	572	2022-10-05 20:33:41	0	t	17	\N
1341	572	2022-10-05 20:33:43	12	t	15	\N
1342	572	2022-10-05 20:33:46	0	t	13	\N
1343	572	2022-10-05 20:33:48	12	t	15	\N
1344	572	2022-10-05 20:33:49	13	t	14	\N
1345	572	2022-10-05 20:33:51	0	t	13	\N
1346	572	2022-10-05 20:33:53	12	f	16	\N
1347	572	2022-10-05 20:33:54	1	t	16	\N
1348	572	2022-10-05 20:33:56	13	t	14	\N
1349	572	2022-10-05 20:33:58	2	t	18	\N
1350	572	2022-10-05 20:34:00	1	f	14	\N
1351	572	2022-10-05 20:34:02	13	t	14	\N
1352	572	2022-10-05 20:34:05	0	t	13	\N
1353	572	2022-10-05 20:34:07	1	f	13	\N
1354	572	2022-10-05 20:34:07	1	f	13	\N
1355	572	2022-10-05 20:34:10	1	f	13	\N
1356	572	2022-10-05 20:34:11	0	t	13	\N
1357	572	2022-10-05 20:34:13	0	t	17	\N
1358	572	2022-10-05 20:34:14	0	t	13	\N
1359	573	2022-10-05 20:40:05	12	f	12	\N
1360	573	2022-10-05 20:40:08	0	t	12	\N
1361	573	2022-10-05 20:40:10	0	t	12	\N
1362	573	2022-10-05 20:40:10	0	t	12	\N
1363	573	2022-10-05 20:40:13	13	t	9	\N
1364	573	2022-10-05 20:40:15	1	t	11	\N
1365	573	2022-10-05 20:40:16	0	t	8	\N
1366	573	2022-10-05 20:40:18	13	t	9	\N
1367	573	2022-10-05 20:40:21	13	t	9	\N
1368	573	2022-10-05 20:40:23	12	t	10	\N
1369	573	2022-10-05 20:40:24	0	t	8	\N
1370	573	2022-10-05 20:40:26	13	t	9	\N
1371	573	2022-10-05 20:40:28	12	t	10	\N
1372	573	2022-10-05 20:40:29	12	t	10	\N
1373	573	2022-10-05 20:40:31	1	t	11	\N
1374	573	2022-10-05 20:40:33	13	t	9	\N
1375	574	2022-10-05 20:52:57	12	t	37	\N
1376	574	2022-10-05 20:53:00	23	t	34	\N
1377	574	2022-10-05 20:53:02	1	t	31	\N
1378	574	2022-10-05 20:53:03	13	t	33	\N
1379	574	2022-10-05 20:53:05	13	t	33	\N
1380	574	2022-10-05 20:53:08	1	t	35	\N
1381	574	2022-10-05 20:53:10	1	t	35	\N
1382	574	2022-10-05 20:53:11	23	t	34	\N
1383	574	2022-10-05 20:53:13	23	t	34	\N
1384	574	2022-10-05 20:53:16	1	t	35	\N
1385	574	2022-10-05 20:53:17	0	t	36	\N
1386	574	2022-10-05 20:53:18	13	t	33	\N
1387	574	2022-10-05 20:53:19	0	t	32	\N
1388	574	2022-10-05 20:53:22	1	t	31	\N
1389	574	2022-10-05 20:53:23	1	t	31	\N
1390	574	2022-10-05 20:53:24	1	t	31	\N
1391	574	2022-10-05 20:53:26	0	t	36	\N
1392	574	2022-10-05 20:53:27	1	t	35	\N
1393	574	2022-10-05 20:53:29	0	t	32	\N
1394	574	2022-10-05 20:53:30	1	t	31	\N
1395	574	2022-10-05 20:53:32	1	t	35	\N
1396	574	2022-10-05 20:53:33	0	t	36	\N
1397	574	2022-10-05 20:53:35	23	t	34	\N
1398	574	2022-10-05 20:53:37	12	t	37	\N
1399	574	2022-10-05 20:53:39	12	t	37	\N
1400	574	2022-10-05 20:53:41	12	t	37	\N
1401	574	2022-10-05 20:53:42	1	t	31	\N
1402	574	2022-10-05 20:53:43	23	t	34	\N
1403	574	2022-10-05 20:53:45	12	t	37	\N
1404	574	2022-10-05 20:53:46	12	t	37	\N
1405	577	2022-10-06 00:51:17	2	t	27	\N
1406	577	2022-10-06 00:51:20	2	t	27	\N
1407	577	2022-10-06 00:51:21	2	t	27	\N
1408	577	2022-10-06 00:51:23	12	t	29	\N
1409	577	2022-10-06 00:51:28	1	t	25	\N
1410	577	2022-10-06 00:51:29	0	t	23	\N
1411	577	2022-10-06 00:51:29	2	t	27	\N
1412	577	2022-10-06 00:51:31	1	t	25	\N
1413	577	2022-10-06 00:51:31	2	t	27	\N
1414	578	2022-10-06 00:52:20	0	t	13	\N
1415	578	2022-10-06 00:52:25	13	t	14	\N
1416	580	2022-10-06 13:34:51	0	f	35	\N
1417	580	2022-10-06 13:34:54	1	t	35	\N
1418	580	2022-10-06 13:35:00	1	t	31	\N
1419	580	2022-10-06 13:35:02	0	t	36	\N
1420	580	2022-10-06 13:35:03	0	t	32	\N
1421	580	2022-10-06 13:35:04	0	t	32	\N
1422	580	2022-10-06 13:35:06	0	t	32	\N
1423	580	2022-10-06 13:35:07	1	t	35	\N
1424	580	2022-10-06 13:35:08	0	t	32	\N
1425	580	2022-10-06 13:35:09	0	t	36	\N
1426	580	2022-10-06 13:35:11	1	t	35	\N
1427	580	2022-10-06 13:35:12	0	t	36	\N
1428	580	2022-10-06 13:35:13	23	t	34	\N
1429	580	2022-10-06 13:35:14	23	t	34	\N
1430	580	2022-10-06 13:35:17	13	t	33	\N
1431	580	2022-10-06 13:35:18	0	t	36	\N
1432	580	2022-10-06 13:35:21	12	t	37	\N
1433	580	2022-10-06 13:35:21	0	t	32	\N
1434	580	2022-10-06 13:35:23	1	t	35	\N
1435	580	2022-10-06 13:35:27	1	t	35	\N
1436	580	2022-10-06 13:35:27	1	t	35	\N
1437	580	2022-10-06 13:35:34	1	t	35	\N
1438	580	2022-10-06 13:35:34	12	t	37	\N
1439	580	2022-10-06 13:35:42	23	t	34	\N
1440	580	2022-10-06 13:35:45	23	t	34	\N
1441	580	2022-10-06 13:35:45	0	t	36	\N
1442	580	2022-10-06 13:35:47	12	t	37	\N
1443	580	2022-10-06 13:35:49	1	t	31	\N
1444	580	2022-10-06 13:35:49	1	t	31	\N
1445	580	2022-10-06 13:35:54	23	t	34	\N
1446	581	2022-10-06 13:40:05	12	t	3	\N
1447	582	2022-10-06 14:11:02	12	t	42	\N
1448	583	2022-10-06 14:12:03	0	t	45	\N
1449	584	2022-10-06 14:12:58	12	t	44	\N
1450	584	2022-10-06 14:13:03	12	t	44	\N
1451	584	2022-10-06 14:13:08	2	t	43	\N
1452	584	2022-10-06 14:13:11	12	t	39	\N
1453	584	2022-10-06 14:13:12	0	t	41	\N
1454	585	2022-10-06 14:20:07	0	t	41	\N
1455	586	2022-10-06 14:22:00	12	t	37	\N
1456	587	2022-10-06 14:28:12	0	f	37	\N
1457	587	2022-10-06 14:28:18	12	t	37	\N
1458	587	2022-10-06 14:28:35	0	t	36	\N
1459	588	2022-10-06 14:34:23	1	t	31	\N
1460	589	2022-10-06 14:36:56	0	f	43	\N
1461	589	2022-10-06 14:37:00	2	t	43	\N
1462	590	2022-10-06 15:07:48	13	t	33	\N
1463	592	2022-10-06 15:10:47	2	t	40	\N
1464	593	2022-10-06 15:11:39	2	t	40	\N
1465	594	2022-10-06 15:12:39	1	t	31	\N
1466	595	2022-10-06 15:13:41	1	t	35	\N
1467	596	2022-10-06 15:14:45	0	t	32	\N
1468	597	2022-10-06 15:27:47	23	t	34	\N
1469	599	2022-10-06 15:35:01	0	t	32	\N
1470	600	2022-10-06 15:37:17	0	t	13	\N
1471	600	2022-10-06 15:37:25	13	t	14	\N
1472	603	2022-10-06 15:46:44	0	f	3	\N
1473	603	2022-10-06 15:46:45	0	f	3	\N
1474	603	2022-10-06 15:46:47	0	f	3	\N
1475	603	2022-10-06 15:46:48	0	f	3	\N
1476	603	2022-10-06 15:46:50	0	f	3	\N
1477	603	2022-10-06 15:46:50	12	t	3	\N
1478	603	2022-10-06 15:46:54	13	t	2	\N
1479	603	2022-10-06 15:47:12	13	f	3	\N
1480	603	2022-10-06 15:47:15	12	t	3	\N
1481	603	2022-10-06 15:47:17	12	t	3	\N
1482	603	2022-10-06 15:47:21	13	t	2	\N
1483	603	2022-10-06 15:47:58	12	t	3	\N
1484	603	2022-10-06 15:48:02	0	t	1	\N
1485	603	2022-10-06 15:48:02	12	t	3	\N
1486	603	2022-10-06 15:48:04	0	t	1	\N
1487	603	2022-10-06 15:48:15	13	t	2	\N
1488	604	2022-10-06 15:48:32	0	t	26	\N
1489	604	2022-10-06 15:48:38	0	t	23	\N
1490	604	2022-10-06 15:48:40	0	t	23	\N
1491	604	2022-10-06 15:48:43	12	t	29	\N
1492	604	2022-10-06 15:48:47	2	t	24	\N
1493	604	2022-10-06 15:48:49	12	f	28	\N
1494	604	2022-10-06 15:48:54	1	t	28	\N
1495	604	2022-10-06 15:49:00	2	t	27	\N
1496	604	2022-10-06 15:49:03	1	t	25	\N
1497	604	2022-10-06 15:49:05	2	t	27	\N
1498	605	2022-10-06 15:50:32	0	t	20	\N
1499	605	2022-10-06 15:50:35	2	t	21	\N
1500	605	2022-10-06 15:50:37	1	t	22	\N
1501	605	2022-10-06 15:50:39	2	t	21	\N
1502	605	2022-10-06 15:51:16	2	t	21	\N
1503	605	2022-10-06 15:51:17	0	t	20	\N
1504	605	2022-10-06 15:51:19	2	t	21	\N
1505	605	2022-10-06 15:51:20	1	t	22	\N
1506	605	2022-10-06 15:51:21	0	t	19	\N
1507	605	2022-10-06 15:51:32	1	t	22	\N
1508	605	2022-10-06 15:51:33	0	t	19	\N
1509	605	2022-10-06 15:51:35	2	t	21	\N
1510	605	2022-10-06 15:51:38	0	t	20	\N
1511	605	2022-10-06 15:51:40	2	t	21	\N
1512	605	2022-10-06 15:51:41	0	t	20	\N
1513	606	2022-10-06 16:03:20	0	t	12	\N
1514	606	2022-10-06 16:03:25	1	f	8	\N
1515	606	2022-10-06 16:03:29	0	t	8	\N
1516	606	2022-10-06 16:03:31	13	t	9	\N
1517	606	2022-10-06 16:03:37	13	t	9	\N
1518	606	2022-10-06 16:03:37	0	t	12	\N
1519	606	2022-10-06 16:03:37	0	t	12	\N
1520	606	2022-10-06 16:03:40	0	t	8	\N
1521	606	2022-10-06 16:03:41	0	f	10	\N
1522	606	2022-10-06 16:03:41	0	t	8	\N
1523	606	2022-10-06 16:03:47	12	t	10	\N
1524	606	2022-10-06 16:03:47	1	t	11	\N
1525	606	2022-10-06 16:03:47	12	t	10	\N
1526	606	2022-10-06 16:03:51	1	t	11	\N
1527	606	2022-10-06 16:03:51	12	t	10	\N
1528	606	2022-10-06 16:03:51	13	t	9	\N
1529	606	2022-10-06 16:03:54	12	t	10	\N
1530	607	2022-10-06 17:00:22	13	t	2	\N
1531	608	2022-10-06 17:58:30	0	t	36	\N
1532	608	2022-10-06 18:18:14	13	f	32	\N
1533	608	2022-10-06 18:18:16	13	f	32	\N
1534	608	2022-10-06 18:18:17	13	f	32	\N
1535	608	2022-10-06 18:18:19	13	f	32	\N
1536	608	2022-10-06 18:18:20	13	f	32	\N
1537	608	2022-10-06 18:18:21	13	f	32	\N
1538	608	2022-10-06 18:18:22	13	f	32	\N
1539	608	2022-10-06 18:18:25	0	t	32	\N
1540	608	2022-10-06 18:18:27	1	t	31	\N
1541	608	2022-10-06 18:18:28	12	t	37	\N
1542	608	2022-10-06 18:18:30	13	t	33	\N
1543	608	2022-10-06 18:18:31	1	t	35	\N
1544	608	2022-10-06 18:18:33	0	t	36	\N
1545	608	2022-10-06 18:18:34	0	t	32	\N
1546	608	2022-10-06 18:18:35	0	t	36	\N
1547	608	2022-10-06 18:18:37	23	t	34	\N
1548	608	2022-10-06 18:18:39	1	t	35	\N
1549	608	2022-10-06 18:18:40	13	t	33	\N
1550	608	2022-10-06 18:18:42	0	t	36	\N
1551	608	2022-10-06 18:18:43	13	t	33	\N
1552	608	2022-10-06 18:18:44	12	t	37	\N
1553	608	2022-10-06 18:18:46	12	t	37	\N
1554	608	2022-10-06 18:18:47	12	t	37	\N
1555	608	2022-10-06 18:18:49	1	t	31	\N
1556	608	2022-10-06 18:18:50	13	t	33	\N
1557	608	2022-10-06 18:18:52	1	t	35	\N
1558	608	2022-10-06 18:18:53	12	t	37	\N
1559	608	2022-10-06 18:18:54	0	t	36	\N
1560	608	2022-10-06 18:18:55	1	t	31	\N
1561	608	2022-10-06 18:18:57	12	t	37	\N
1562	608	2022-10-06 18:18:58	23	t	34	\N
1563	608	2022-10-06 18:19:00	0	t	32	\N
1564	608	2022-10-06 18:19:01	23	t	34	\N
1565	608	2022-10-06 18:19:03	1	t	31	\N
1566	608	2022-10-06 18:19:04	0	t	36	\N
1567	608	2022-10-06 18:19:06	1	t	35	\N
1568	609	2022-10-06 20:28:06	0	f	3	\N
1569	609	2022-10-06 20:28:10	12	t	3	\N
1570	609	2022-10-06 20:28:12	0	t	1	\N
1571	609	2022-10-06 20:28:15	13	t	2	\N
1572	609	2022-10-06 20:28:17	0	t	1	\N
1573	609	2022-10-06 20:28:18	0	t	1	\N
1574	609	2022-10-06 20:28:22	0	t	1	\N
1575	609	2022-10-06 20:28:27	12	t	3	\N
1576	609	2022-10-06 20:28:29	13	t	2	\N
1577	609	2022-10-06 20:28:32	13	t	2	\N
1578	609	2022-10-06 20:28:34	0	t	1	\N
1579	610	2022-10-06 20:28:48	0	t	4	\N
1580	610	2022-10-06 20:28:51	13	t	6	\N
1581	610	2022-10-06 20:28:53	13	f	4	\N
1582	610	2022-10-06 20:28:54	0	t	4	\N
1583	611	2022-10-07 13:55:53	0	t	8	\N
1584	611	2022-10-07 13:56:00	0	t	12	\N
1585	611	2022-10-07 13:56:01	0	t	8	\N
1586	611	2022-10-07 13:56:02	0	t	8	\N
1587	611	2022-10-07 13:56:04	1	t	11	\N
1588	611	2022-10-07 13:56:05	1	t	11	\N
1589	611	2022-10-07 13:56:06	1	t	11	\N
1590	611	2022-10-07 13:56:07	13	t	9	\N
1591	611	2022-10-07 13:56:08	13	t	9	\N
1592	611	2022-10-07 13:56:09	13	t	9	\N
1593	611	2022-10-07 13:56:10	1	t	11	\N
1594	611	2022-10-07 13:56:11	13	t	9	\N
1595	611	2022-10-07 13:56:12	1	t	11	\N
1596	611	2022-10-07 13:56:13	0	t	8	\N
1597	611	2022-10-07 13:56:14	0	t	12	\N
1598	612	2022-10-07 13:56:28	1	t	22	\N
1599	612	2022-10-07 13:56:32	12	f	19	\N
1600	612	2022-10-07 13:56:33	0	t	19	\N
1601	612	2022-10-07 13:56:35	2	t	21	\N
1602	612	2022-10-07 13:56:37	1	t	22	\N
1603	612	2022-10-07 13:56:37	0	t	19	\N
1604	612	2022-10-07 13:56:39	2	t	21	\N
1605	612	2022-10-07 13:56:40	1	t	22	\N
1606	612	2022-10-07 13:56:41	1	t	22	\N
1607	612	2022-10-07 13:56:42	0	t	19	\N
1608	612	2022-10-07 13:56:43	2	t	21	\N
1609	612	2022-10-07 13:56:44	1	t	22	\N
1610	612	2022-10-07 13:56:45	0	t	19	\N
1611	612	2022-10-07 13:56:46	0	t	19	\N
1612	612	2022-10-07 13:56:47	0	t	19	\N
1613	612	2022-10-07 13:56:49	2	t	21	\N
1614	613	2022-10-07 13:57:29	12	t	44	\N
1615	613	2022-10-07 13:57:31	12	t	44	\N
1616	613	2022-10-07 13:57:34	13	t	38	\N
1617	613	2022-10-07 13:57:35	12	t	39	\N
1618	613	2022-10-07 13:57:37	13	t	38	\N
1619	613	2022-10-07 13:57:38	12	t	42	\N
1620	613	2022-10-07 13:57:39	0	t	41	\N
1621	613	2022-10-07 13:57:40	12	t	39	\N
1622	613	2022-10-07 13:57:42	12	t	44	\N
1623	613	2022-10-07 13:57:42	0	t	41	\N
1624	613	2022-10-07 13:57:43	12	t	44	\N
1625	613	2022-10-07 13:57:44	13	t	38	\N
1626	613	2022-10-07 13:57:46	2	t	43	\N
1627	613	2022-10-07 13:57:47	12	t	42	\N
1628	613	2022-10-07 13:57:48	13	t	38	\N
1629	613	2022-10-07 13:57:49	2	t	40	\N
1630	613	2022-10-07 13:57:50	2	t	40	\N
1631	613	2022-10-07 13:57:51	2	t	40	\N
1632	613	2022-10-07 13:57:52	2	t	40	\N
1633	613	2022-10-07 13:57:53	12	t	42	\N
1634	613	2022-10-07 13:57:54	12	t	42	\N
1635	613	2022-10-07 13:57:55	12	t	42	\N
1636	613	2022-10-07 13:57:56	2	t	43	\N
1637	613	2022-10-07 13:57:58	12	t	44	\N
1638	614	2022-10-07 13:58:24	0	f	34	\N
1639	614	2022-10-07 13:58:25	0	f	34	\N
1640	616	2022-10-07 13:58:43	0	t	41	\N
1641	616	2022-10-07 13:58:46	12	t	39	\N
1642	616	2022-10-07 13:58:47	13	t	38	\N
1643	616	2022-10-07 13:58:48	13	t	38	\N
1644	616	2022-10-07 13:58:49	12	t	39	\N
1645	616	2022-10-07 13:58:50	2	t	43	\N
1646	616	2022-10-07 13:58:51	13	t	38	\N
1647	616	2022-10-07 13:58:52	12	t	44	\N
1648	616	2022-10-07 13:58:53	12	t	42	\N
1649	616	2022-10-07 13:58:56	12	t	39	\N
1650	616	2022-10-07 13:58:57	12	t	44	\N
1651	616	2022-10-07 13:58:58	12	t	44	\N
1652	616	2022-10-07 13:58:59	12	t	42	\N
1653	616	2022-10-07 13:59:00	12	t	44	\N
1654	616	2022-10-07 13:59:01	2	t	40	\N
1655	616	2022-10-07 13:59:02	12	t	42	\N
1656	616	2022-10-07 13:59:03	13	t	38	\N
1657	616	2022-10-07 13:59:04	13	t	38	\N
1658	616	2022-10-07 13:59:05	2	t	40	\N
1659	616	2022-10-07 13:59:06	0	t	41	\N
1660	616	2022-10-07 13:59:07	2	t	40	\N
1661	616	2022-10-07 13:59:08	2	t	43	\N
1662	616	2022-10-07 13:59:09	0	t	41	\N
1663	616	2022-10-07 13:59:10	2	t	43	\N
1664	617	2022-10-07 14:00:50	2	t	21	\N
1665	617	2022-10-07 14:00:52	0	t	20	\N
1666	617	2022-10-07 14:00:53	1	t	22	\N
1667	617	2022-10-07 14:00:54	2	t	21	\N
1668	617	2022-10-07 14:00:55	0	t	19	\N
1669	617	2022-10-07 14:00:56	0	t	20	\N
1670	617	2022-10-07 14:00:57	0	t	19	\N
1671	617	2022-10-07 14:00:58	0	t	20	\N
1672	617	2022-10-07 14:00:59	2	t	21	\N
1673	617	2022-10-07 14:01:00	0	t	19	\N
1674	617	2022-10-07 14:01:01	2	t	21	\N
1675	617	2022-10-07 14:01:02	2	t	21	\N
1676	617	2022-10-07 14:01:03	1	t	22	\N
1677	617	2022-10-07 14:01:04	0	t	20	\N
1678	617	2022-10-07 14:01:05	2	t	21	\N
1679	618	2022-10-07 15:27:07	13	t	9	\N
1680	618	2022-10-07 15:28:52	12	t	10	\N
1681	619	2022-10-07 15:29:24	0	t	13	\N
1682	619	2022-10-07 15:29:27	0	t	17	\N
1683	619	2022-10-07 15:29:30	13	t	14	\N
1684	619	2022-10-07 15:30:02	2	t	18	\N
1685	619	2022-10-07 15:30:04	1	t	16	\N
1686	619	2022-10-07 15:30:05	0	t	13	\N
1687	627	2022-10-10 13:17:29	13	t	33	\N
1688	627	2022-10-10 13:17:33	13	t	33	\N
1689	627	2022-10-10 13:17:37	1	t	35	\N
1690	627	2022-10-10 13:17:38	0	t	32	\N
1691	627	2022-10-10 13:17:39	1	t	31	\N
1692	627	2022-10-10 13:17:42	23	t	34	\N
1693	627	2022-10-10 13:17:44	13	t	33	\N
1694	627	2022-10-10 13:17:44	0	t	36	\N
1695	627	2022-10-10 13:17:47	23	t	34	\N
1696	627	2022-10-10 13:17:47	12	t	37	\N
1697	627	2022-10-10 13:17:48	12	t	37	\N
1698	627	2022-10-10 13:17:52	0	t	36	\N
1699	627	2022-10-10 13:17:54	23	t	34	\N
1700	627	2022-10-10 13:17:54	1	t	31	\N
1701	627	2022-10-10 13:17:56	1	t	31	\N
1702	627	2022-10-10 13:17:57	0	t	32	\N
1703	627	2022-10-10 13:17:57	0	t	36	\N
1704	627	2022-10-10 13:18:01	12	t	37	\N
1705	627	2022-10-10 13:18:03	12	t	37	\N
1706	627	2022-10-10 13:18:03	0	t	32	\N
1707	627	2022-10-10 13:18:04	12	t	37	\N
1708	627	2022-10-10 13:18:08	13	t	33	\N
1709	627	2022-10-10 13:18:08	1	t	31	\N
1710	627	2022-10-10 13:18:08	0	t	32	\N
1711	627	2022-10-10 13:18:11	0	t	36	\N
1712	627	2022-10-10 13:18:12	12	t	37	\N
1713	627	2022-10-10 13:18:12	23	t	34	\N
1714	627	2022-10-10 13:18:14	1	t	31	\N
1715	627	2022-10-10 13:18:15	1	t	31	\N
1716	627	2022-10-10 13:18:15	23	t	34	\N
1717	628	2022-10-11 13:45:40	0	t	45	\N
1718	628	2022-10-11 13:45:47	0	t	45	\N
1719	628	2022-10-11 13:45:55	12	t	46	\N
1720	628	2022-10-11 13:45:59	12	t	46	\N
1721	628	2022-10-11 13:46:01	12	t	46	\N
1722	628	2022-10-11 13:46:08	0	t	48	\N
1723	628	2022-10-11 13:46:13	2	t	50	\N
1724	628	2022-10-11 13:46:21	1	t	49	\N
1725	628	2022-10-11 13:46:22	1	t	49	\N
1726	628	2022-10-11 13:46:27	12	t	46	\N
1727	628	2022-10-11 13:46:29	0	t	48	\N
1728	628	2022-10-11 13:46:31	0	t	48	\N
1729	628	2022-10-11 13:46:33	1	t	49	\N
1730	628	2022-10-11 13:46:35	0	t	48	\N
1731	628	2022-10-11 13:46:37	0	t	45	\N
1732	628	2022-10-11 13:46:44	1	t	47	\N
1733	628	2022-10-11 13:46:49	0	t	48	\N
1734	628	2022-10-11 13:46:52	0	t	45	\N
1735	628	2022-10-11 13:46:52	0	t	45	\N
1736	628	2022-10-11 13:46:54	12	t	46	\N
1737	628	2022-10-11 13:46:58	0	t	48	\N
1738	628	2022-10-11 13:47:00	0	t	45	\N
1739	628	2022-10-11 13:47:09	2	f	47	\N
1740	628	2022-10-11 13:47:13	1	t	47	\N
1741	628	2022-10-11 13:47:17	2	t	50	\N
1742	628	2022-10-11 13:47:23	1	t	49	\N
1743	628	2022-10-11 13:47:30	1	t	47	\N
1744	628	2022-10-11 13:47:34	0	t	45	\N
1745	628	2022-10-11 13:47:35	0	t	45	\N
1746	628	2022-10-11 13:47:38	1	t	47	\N
1747	628	2022-10-11 13:47:41	2	t	50	\N
1748	628	2022-10-11 13:47:45	0	f	49	\N
1749	628	2022-10-11 13:47:51	1	t	49	\N
1750	628	2022-10-11 13:48:09	1	t	47	\N
1751	628	2022-10-11 13:48:17	1	t	49	\N
1752	628	2022-10-11 13:48:18	1	t	49	\N
1753	628	2022-10-11 13:48:20	1	f	46	\N
1754	628	2022-10-11 13:48:24	12	t	46	\N
1755	628	2022-10-11 13:48:27	0	t	48	\N
1756	628	2022-10-11 13:48:30	2	f	47	\N
1757	628	2022-10-11 13:48:32	1	t	47	\N
1758	628	2022-10-11 13:48:37	12	t	46	\N
1759	628	2022-10-11 13:48:40	0	t	48	\N
1760	628	2022-10-11 13:48:45	12	t	46	\N
1761	641	2022-10-11 15:10:14	0	t	17	\N
1762	641	2022-10-11 15:10:18	1	t	16	\N
1763	641	2022-10-11 15:10:20	2	t	18	\N
1764	641	2022-10-11 15:10:22	1	t	16	\N
1765	643	2022-10-11 15:58:37	13	t	6	\N
1766	643	2022-10-11 16:15:22	13	t	6	\N
1767	644	2022-10-12 01:36:37	0	t	12	\N
1768	644	2022-10-12 01:36:40	1	t	11	\N
1769	644	2022-10-12 01:36:43	12	t	10	\N
1770	644	2022-10-12 01:36:43	0	t	12	\N
1771	644	2022-10-12 01:36:44	12	t	10	\N
1772	644	2022-10-12 01:36:47	13	t	9	\N
1773	644	2022-10-12 01:36:47	13	t	9	\N
1774	644	2022-10-12 01:36:49	1	t	11	\N
1775	644	2022-10-12 01:36:50	0	t	12	\N
1776	644	2022-10-12 01:36:52	12	t	10	\N
1777	644	2022-10-12 01:36:52	0	t	12	\N
1778	644	2022-10-12 01:36:53	12	t	10	\N
1779	644	2022-10-12 01:37:02	12	t	10	\N
1780	644	2022-10-12 01:37:08	0	t	8	\N
1781	644	2022-10-12 01:37:09	1	t	11	\N
1782	44	2022-10-13 14:02:00	2	t	9	\N
1783	44	2022-10-13 14:03:02	2	t	9	\N
1784	645	2022-10-13 18:30:32	0	t	1	\N
1785	645	2022-10-13 18:30:37	0	t	1	\N
1786	645	2022-10-13 18:30:39	12	t	3	\N
1787	645	2022-10-13 18:30:40	0	t	1	\N
1788	645	2022-10-13 18:30:42	12	t	3	\N
1789	645	2022-10-13 18:30:43	13	t	2	\N
1790	645	2022-10-13 18:30:44	13	t	2	\N
1791	645	2022-10-13 18:30:46	12	t	3	\N
1792	645	2022-10-13 18:30:48	13	t	2	\N
1793	645	2022-10-13 18:30:50	12	t	3	\N
1794	646	2022-10-13 18:31:45	1	t	7	\N
1795	646	2022-10-13 18:31:47	13	t	5	\N
1796	646	2022-10-13 18:31:48	0	t	4	\N
1797	646	2022-10-13 18:31:49	0	t	4	\N
1798	646	2022-10-13 18:31:51	1	t	7	\N
1799	646	2022-10-13 18:31:52	13	t	6	\N
1800	646	2022-10-13 18:31:53	13	t	5	\N
1801	646	2022-10-13 18:31:56	13	t	6	\N
1802	646	2022-10-13 18:31:57	1	t	7	\N
1803	646	2022-10-13 18:31:58	13	t	5	\N
1804	646	2022-10-13 18:32:00	13	t	6	\N
1805	646	2022-10-13 18:32:00	13	t	6	\N
1806	679	2022-10-13 19:40:32	13	t	33	\N
1807	679	2022-10-13 19:40:34	13	t	33	\N
1808	679	2022-10-13 19:40:36	23	t	34	\N
1809	679	2022-10-13 19:40:38	1	f	34	\N
1810	679	2022-10-13 19:40:40	12	f	34	\N
1811	679	2022-10-13 19:40:41	23	t	34	\N
1812	679	2022-10-13 19:40:43	0	t	36	\N
1813	679	2022-10-13 19:40:45	13	t	33	\N
1814	679	2022-10-13 19:40:46	1	t	35	\N
1815	679	2022-10-13 19:40:47	23	t	34	\N
1816	679	2022-10-13 19:40:49	23	f	36	\N
1817	679	2022-10-13 19:40:50	0	t	36	\N
1818	679	2022-10-13 19:40:54	1	t	35	\N
1819	679	2022-10-13 19:40:54	0	t	32	\N
1820	679	2022-10-13 19:40:57	2	f	37	\N
1821	679	2022-10-13 19:40:57	12	t	37	\N
1822	679	2022-10-13 19:41:00	1	t	31	\N
1823	679	2022-10-13 19:41:00	1	t	35	\N
1824	679	2022-10-13 19:41:04	12	t	37	\N
1825	679	2022-10-13 19:41:04	23	t	34	\N
1826	679	2022-10-13 19:41:07	23	f	31	\N
1827	679	2022-10-13 19:41:07	1	t	31	\N
1828	679	2022-10-13 19:41:10	1	t	35	\N
1829	679	2022-10-13 19:41:10	0	t	36	\N
1830	679	2022-10-13 19:41:13	1	t	31	\N
1831	679	2022-10-13 19:41:13	13	t	33	\N
1832	679	2022-10-13 19:41:16	13	t	33	\N
1833	679	2022-10-13 19:41:16	12	t	37	\N
1834	679	2022-10-13 19:41:19	1	t	31	\N
1835	679	2022-10-13 19:41:19	1	t	31	\N
1836	679	2022-10-13 19:41:22	12	t	37	\N
1837	679	2022-10-13 19:41:22	12	t	37	\N
1838	679	2022-10-13 19:41:24	0	t	32	\N
1839	679	2022-10-13 19:41:25	23	t	34	\N
1840	679	2022-10-13 19:41:27	13	t	33	\N
1841	681	2022-10-13 19:47:14	13	t	2	\N
1842	681	2022-10-13 19:47:17	12	t	3	\N
1843	681	2022-10-13 19:47:19	13	t	2	\N
1844	681	2022-10-13 19:47:21	13	t	2	\N
1845	681	2022-10-13 19:47:23	0	t	1	\N
1846	681	2022-10-13 19:47:25	13	t	2	\N
1847	681	2022-10-13 19:47:28	13	t	2	\N
1848	681	2022-10-13 19:47:29	0	t	1	\N
1849	681	2022-10-13 19:47:31	0	t	1	\N
1850	681	2022-10-13 19:47:32	0	f	2	\N
1851	681	2022-10-13 19:47:34	13	t	2	\N
1852	684	2022-10-13 19:48:41	2	t	18	\N
1853	684	2022-10-13 19:48:44	13	t	14	\N
1854	684	2022-10-13 19:48:46	0	t	13	\N
1855	684	2022-10-13 19:48:47	0	t	17	\N
1856	684	2022-10-13 19:48:49	2	t	18	\N
1857	684	2022-10-13 19:48:51	13	t	14	\N
1858	684	2022-10-13 19:48:52	0	t	17	\N
1859	684	2022-10-13 19:48:54	12	t	15	\N
1860	684	2022-10-13 19:48:56	13	t	14	\N
1861	684	2022-10-13 19:48:57	1	t	16	\N
1862	684	2022-10-13 19:48:59	1	t	16	\N
1863	684	2022-10-13 19:49:00	13	t	14	\N
1864	684	2022-10-13 19:49:02	0	t	17	\N
1865	684	2022-10-13 19:49:04	13	t	14	\N
1866	684	2022-10-13 19:49:05	1	t	16	\N
1867	684	2022-10-13 19:49:07	0	t	17	\N
1868	684	2022-10-13 19:49:08	0	t	13	\N
1869	684	2022-10-13 19:49:11	13	t	14	\N
1870	685	2022-10-13 19:49:37	13	t	9	\N
1871	685	2022-10-13 19:49:39	1	t	11	\N
1872	685	2022-10-13 19:49:40	0	t	8	\N
1873	685	2022-10-13 19:49:42	0	t	12	\N
1874	685	2022-10-13 19:49:43	0	t	8	\N
1875	685	2022-10-13 19:49:46	0	t	12	\N
1876	685	2022-10-13 19:49:47	0	t	8	\N
1877	685	2022-10-13 19:49:48	0	t	12	\N
1878	685	2022-10-13 19:49:49	0	t	12	\N
1879	685	2022-10-13 19:49:51	0	t	12	\N
1880	685	2022-10-13 19:49:52	1	t	11	\N
1881	685	2022-10-13 19:49:55	0	t	8	\N
1882	685	2022-10-13 19:49:56	1	t	11	\N
1883	685	2022-10-13 19:49:58	13	t	9	\N
1884	685	2022-10-13 19:49:59	1	f	12	\N
1885	685	2022-10-13 19:50:01	12	f	12	\N
1886	685	2022-10-13 19:50:02	12	f	12	\N
1887	685	2022-10-13 19:50:04	12	f	12	\N
1888	685	2022-10-13 19:50:05	12	f	12	\N
1889	685	2022-10-13 19:50:07	12	f	12	\N
1890	685	2022-10-13 19:50:08	12	f	12	\N
1891	685	2022-10-13 19:50:10	12	f	12	\N
1892	685	2022-10-13 19:50:11	12	f	12	\N
1893	685	2022-10-13 19:50:13	0	t	12	\N
1894	687	2022-10-13 20:08:38	13	t	5	\N
1895	687	2022-10-13 20:09:06	13	t	6	\N
1896	44	2022-10-13 20:48:32	2	t	9	\N
1897	44	2022-10-13 20:48:37	3	f	9	\N
1898	723	2022-10-14 15:58:40	0	t	1	\N
1899	723	2022-10-14 15:58:42	12	t	3	\N
1900	723	2022-10-14 15:58:42	0	t	1	\N
1901	723	2022-10-14 15:58:43	13	t	2	\N
1902	723	2022-10-14 15:58:43	12	t	3	\N
1903	723	2022-10-14 15:58:44	13	t	2	\N
1904	723	2022-10-14 15:58:45	0	t	1	\N
1905	723	2022-10-14 15:58:45	12	t	3	\N
1906	723	2022-10-14 15:58:46	13	t	2	\N
1907	723	2022-10-14 15:58:46	1	f	3	\N
1908	723	2022-10-14 15:58:47	1	f	3	\N
1909	723	2022-10-14 15:58:47	1	f	3	\N
1910	723	2022-10-14 15:58:48	1	f	3	\N
1911	723	2022-10-14 15:58:48	1	f	3	\N
1912	723	2022-10-14 15:58:49	12	t	3	\N
1913	724	2022-10-14 16:03:59	12	t	3	\N
1914	724	2022-10-14 16:04:00	12	t	3	\N
1915	724	2022-10-14 16:04:03	12	t	3	\N
1916	724	2022-10-14 16:04:03	1	f	3	\N
1917	724	2022-10-14 16:04:03	12	t	3	\N
1918	724	2022-10-14 16:04:03	0	t	1	\N
1919	724	2022-10-14 16:04:03	1	f	1	\N
1920	724	2022-10-14 16:04:03	0	t	1	\N
1921	724	2022-10-14 16:04:03	0	t	1	\N
1922	724	2022-10-14 16:04:03	12	t	3	\N
1923	724	2022-10-14 16:04:03	0	t	1	\N
1924	724	2022-10-14 16:04:03	1	f	2	\N
1925	724	2022-10-14 16:04:03	13	t	2	\N
1926	725	2022-10-14 16:26:04	0	t	1	\N
1927	725	2022-10-14 16:26:04	12	t	3	\N
1928	725	2022-10-14 16:26:04	13	t	2	\N
1929	725	2022-10-14 16:26:04	0	t	1	\N
1930	725	2022-10-14 16:26:04	13	t	2	\N
1931	725	2022-10-14 16:26:04	0	t	1	\N
1932	725	2022-10-14 16:26:04	0	t	1	\N
1933	725	2022-10-14 16:26:04	13	t	2	\N
1934	725	2022-10-14 16:26:04	13	t	2	\N
1935	725	2022-10-14 16:26:04	12	t	3	\N
1936	726	2022-10-14 16:52:36	13	t	2	\N
1937	726	2022-10-14 16:52:37	0	t	1	\N
1938	726	2022-10-14 16:52:37	0	t	1	\N
1939	726	2022-10-14 16:52:37	12	t	3	\N
1940	726	2022-10-14 16:52:37	12	t	3	\N
1941	726	2022-10-14 16:52:37	0	t	1	\N
1942	726	2022-10-14 16:52:37	13	t	2	\N
1943	726	2022-10-14 16:52:37	13	t	2	\N
1944	726	2022-10-14 16:52:37	12	t	3	\N
1945	726	2022-10-14 16:52:37	0	t	1	\N
1946	727	2022-10-14 16:53:19	1	t	11	\N
1947	727	2022-10-14 16:53:19	0	t	12	\N
1948	727	2022-10-14 16:53:19	12	t	10	\N
1949	727	2022-10-14 16:53:19	1	t	11	\N
1950	727	2022-10-14 16:53:19	1	t	11	\N
1951	727	2022-10-14 16:53:19	12	t	10	\N
1952	727	2022-10-14 16:53:19	0	t	12	\N
1953	727	2022-10-14 16:53:19	1	t	11	\N
1954	727	2022-10-14 16:53:19	12	f	12	\N
1955	727	2022-10-14 16:53:19	12	f	12	\N
1956	727	2022-10-14 16:53:19	0	t	12	\N
1957	727	2022-10-14 16:53:19	13	t	9	\N
1958	727	2022-10-14 16:53:19	0	t	8	\N
1959	727	2022-10-14 16:53:19	0	t	8	\N
1960	727	2022-10-14 16:53:19	13	t	9	\N
1961	727	2022-10-14 16:53:19	0	t	8	\N
1962	727	2022-10-14 16:53:19	0	t	8	\N
1963	730	2022-10-14 19:22:40	0	t	20	\N
1964	730	2022-10-14 19:22:40	1	f	19	\N
1965	730	2022-10-14 19:22:40	0	t	19	\N
1966	730	2022-10-14 19:22:40	1	t	22	\N
1967	730	2022-10-14 19:22:40	1	f	19	\N
1968	730	2022-10-14 19:22:40	0	t	19	\N
1969	730	2022-10-14 19:22:41	0	t	20	\N
1970	730	2022-10-14 19:22:41	1	f	19	\N
1971	730	2022-10-14 19:22:41	0	t	19	\N
1972	730	2022-10-14 19:22:41	2	t	21	\N
1973	730	2022-10-14 19:22:41	1	t	22	\N
1974	730	2022-10-14 19:22:41	1	t	22	\N
1975	730	2022-10-14 19:22:41	0	t	20	\N
1976	730	2022-10-14 19:22:41	0	t	20	\N
1977	730	2022-10-14 19:22:41	2	t	21	\N
1978	730	2022-10-14 19:22:41	2	t	21	\N
1979	730	2022-10-14 19:22:41	0	t	19	\N
1980	730	2022-10-14 19:22:41	0	t	20	\N
1981	730	2022-10-14 19:23:36	0	t	20	\N
1982	730	2022-10-14 19:23:36	1	f	19	\N
1983	730	2022-10-14 19:23:36	0	t	19	\N
1984	730	2022-10-14 19:23:36	1	t	22	\N
1985	730	2022-10-14 19:23:36	1	f	19	\N
1986	730	2022-10-14 19:23:36	0	t	19	\N
1987	730	2022-10-14 19:23:36	0	t	20	\N
1988	730	2022-10-14 19:23:36	1	f	19	\N
1989	730	2022-10-14 19:23:36	0	t	19	\N
1990	730	2022-10-14 19:23:36	2	t	21	\N
1991	730	2022-10-14 19:23:36	1	t	22	\N
1992	730	2022-10-14 19:23:36	1	t	22	\N
1993	730	2022-10-14 19:23:36	0	t	20	\N
1994	730	2022-10-14 19:23:36	0	t	20	\N
1995	730	2022-10-14 19:23:36	2	t	21	\N
1996	730	2022-10-14 19:23:36	2	t	21	\N
1997	730	2022-10-14 19:23:36	0	t	19	\N
1998	730	2022-10-14 19:23:36	0	t	20	\N
1999	739	2022-10-14 19:28:47	13	t	14	\N
2000	739	2022-10-14 19:28:47	0	t	17	\N
2001	739	2022-10-14 19:28:47	1	t	16	\N
2002	739	2022-10-14 19:28:47	0	t	13	\N
2003	739	2022-10-14 19:28:47	12	t	15	\N
2004	739	2022-10-14 19:28:47	2	t	18	\N
2005	739	2022-10-14 19:28:47	13	t	14	\N
2006	739	2022-10-14 19:28:47	1	t	16	\N
2007	739	2022-10-14 19:28:47	0	t	17	\N
2008	739	2022-10-14 19:28:47	0	t	13	\N
2009	739	2022-10-14 19:28:47	0	t	17	\N
2010	739	2022-10-14 19:28:47	13	t	14	\N
2011	739	2022-10-14 19:28:47	12	t	15	\N
2012	739	2022-10-14 19:28:47	2	t	18	\N
2013	739	2022-10-14 19:28:47	0	t	13	\N
2014	739	2022-10-14 19:28:47	2	t	18	\N
2015	739	2022-10-14 19:28:47	1	f	14	\N
2016	739	2022-10-14 19:28:47	1	f	14	\N
2017	739	2022-10-14 19:28:47	1	f	14	\N
2018	739	2022-10-14 19:28:47	1	f	14	\N
2019	739	2022-10-14 19:28:47	13	t	14	\N
2020	739	2022-10-14 19:28:47	12	t	15	\N
2021	739	2022-10-14 19:31:40	13	t	14	\N
2022	739	2022-10-14 19:31:40	0	t	17	\N
2023	739	2022-10-14 19:31:40	1	t	16	\N
2024	739	2022-10-14 19:31:40	0	t	13	\N
2025	739	2022-10-14 19:31:41	12	t	15	\N
2026	739	2022-10-14 19:31:41	2	t	18	\N
2027	739	2022-10-14 19:31:41	13	t	14	\N
2028	739	2022-10-14 19:31:41	1	t	16	\N
2029	739	2022-10-14 19:31:41	0	t	17	\N
2030	739	2022-10-14 19:31:41	0	t	13	\N
2031	739	2022-10-14 19:31:41	0	t	17	\N
2032	739	2022-10-14 19:31:41	13	t	14	\N
2033	739	2022-10-14 19:31:41	12	t	15	\N
2034	739	2022-10-14 19:31:41	2	t	18	\N
2035	739	2022-10-14 19:31:41	0	t	13	\N
2036	739	2022-10-14 19:31:41	2	t	18	\N
2037	739	2022-10-14 19:31:41	1	f	14	\N
2038	739	2022-10-14 19:31:41	1	f	14	\N
2039	739	2022-10-14 19:31:41	1	f	14	\N
2040	739	2022-10-14 19:31:41	1	f	14	\N
2041	739	2022-10-14 19:31:41	13	t	14	\N
2042	739	2022-10-14 19:31:41	12	t	15	\N
2043	739	2022-10-14 19:32:03	13	t	14	\N
2044	739	2022-10-14 19:32:03	0	t	17	\N
2045	739	2022-10-14 19:32:04	1	t	16	\N
2046	739	2022-10-14 19:32:04	0	t	13	\N
2047	739	2022-10-14 19:32:04	12	t	15	\N
2048	739	2022-10-14 19:32:04	2	t	18	\N
2049	739	2022-10-14 19:32:04	13	t	14	\N
2050	739	2022-10-14 19:32:04	1	t	16	\N
2051	739	2022-10-14 19:32:04	0	t	17	\N
2052	739	2022-10-14 19:32:04	0	t	13	\N
2053	739	2022-10-14 19:32:04	0	t	17	\N
2054	739	2022-10-14 19:32:04	13	t	14	\N
2055	739	2022-10-14 19:32:04	12	t	15	\N
2056	739	2022-10-14 19:32:04	2	t	18	\N
2057	739	2022-10-14 19:32:04	0	t	13	\N
2058	739	2022-10-14 19:32:04	2	t	18	\N
2059	739	2022-10-14 19:32:04	1	f	14	\N
2060	739	2022-10-14 19:32:04	1	f	14	\N
2061	739	2022-10-14 19:32:04	1	f	14	\N
2062	739	2022-10-14 19:32:04	1	f	14	\N
2063	739	2022-10-14 19:32:04	13	t	14	\N
2064	739	2022-10-14 19:32:04	12	t	15	\N
2065	739	2022-10-14 19:33:12	13	t	14	\N
2066	739	2022-10-14 19:33:12	0	t	17	\N
2067	739	2022-10-14 19:33:12	1	t	16	\N
2068	739	2022-10-14 19:33:12	0	t	13	\N
2069	739	2022-10-14 19:33:12	12	t	15	\N
2070	739	2022-10-14 19:33:12	2	t	18	\N
2071	739	2022-10-14 19:33:12	13	t	14	\N
2072	739	2022-10-14 19:33:12	1	t	16	\N
2073	739	2022-10-14 19:33:12	0	t	17	\N
2074	739	2022-10-14 19:33:13	0	t	13	\N
2075	739	2022-10-14 19:33:13	0	t	17	\N
2076	739	2022-10-14 19:33:13	13	t	14	\N
2077	739	2022-10-14 19:33:13	12	t	15	\N
2078	739	2022-10-14 19:33:13	2	t	18	\N
2079	739	2022-10-14 19:33:13	0	t	13	\N
2080	739	2022-10-14 19:33:13	2	t	18	\N
2081	739	2022-10-14 19:33:13	1	f	14	\N
2082	739	2022-10-14 19:33:13	1	f	14	\N
2083	739	2022-10-14 19:33:13	1	f	14	\N
2084	739	2022-10-14 19:33:13	1	f	14	\N
2085	739	2022-10-14 19:33:13	13	t	14	\N
2086	739	2022-10-14 19:33:13	12	t	15	\N
2087	739	2022-10-14 19:33:39	13	t	14	\N
2088	739	2022-10-14 19:33:40	0	t	17	\N
2089	739	2022-10-14 19:33:40	1	t	16	\N
2090	739	2022-10-14 19:33:40	0	t	13	\N
2091	739	2022-10-14 19:33:40	12	t	15	\N
2092	739	2022-10-14 19:33:40	2	t	18	\N
2093	739	2022-10-14 19:33:40	13	t	14	\N
2094	739	2022-10-14 19:33:40	1	t	16	\N
2095	739	2022-10-14 19:33:40	0	t	17	\N
2096	739	2022-10-14 19:33:40	0	t	13	\N
2097	739	2022-10-14 19:33:40	0	t	17	\N
2098	739	2022-10-14 19:33:40	13	t	14	\N
2099	739	2022-10-14 19:33:40	12	t	15	\N
2100	739	2022-10-14 19:33:40	2	t	18	\N
2101	739	2022-10-14 19:33:40	0	t	13	\N
2102	739	2022-10-14 19:33:40	2	t	18	\N
2103	739	2022-10-14 19:33:40	1	f	14	\N
2104	739	2022-10-14 19:33:40	1	f	14	\N
2105	739	2022-10-14 19:33:40	1	f	14	\N
2106	739	2022-10-14 19:33:40	1	f	14	\N
2107	739	2022-10-14 19:33:40	13	t	14	\N
2108	739	2022-10-14 19:33:40	12	t	15	\N
2109	739	2022-10-14 19:35:09	13	t	14	\N
2110	739	2022-10-14 19:35:09	0	t	17	\N
2111	739	2022-10-14 19:35:09	1	t	16	\N
2112	739	2022-10-14 19:35:09	0	t	13	\N
2113	739	2022-10-14 19:35:09	12	t	15	\N
2114	739	2022-10-14 19:35:09	2	t	18	\N
2115	739	2022-10-14 19:35:09	13	t	14	\N
2116	739	2022-10-14 19:35:09	1	t	16	\N
2117	739	2022-10-14 19:35:09	0	t	17	\N
2118	739	2022-10-14 19:35:09	0	t	13	\N
2119	739	2022-10-14 19:35:09	0	t	17	\N
2120	739	2022-10-14 19:35:09	13	t	14	\N
2121	739	2022-10-14 19:35:09	12	t	15	\N
2122	739	2022-10-14 19:35:10	2	t	18	\N
2123	739	2022-10-14 19:35:10	0	t	13	\N
2124	739	2022-10-14 19:35:10	2	t	18	\N
2125	739	2022-10-14 19:35:10	1	f	14	\N
2126	739	2022-10-14 19:35:10	1	f	14	\N
2127	739	2022-10-14 19:35:10	1	f	14	\N
2128	739	2022-10-14 19:35:10	1	f	14	\N
2129	739	2022-10-14 19:35:10	13	t	14	\N
2130	739	2022-10-14 19:35:10	12	t	15	\N
2131	739	2022-10-14 19:35:21	13	t	14	\N
2132	739	2022-10-14 19:35:21	0	t	17	\N
2133	739	2022-10-14 19:35:21	1	t	16	\N
2134	739	2022-10-14 19:35:21	0	t	13	\N
2135	739	2022-10-14 19:35:21	12	t	15	\N
2136	739	2022-10-14 19:35:21	2	t	18	\N
2137	739	2022-10-14 19:35:21	13	t	14	\N
2138	739	2022-10-14 19:35:21	1	t	16	\N
2139	739	2022-10-14 19:35:21	0	t	17	\N
2140	739	2022-10-14 19:35:21	0	t	13	\N
2141	739	2022-10-14 19:35:21	0	t	17	\N
2142	739	2022-10-14 19:35:21	13	t	14	\N
2143	739	2022-10-14 19:35:21	12	t	15	\N
2144	739	2022-10-14 19:35:21	2	t	18	\N
2145	739	2022-10-14 19:35:21	0	t	13	\N
2146	739	2022-10-14 19:35:21	2	t	18	\N
2147	739	2022-10-14 19:35:21	1	f	14	\N
2148	739	2022-10-14 19:35:21	1	f	14	\N
2149	739	2022-10-14 19:35:21	1	f	14	\N
2150	739	2022-10-14 19:35:21	1	f	14	\N
2151	739	2022-10-14 19:35:21	13	t	14	\N
2152	739	2022-10-14 19:35:22	12	t	15	\N
2153	739	2022-10-14 19:35:45	13	t	14	\N
2154	739	2022-10-14 19:35:45	0	t	17	\N
2155	739	2022-10-14 19:35:46	1	t	16	\N
2156	739	2022-10-14 19:35:46	0	t	13	\N
2157	739	2022-10-14 19:35:46	12	t	15	\N
2158	739	2022-10-14 19:35:46	2	t	18	\N
2159	739	2022-10-14 19:35:46	13	t	14	\N
2160	739	2022-10-14 19:35:46	1	t	16	\N
2161	739	2022-10-14 19:35:46	0	t	17	\N
2162	739	2022-10-14 19:35:46	0	t	13	\N
2163	739	2022-10-14 19:35:46	0	t	17	\N
2164	739	2022-10-14 19:35:46	13	t	14	\N
2165	739	2022-10-14 19:35:46	12	t	15	\N
2166	739	2022-10-14 19:35:46	2	t	18	\N
2167	739	2022-10-14 19:35:46	0	t	13	\N
2168	739	2022-10-14 19:35:46	2	t	18	\N
2169	739	2022-10-14 19:35:46	1	f	14	\N
2170	739	2022-10-14 19:35:46	1	f	14	\N
2171	739	2022-10-14 19:35:46	1	f	14	\N
2172	739	2022-10-14 19:35:46	1	f	14	\N
2173	739	2022-10-14 19:35:46	13	t	14	\N
2174	739	2022-10-14 19:35:46	12	t	15	\N
2175	739	2022-10-14 19:35:56	13	t	14	\N
2176	739	2022-10-14 19:35:56	0	t	17	\N
2177	739	2022-10-14 19:35:56	1	t	16	\N
2178	739	2022-10-14 19:35:56	0	t	13	\N
2179	739	2022-10-14 19:35:56	12	t	15	\N
2180	739	2022-10-14 19:35:56	2	t	18	\N
2181	739	2022-10-14 19:35:56	13	t	14	\N
2182	739	2022-10-14 19:35:56	1	t	16	\N
2183	739	2022-10-14 19:35:56	0	t	17	\N
2184	739	2022-10-14 19:35:56	0	t	13	\N
2185	739	2022-10-14 19:35:56	0	t	17	\N
2186	739	2022-10-14 19:35:56	13	t	14	\N
2187	739	2022-10-14 19:35:56	12	t	15	\N
2188	739	2022-10-14 19:35:56	2	t	18	\N
2189	739	2022-10-14 19:35:56	0	t	13	\N
2190	739	2022-10-14 19:35:56	2	t	18	\N
2191	739	2022-10-14 19:35:56	1	f	14	\N
2192	739	2022-10-14 19:35:56	1	f	14	\N
2193	739	2022-10-14 19:35:56	1	f	14	\N
2194	739	2022-10-14 19:35:56	1	f	14	\N
2195	739	2022-10-14 19:35:56	13	t	14	\N
2196	739	2022-10-14 19:35:56	12	t	15	\N
2197	740	2022-10-14 20:06:42	0	t	20	\N
2198	740	2022-10-14 20:06:42	2	t	21	\N
2199	740	2022-10-14 20:06:42	1	t	22	\N
2200	740	2022-10-14 20:06:42	0	t	20	\N
2201	740	2022-10-14 20:06:42	2	t	21	\N
2202	740	2022-10-14 20:06:42	0	t	19	\N
2203	740	2022-10-14 20:06:42	2	t	21	\N
2204	740	2022-10-14 20:06:42	1	t	22	\N
2205	740	2022-10-14 20:06:42	0	t	19	\N
2206	740	2022-10-14 20:06:42	0	t	20	\N
2207	740	2022-10-14 20:06:42	0	t	20	\N
2208	740	2022-10-14 20:06:42	1	t	22	\N
2209	740	2022-10-14 20:06:42	2	t	21	\N
2210	740	2022-10-14 20:06:42	1	t	22	\N
2211	740	2022-10-14 20:06:42	0	t	19	\N
2212	743	2022-10-14 20:24:55	13	t	6	\N
2213	743	2022-10-14 20:24:55	0	t	4	\N
2214	743	2022-10-14 20:24:55	13	t	5	\N
2215	743	2022-10-14 20:24:55	1	t	7	\N
2216	743	2022-10-14 20:24:55	0	t	4	\N
2217	743	2022-10-14 20:24:55	13	t	5	\N
2218	743	2022-10-14 20:24:55	0	t	4	\N
2219	743	2022-10-14 20:24:55	1	t	7	\N
2220	743	2022-10-14 20:24:55	13	t	6	\N
2221	743	2022-10-14 20:24:55	1	t	7	\N
2222	743	2022-10-14 20:24:55	13	t	5	\N
2223	743	2022-10-14 20:24:55	1	t	7	\N
2224	744	2022-10-14 20:25:32	12	t	3	\N
2225	744	2022-10-14 20:25:33	0	t	1	\N
2226	744	2022-10-14 20:25:33	13	t	2	\N
2227	744	2022-10-14 20:25:33	12	t	3	\N
2228	744	2022-10-14 20:25:33	13	t	2	\N
2229	744	2022-10-14 20:25:33	12	t	3	\N
2230	744	2022-10-14 20:25:33	13	t	2	\N
2231	744	2022-10-14 20:25:33	12	t	3	\N
2232	744	2022-10-14 20:25:33	13	t	2	\N
2233	744	2022-10-14 20:25:33	12	t	3	\N
2234	745	2022-10-14 20:30:30	0	t	12	\N
2235	745	2022-10-14 20:30:30	1	t	11	\N
2236	745	2022-10-14 20:30:30	12	t	10	\N
2237	745	2022-10-14 20:30:30	13	t	9	\N
2238	745	2022-10-14 20:30:30	1	t	11	\N
2239	745	2022-10-14 20:30:30	0	t	8	\N
2240	745	2022-10-14 20:30:30	0	t	12	\N
2241	745	2022-10-14 20:30:30	1	f	8	\N
2242	745	2022-10-14 20:30:30	1	f	8	\N
2243	745	2022-10-14 20:30:30	0	t	8	\N
2244	745	2022-10-14 20:30:30	2	f	12	\N
2245	745	2022-10-14 20:30:30	2	f	12	\N
2246	745	2022-10-14 20:30:30	23	f	12	\N
2247	745	2022-10-14 20:30:30	0	t	12	\N
2248	745	2022-10-14 20:30:30	1	f	8	\N
2249	745	2022-10-14 20:30:30	2	f	8	\N
2250	745	2022-10-14 20:30:30	3	f	8	\N
2251	745	2022-10-14 20:30:30	12	f	8	\N
2252	745	2022-10-14 20:30:31	0	t	8	\N
2253	745	2022-10-14 20:30:31	1	t	11	\N
2254	745	2022-10-14 20:30:31	12	t	10	\N
2255	745	2022-10-14 20:30:31	13	t	9	\N
2256	745	2022-10-14 20:30:31	12	t	10	\N
2257	745	2022-10-14 20:30:31	1	t	11	\N
2258	747	2022-10-14 21:08:08	0	t	12	\N
2259	747	2022-10-14 21:08:08	13	t	9	\N
2260	747	2022-10-14 21:08:08	0	t	8	\N
2261	747	2022-10-14 21:08:08	0	t	12	\N
2262	747	2022-10-14 21:08:08	13	t	9	\N
2263	747	2022-10-14 21:08:08	12	t	10	\N
2264	747	2022-10-14 21:08:08	13	t	9	\N
2265	747	2022-10-14 21:08:08	1	t	11	\N
2266	747	2022-10-14 21:08:08	12	f	12	\N
2267	747	2022-10-14 21:08:08	0	t	12	\N
2268	747	2022-10-14 21:08:08	1	t	11	\N
2269	747	2022-10-14 21:08:08	12	t	10	\N
2270	747	2022-10-14 21:08:08	0	t	12	\N
2271	747	2022-10-14 21:08:08	0	t	8	\N
2272	747	2022-10-14 21:08:08	12	t	10	\N
2273	747	2022-10-14 21:08:08	0	t	12	\N
2274	750	2022-10-17 16:34:29	1	f	41	\N
2275	750	2022-10-17 16:34:30	0	t	41	\N
2276	750	2022-10-17 16:34:30	12	t	39	\N
2277	750	2022-10-17 16:34:30	13	t	38	\N
2278	750	2022-10-17 16:34:30	12	t	39	\N
2279	750	2022-10-17 16:34:30	12	t	44	\N
2280	750	2022-10-17 16:34:30	0	t	41	\N
2281	750	2022-10-17 16:34:30	2	t	40	\N
2282	750	2022-10-17 16:34:30	12	t	39	\N
2283	750	2022-10-17 16:34:30	2	t	40	\N
2284	750	2022-10-17 16:34:30	12	t	44	\N
2285	750	2022-10-17 16:34:30	13	t	38	\N
2286	750	2022-10-17 16:34:30	0	t	41	\N
2287	750	2022-10-17 16:34:30	2	t	40	\N
2288	750	2022-10-17 16:34:30	0	t	41	\N
2289	750	2022-10-17 16:34:30	12	t	42	\N
2290	750	2022-10-17 16:34:30	12	t	44	\N
2291	750	2022-10-17 16:34:30	2	t	43	\N
2292	750	2022-10-17 16:34:30	12	t	42	\N
2293	750	2022-10-17 16:34:30	2	t	40	\N
2294	750	2022-10-17 16:34:30	0	t	41	\N
2295	750	2022-10-17 16:34:30	13	t	38	\N
2296	750	2022-10-17 16:34:30	2	t	40	\N
2297	750	2022-10-17 16:34:30	2	t	43	\N
2298	750	2022-10-17 16:34:30	2	t	40	\N
2299	751	2022-10-17 16:38:13	2	t	18	\N
2300	751	2022-10-17 16:38:14	1	t	16	\N
2301	751	2022-10-17 16:38:14	0	t	13	\N
2302	751	2022-10-17 16:38:14	1	t	16	\N
2303	751	2022-10-17 16:38:14	2	t	18	\N
2304	751	2022-10-17 16:38:14	0	t	13	\N
2305	751	2022-10-17 16:38:14	12	t	15	\N
2306	751	2022-10-17 16:38:14	0	t	17	\N
2307	751	2022-10-17 16:38:14	2	t	18	\N
2308	751	2022-10-17 16:38:14	0	t	17	\N
2309	751	2022-10-17 16:38:14	13	t	14	\N
2310	751	2022-10-17 16:38:14	0	t	17	\N
2311	751	2022-10-17 16:38:14	1	t	16	\N
2312	751	2022-10-17 16:38:14	0	t	13	\N
2313	751	2022-10-17 16:38:14	0	t	17	\N
2314	751	2022-10-17 16:38:14	1	t	16	\N
2315	751	2022-10-17 16:38:14	12	t	15	\N
2316	751	2022-10-17 16:38:14	13	t	14	\N
2317	753	2022-10-17 16:49:37	12	t	29	\N
2318	753	2022-10-17 16:49:37	2	t	27	\N
2319	753	2022-10-17 16:49:37	2	t	24	\N
2320	753	2022-10-17 16:49:37	12	t	29	\N
2321	753	2022-10-17 16:49:37	2	t	24	\N
2322	753	2022-10-17 16:49:37	2	t	27	\N
2323	753	2022-10-17 16:49:37	12	t	29	\N
2324	753	2022-10-17 16:49:37	1	t	25	\N
2325	753	2022-10-17 16:49:37	1	t	28	\N
2326	753	2022-10-17 16:49:37	0	t	23	\N
2327	753	2022-10-17 16:49:37	2	t	27	\N
2328	753	2022-10-17 16:49:37	1	t	28	\N
2329	753	2022-10-17 16:49:37	12	f	25	\N
2330	753	2022-10-17 16:49:37	1	t	25	\N
2331	753	2022-10-17 16:49:37	2	t	24	\N
2332	753	2022-10-17 16:49:37	0	t	30	\N
2333	753	2022-10-17 16:49:37	0	t	26	\N
2334	753	2022-10-17 16:49:37	12	t	29	\N
2335	753	2022-10-17 16:49:37	1	f	30	\N
2336	753	2022-10-17 16:49:37	0	t	30	\N
2337	753	2022-10-17 16:49:37	2	t	27	\N
2338	753	2022-10-17 16:49:37	2	t	24	\N
2339	754	2022-10-17 16:51:32	1	f	34	\N
2340	754	2022-10-17 16:51:32	23	t	34	\N
2341	754	2022-10-17 16:51:32	1	t	31	\N
2342	754	2022-10-17 16:51:32	0	t	36	\N
2343	754	2022-10-17 16:51:32	1	t	31	\N
2344	754	2022-10-17 16:51:32	1	t	35	\N
2345	754	2022-10-17 16:51:32	1	t	31	\N
2346	754	2022-10-17 16:51:32	13	t	33	\N
2347	754	2022-10-17 16:51:32	1	t	31	\N
2348	754	2022-10-17 16:51:32	0	t	36	\N
2349	754	2022-10-17 16:51:32	1	t	35	\N
2350	754	2022-10-17 16:51:32	1	t	31	\N
2351	754	2022-10-17 16:51:32	0	t	32	\N
2352	754	2022-10-17 16:51:32	0	t	36	\N
2353	754	2022-10-17 16:51:32	1	t	31	\N
2354	754	2022-10-17 16:51:32	12	t	37	\N
2355	754	2022-10-17 16:51:32	1	t	31	\N
2356	754	2022-10-17 16:51:32	23	t	34	\N
2357	754	2022-10-17 16:51:32	0	t	36	\N
2358	754	2022-10-17 16:51:32	23	t	34	\N
2359	754	2022-10-17 16:51:32	12	t	37	\N
2360	754	2022-10-17 16:51:32	23	t	34	\N
2361	754	2022-10-17 16:51:32	12	t	37	\N
2362	754	2022-10-17 16:51:32	1	t	31	\N
2363	754	2022-10-17 16:51:33	0	t	36	\N
2364	754	2022-10-17 16:51:33	12	t	37	\N
2365	754	2022-10-17 16:51:33	0	t	36	\N
2366	754	2022-10-17 16:51:33	12	t	37	\N
2367	754	2022-10-17 16:51:33	23	t	34	\N
2368	754	2022-10-17 16:51:33	1	t	35	\N
2369	754	2022-10-17 16:51:33	12	t	37	\N
2370	755	2022-10-17 16:53:11	12	t	10	\N
2371	755	2022-10-17 16:53:11	13	t	9	\N
2372	755	2022-10-17 16:53:11	12	t	10	\N
2373	755	2022-10-17 16:53:11	13	t	9	\N
2374	755	2022-10-17 16:53:12	0	t	12	\N
2375	755	2022-10-17 16:53:12	0	t	8	\N
2376	755	2022-10-17 16:53:12	0	t	12	\N
2377	755	2022-10-17 16:53:12	13	t	9	\N
2378	755	2022-10-17 16:53:12	12	t	10	\N
2379	755	2022-10-17 16:53:12	0	t	8	\N
2380	755	2022-10-17 16:53:12	1	t	11	\N
2381	755	2022-10-17 16:53:12	0	t	12	\N
2382	755	2022-10-17 16:53:12	1	t	11	\N
2383	755	2022-10-17 16:53:12	12	t	10	\N
2384	755	2022-10-17 16:53:12	13	t	9	\N
2385	756	2022-10-17 16:54:31	1	t	25	\N
2386	756	2022-10-17 16:54:31	2	t	27	\N
2387	756	2022-10-17 16:54:31	1	t	28	\N
2388	756	2022-10-17 16:54:31	0	t	26	\N
2389	756	2022-10-17 16:54:31	1	t	28	\N
2390	756	2022-10-17 16:54:31	0	t	23	\N
2391	756	2022-10-17 16:54:31	1	t	25	\N
2392	756	2022-10-17 16:54:31	0	t	23	\N
2393	756	2022-10-17 16:54:31	2	t	24	\N
2394	756	2022-10-17 16:54:31	0	t	23	\N
2395	756	2022-10-17 16:54:31	12	t	29	\N
2396	756	2022-10-17 16:54:31	2	t	24	\N
2397	756	2022-10-17 16:54:31	1	t	25	\N
2398	756	2022-10-17 16:54:31	0	t	26	\N
2399	756	2022-10-17 16:54:31	2	t	24	\N
2400	756	2022-10-17 16:54:31	2	t	27	\N
2401	756	2022-10-17 16:54:31	12	t	29	\N
2402	756	2022-10-17 16:54:31	0	t	30	\N
2403	756	2022-10-17 16:54:32	12	t	29	\N
2404	756	2022-10-17 16:54:32	1	t	28	\N
2405	757	2022-10-17 19:56:07	1	t	22	\N
2406	757	2022-10-17 19:56:07	0	t	20	\N
2407	757	2022-10-17 19:56:07	0	t	19	\N
2408	757	2022-10-17 19:56:07	2	t	21	\N
2409	757	2022-10-17 19:56:07	0	t	20	\N
2410	757	2022-10-17 19:56:07	1	t	22	\N
2411	757	2022-10-17 19:56:07	0	t	19	\N
2412	757	2022-10-17 19:56:07	2	t	21	\N
2413	757	2022-10-17 19:56:07	0	t	20	\N
2414	757	2022-10-17 19:56:07	0	t	19	\N
2415	757	2022-10-17 19:56:07	1	t	22	\N
2416	757	2022-10-17 19:56:07	0	t	19	\N
2417	757	2022-10-17 19:56:07	1	t	22	\N
2418	757	2022-10-17 19:56:07	0	t	20	\N
2419	757	2022-10-17 19:56:07	1	t	22	\N
2420	758	2022-10-17 19:58:30	13	t	14	\N
2421	758	2022-10-17 19:58:30	0	t	13	\N
2422	758	2022-10-17 19:58:30	13	t	14	\N
2423	758	2022-10-17 19:58:30	12	t	15	\N
2424	758	2022-10-17 19:58:30	2	t	18	\N
2425	758	2022-10-17 19:58:30	0	t	17	\N
2426	758	2022-10-17 19:58:30	13	t	14	\N
2427	758	2022-10-17 19:58:30	1	t	16	\N
2428	758	2022-10-17 19:58:30	13	t	14	\N
2429	758	2022-10-17 19:58:30	0	t	17	\N
2430	758	2022-10-17 19:58:30	0	t	13	\N
2431	758	2022-10-17 19:58:30	2	t	18	\N
2432	758	2022-10-17 19:58:30	0	f	15	\N
2433	758	2022-10-17 19:58:30	12	t	15	\N
2434	758	2022-10-17 19:58:30	0	t	17	\N
2435	758	2022-10-17 19:58:30	2	t	18	\N
2436	758	2022-10-17 19:58:30	0	t	13	\N
2437	758	2022-10-17 19:58:30	13	t	14	\N
2438	758	2022-10-17 19:58:30	12	t	15	\N
2439	759	2022-10-17 20:00:22	0	t	23	\N
2440	759	2022-10-17 20:00:23	2	t	24	\N
2441	759	2022-10-17 20:00:23	1	t	28	\N
2442	759	2022-10-17 20:00:23	2	t	24	\N
2443	759	2022-10-17 20:00:23	2	t	27	\N
2444	759	2022-10-17 20:00:23	1	t	25	\N
2445	759	2022-10-17 20:00:23	2	t	27	\N
2446	759	2022-10-17 20:00:23	0	t	26	\N
2447	759	2022-10-17 20:00:23	0	t	23	\N
2448	759	2022-10-17 20:00:23	0	t	26	\N
2449	759	2022-10-17 20:00:23	2	t	24	\N
2450	759	2022-10-17 20:00:23	1	f	30	\N
2451	759	2022-10-17 20:00:23	0	t	30	\N
2452	759	2022-10-17 20:00:23	2	t	27	\N
2453	759	2022-10-17 20:00:23	2	t	24	\N
2454	759	2022-10-17 20:00:23	1	t	25	\N
2455	759	2022-10-17 20:00:23	2	t	24	\N
2456	759	2022-10-17 20:00:23	12	t	29	\N
2457	759	2022-10-17 20:00:23	0	t	23	\N
2458	759	2022-10-17 20:00:23	2	t	24	\N
2459	759	2022-10-17 20:00:23	2	t	27	\N
2460	760	2022-10-17 20:11:04	0	t	1	\N
2461	760	2022-10-17 20:11:04	12	t	3	\N
2462	760	2022-10-17 20:11:04	13	t	2	\N
2463	760	2022-10-17 20:11:04	12	t	3	\N
2464	760	2022-10-17 20:11:04	13	t	2	\N
2465	760	2022-10-17 20:11:04	0	t	1	\N
2466	760	2022-10-17 20:11:04	12	t	3	\N
2467	760	2022-10-17 20:11:04	0	t	1	\N
2468	760	2022-10-17 20:11:04	12	t	3	\N
2469	760	2022-10-17 20:11:04	0	t	1	\N
2470	761	2022-10-17 20:13:16	13	t	5	\N
2471	761	2022-10-17 20:13:17	1	t	7	\N
2472	761	2022-10-17 20:13:17	0	t	4	\N
2473	761	2022-10-17 20:13:17	13	t	6	\N
2474	761	2022-10-17 20:13:17	0	t	4	\N
2475	761	2022-10-17 20:13:17	13	t	5	\N
2476	761	2022-10-17 20:13:17	0	t	4	\N
2477	761	2022-10-17 20:13:17	13	t	6	\N
2478	761	2022-10-17 20:13:17	0	t	4	\N
2479	761	2022-10-17 20:13:17	13	t	5	\N
2480	761	2022-10-17 20:13:17	1	t	7	\N
2481	761	2022-10-17 20:13:17	13	t	6	\N
2482	762	2022-10-18 16:09:45	1	t	28	\N
2483	762	2022-10-18 16:09:45	0	t	30	\N
2484	762	2022-10-18 16:09:45	1	t	28	\N
2485	762	2022-10-18 16:09:45	0	t	30	\N
2486	762	2022-10-18 16:09:45	1	f	26	\N
2487	762	2022-10-18 16:09:45	0	t	26	\N
2488	762	2022-10-18 16:09:45	0	t	23	\N
2489	762	2022-10-18 16:09:45	0	t	30	\N
2490	762	2022-10-18 16:09:45	0	t	26	\N
2491	762	2022-10-18 16:09:45	2	t	27	\N
2492	762	2022-10-18 16:09:45	0	t	23	\N
2493	762	2022-10-18 16:09:46	2	t	27	\N
2494	762	2022-10-18 16:09:46	1	t	28	\N
2495	762	2022-10-18 16:09:46	0	t	23	\N
2496	762	2022-10-18 16:09:46	12	t	29	\N
2497	762	2022-10-18 16:09:46	2	t	24	\N
2498	762	2022-10-18 16:09:46	1	t	25	\N
2499	762	2022-10-18 16:09:46	0	t	30	\N
2500	762	2022-10-18 16:09:46	2	t	27	\N
2501	762	2022-10-18 16:09:46	1	t	25	\N
2502	762	2022-10-18 16:09:46	0	t	26	\N
2503	764	2022-10-18 18:22:15	1	t	11	\N
2504	764	2022-10-18 18:22:15	12	t	10	\N
2505	764	2022-10-18 18:22:15	0	t	8	\N
2506	764	2022-10-18 18:22:15	0	t	12	\N
2507	764	2022-10-18 18:22:15	13	t	9	\N
2508	764	2022-10-18 18:22:15	1	t	11	\N
2509	764	2022-10-18 18:22:15	0	t	8	\N
2510	764	2022-10-18 18:22:15	1	t	11	\N
2511	764	2022-10-18 18:22:15	0	t	12	\N
2512	764	2022-10-18 18:22:15	1	t	11	\N
2513	764	2022-10-18 18:22:15	0	t	8	\N
2514	764	2022-10-18 18:22:15	1	t	11	\N
2515	764	2022-10-18 18:22:15	12	t	10	\N
2516	764	2022-10-18 18:22:15	1	t	11	\N
2517	764	2022-10-18 18:22:15	0	t	12	\N
2518	765	2022-10-18 19:12:55	2	t	21	\N
2519	765	2022-10-18 19:12:55	0	t	19	\N
2520	765	2022-10-18 19:12:55	12	f	20	\N
2521	765	2022-10-18 19:12:55	0	t	20	\N
2522	765	2022-10-18 19:12:55	2	t	21	\N
2523	765	2022-10-18 19:12:55	1	t	22	\N
2524	765	2022-10-18 19:12:55	2	f	19	\N
2525	765	2022-10-18 19:12:55	0	t	19	\N
2526	765	2022-10-18 19:12:55	12	f	22	\N
2527	765	2022-10-18 19:12:55	1	t	22	\N
2528	765	2022-10-18 19:12:55	0	t	19	\N
2529	765	2022-10-18 19:12:55	1	t	22	\N
2530	765	2022-10-18 19:12:55	2	t	21	\N
2531	765	2022-10-18 19:12:55	0	t	20	\N
2532	765	2022-10-18 19:12:55	0	f	22	\N
2533	765	2022-10-18 19:12:55	0	f	22	\N
2534	765	2022-10-18 19:12:56	0	f	22	\N
2535	765	2022-10-18 19:12:56	0	f	22	\N
2536	765	2022-10-18 19:12:56	0	f	22	\N
2537	765	2022-10-18 19:12:56	2	f	22	\N
2538	765	2022-10-18 19:12:56	1	t	22	\N
2539	765	2022-10-18 19:12:56	0	t	20	\N
2540	765	2022-10-18 19:12:56	0	t	19	\N
2541	765	2022-10-18 19:12:56	0	t	20	\N
2542	766	2022-10-18 19:25:33	0	t	1	\N
2543	766	2022-10-18 19:25:34	12	t	3	\N
2544	766	2022-10-18 19:25:34	13	t	2	\N
2545	766	2022-10-18 19:25:34	0	t	1	\N
2546	766	2022-10-18 19:25:34	13	t	2	\N
2547	766	2022-10-18 19:25:34	12	t	3	\N
2548	766	2022-10-18 19:25:34	0	t	1	\N
2549	766	2022-10-18 19:25:34	13	t	2	\N
2550	766	2022-10-18 19:25:34	12	t	3	\N
2551	766	2022-10-18 19:25:34	13	t	2	\N
2552	767	2022-10-18 19:26:54	2	t	27	\N
2553	767	2022-10-18 19:26:55	1	t	25	\N
2554	767	2022-10-18 19:26:55	2	t	27	\N
2555	767	2022-10-18 19:26:55	12	t	29	\N
2556	767	2022-10-18 19:26:55	0	t	26	\N
2557	767	2022-10-18 19:26:55	0	t	23	\N
2558	767	2022-10-18 19:26:55	0	t	26	\N
2559	767	2022-10-18 19:26:55	0	t	30	\N
2560	767	2022-10-18 19:26:55	0	t	26	\N
2561	767	2022-10-18 19:26:55	1	t	25	\N
2562	767	2022-10-18 19:26:55	2	t	24	\N
2563	767	2022-10-18 19:26:55	12	t	29	\N
2564	767	2022-10-18 19:26:55	2	t	27	\N
2565	767	2022-10-18 19:26:55	0	t	23	\N
2566	767	2022-10-18 19:26:55	0	f	24	\N
2567	767	2022-10-18 19:26:55	2	t	24	\N
2568	767	2022-10-18 19:26:55	12	t	29	\N
2569	767	2022-10-18 19:26:55	2	t	24	\N
2570	767	2022-10-18 19:26:55	2	t	27	\N
2571	767	2022-10-18 19:26:55	1	t	25	\N
2572	767	2022-10-18 19:26:55	12	t	29	\N
2573	768	2022-10-19 13:57:21	13	t	5	\N
2574	768	2022-10-19 13:57:21	0	t	4	\N
2575	768	2022-10-19 13:57:21	2	f	7	\N
2576	768	2022-10-19 13:57:21	1	t	7	\N
2577	768	2022-10-19 13:57:21	0	t	4	\N
2578	768	2022-10-19 13:57:21	1	t	7	\N
2579	768	2022-10-19 13:57:21	13	t	6	\N
2580	768	2022-10-19 13:57:21	0	f	7	\N
2581	768	2022-10-19 13:57:21	1	t	7	\N
2582	768	2022-10-19 13:57:21	13	f	4	\N
2583	768	2022-10-19 13:57:21	0	t	4	\N
2584	768	2022-10-19 13:57:21	13	t	5	\N
2585	768	2022-10-19 13:57:21	0	t	4	\N
2586	768	2022-10-19 13:57:21	13	t	6	\N
2587	768	2022-10-19 13:57:21	1	t	7	\N
2588	769	2022-10-19 13:58:51	13	t	6	\N
2589	769	2022-10-19 13:58:51	1	t	7	\N
2590	769	2022-10-19 13:58:51	12	f	6	\N
2591	769	2022-10-19 13:58:51	12	f	6	\N
2592	769	2022-10-19 13:58:51	12	f	6	\N
2593	769	2022-10-19 13:58:51	13	t	6	\N
2594	769	2022-10-19 13:58:51	1	t	7	\N
2595	769	2022-10-19 13:58:51	13	t	6	\N
2596	769	2022-10-19 13:58:51	0	t	4	\N
2597	769	2022-10-19 13:58:51	13	t	6	\N
2598	769	2022-10-19 13:58:51	1	t	7	\N
2599	769	2022-10-19 13:58:51	13	t	6	\N
2600	769	2022-10-19 13:58:51	0	t	4	\N
2601	769	2022-10-19 13:58:51	13	t	6	\N
2602	769	2022-10-19 13:58:51	0	t	4	\N
2603	770	2022-10-19 13:59:40	0	f	7	\N
2604	770	2022-10-19 13:59:40	0	f	7	\N
2605	770	2022-10-19 13:59:40	0	f	7	\N
2606	770	2022-10-19 13:59:40	0	f	7	\N
2607	770	2022-10-19 13:59:40	0	f	7	\N
2608	770	2022-10-19 13:59:40	1	t	7	\N
2609	770	2022-10-19 13:59:40	13	t	6	\N
2610	770	2022-10-19 13:59:40	1	t	7	\N
2611	770	2022-10-19 13:59:40	13	t	5	\N
2612	770	2022-10-19 13:59:40	1	t	7	\N
2613	770	2022-10-19 13:59:40	0	t	4	\N
2614	770	2022-10-19 13:59:40	1	t	7	\N
2615	770	2022-10-19 13:59:40	0	t	4	\N
2616	770	2022-10-19 13:59:40	13	t	6	\N
2617	770	2022-10-19 13:59:40	0	t	4	\N
2618	770	2022-10-19 13:59:40	13	t	5	\N
2619	770	2022-10-19 13:59:40	0	t	4	\N
2620	771	2022-10-19 14:02:20	12	t	3	\N
2621	771	2022-10-19 14:02:20	13	t	2	\N
2622	771	2022-10-19 14:02:20	1	f	3	\N
2623	771	2022-10-19 14:02:20	12	t	3	\N
2624	771	2022-10-19 14:02:20	13	f	1	\N
2625	771	2022-10-19 14:02:20	0	t	1	\N
2626	771	2022-10-19 14:02:20	13	t	2	\N
2627	771	2022-10-19 14:02:20	0	t	1	\N
2628	771	2022-10-19 14:02:20	12	t	3	\N
2629	771	2022-10-19 14:02:20	13	t	2	\N
2630	771	2022-10-19 14:02:20	2	f	1	\N
2631	771	2022-10-19 14:02:20	0	t	1	\N
2632	771	2022-10-19 14:02:20	13	t	2	\N
2633	772	2022-10-19 15:13:46	12	t	15	\N
2634	772	2022-10-19 15:13:47	0	t	17	\N
2635	772	2022-10-19 15:13:47	2	t	18	\N
2636	772	2022-10-19 15:13:47	0	t	17	\N
2637	772	2022-10-19 15:13:47	0	t	13	\N
2638	772	2022-10-19 15:13:47	13	t	14	\N
2639	772	2022-10-19 15:13:47	0	t	13	\N
2640	772	2022-10-19 15:13:47	0	t	17	\N
2641	772	2022-10-19 15:13:47	0	t	13	\N
2642	772	2022-10-19 15:13:47	12	t	15	\N
2643	772	2022-10-19 15:13:47	0	t	17	\N
2644	772	2022-10-19 15:13:47	13	t	14	\N
2645	772	2022-10-19 15:13:47	2	t	18	\N
2646	772	2022-10-19 15:13:47	1	f	15	\N
2647	772	2022-10-19 15:13:47	1	f	15	\N
2648	772	2022-10-19 15:13:47	12	t	15	\N
2649	772	2022-10-19 15:13:47	2	t	18	\N
2650	772	2022-10-19 15:13:47	0	t	13	\N
2651	772	2022-10-19 15:13:47	1	t	16	\N
2652	772	2022-10-19 15:13:47	0	t	17	\N
2653	773	2022-10-19 15:16:59	0	t	1	\N
2654	773	2022-10-19 15:16:59	13	t	2	\N
2655	773	2022-10-19 15:16:59	0	t	1	\N
2656	773	2022-10-19 15:16:59	13	t	2	\N
2657	773	2022-10-19 15:16:59	12	t	3	\N
2658	773	2022-10-19 15:16:59	0	t	1	\N
2659	773	2022-10-19 15:16:59	13	t	2	\N
2660	773	2022-10-19 15:16:59	12	t	3	\N
2661	773	2022-10-19 15:16:59	0	t	1	\N
2662	773	2022-10-19 15:16:59	13	t	2	\N
2663	774	2022-10-19 15:17:46	1	t	7	\N
2664	774	2022-10-19 15:17:46	13	t	5	\N
2665	774	2022-10-19 15:17:46	1	t	7	\N
2666	774	2022-10-19 15:17:46	0	t	4	\N
2667	774	2022-10-19 15:17:46	1	t	7	\N
2668	774	2022-10-19 15:17:46	0	f	6	\N
2669	774	2022-10-19 15:17:46	13	t	6	\N
2670	774	2022-10-19 15:17:46	1	t	7	\N
2671	774	2022-10-19 15:17:46	13	t	5	\N
2672	774	2022-10-19 15:17:46	0	f	7	\N
2673	774	2022-10-19 15:17:46	1	t	7	\N
2674	774	2022-10-19 15:17:46	13	t	5	\N
2675	774	2022-10-19 15:17:46	0	t	4	\N
2676	774	2022-10-19 15:17:46	1	t	7	\N
2677	775	2022-10-19 15:19:14	0	t	12	\N
2678	775	2022-10-19 15:19:14	13	t	9	\N
2679	775	2022-10-19 15:19:14	0	t	12	\N
2680	775	2022-10-19 15:19:14	1	f	10	\N
2681	775	2022-10-19 15:19:14	12	t	10	\N
2682	775	2022-10-19 15:19:14	1	t	11	\N
2683	775	2022-10-19 15:19:15	13	t	9	\N
2684	775	2022-10-19 15:19:15	0	t	12	\N
2685	775	2022-10-19 15:19:15	12	t	10	\N
2686	775	2022-10-19 15:19:15	0	t	12	\N
2687	775	2022-10-19 15:19:15	13	t	9	\N
2688	775	2022-10-19 15:19:15	1	t	11	\N
2689	775	2022-10-19 15:19:15	0	t	8	\N
2690	775	2022-10-19 15:19:15	1	t	11	\N
2691	775	2022-10-19 15:19:15	0	t	8	\N
2692	775	2022-10-19 15:19:15	13	t	9	\N
2693	776	2022-10-19 15:20:16	1	t	7	\N
2694	776	2022-10-19 15:20:16	13	t	5	\N
2695	776	2022-10-19 15:20:16	1	t	7	\N
2696	776	2022-10-19 15:20:16	13	t	6	\N
2697	776	2022-10-19 15:20:16	1	t	7	\N
2698	776	2022-10-19 15:20:16	13	t	6	\N
2699	776	2022-10-19 15:20:16	0	t	4	\N
2700	776	2022-10-19 15:20:16	1	t	7	\N
2701	776	2022-10-19 15:20:16	13	t	6	\N
2702	776	2022-10-19 15:20:16	1	t	7	\N
2703	776	2022-10-19 15:20:16	13	t	5	\N
2704	776	2022-10-19 15:20:16	1	t	7	\N
2705	777	2022-10-19 15:21:15	0	t	13	\N
2706	777	2022-10-19 15:21:15	13	t	14	\N
2707	777	2022-10-19 15:21:15	1	t	16	\N
2708	777	2022-10-19 15:21:15	12	t	15	\N
2709	777	2022-10-19 15:21:15	2	t	18	\N
2710	777	2022-10-19 15:21:15	0	t	17	\N
2711	777	2022-10-19 15:21:15	2	t	18	\N
2712	777	2022-10-19 15:21:15	13	t	14	\N
2713	777	2022-10-19 15:21:15	0	t	13	\N
2714	777	2022-10-19 15:21:15	1	f	15	\N
2715	777	2022-10-19 15:21:15	12	t	15	\N
2716	777	2022-10-19 15:21:15	0	t	17	\N
2717	777	2022-10-19 15:21:15	2	t	18	\N
2718	777	2022-10-19 15:21:16	1	t	16	\N
2719	777	2022-10-19 15:21:16	0	t	17	\N
2720	777	2022-10-19 15:21:16	13	t	14	\N
2721	777	2022-10-19 15:21:16	0	t	17	\N
2722	777	2022-10-19 15:21:16	0	t	13	\N
2723	777	2022-10-19 15:21:16	12	f	17	\N
2724	777	2022-10-19 15:21:16	12	f	17	\N
2725	777	2022-10-19 15:21:16	12	f	17	\N
2726	777	2022-10-19 15:21:16	0	t	17	\N
2727	778	2022-10-19 16:32:57	1	t	11	\N
2728	778	2022-10-19 16:32:57	1	f	12	\N
2729	778	2022-10-19 16:32:57	0	t	12	\N
2730	778	2022-10-19 16:32:57	0	t	8	\N
2731	778	2022-10-19 16:32:57	13	t	9	\N
2732	778	2022-10-19 16:32:57	12	t	10	\N
2733	778	2022-10-19 16:32:57	1	t	11	\N
2734	778	2022-10-19 16:32:57	12	t	10	\N
2735	778	2022-10-19 16:32:57	1	t	11	\N
2736	778	2022-10-19 16:32:57	0	t	8	\N
2737	778	2022-10-19 16:32:57	12	t	10	\N
2738	778	2022-10-19 16:32:57	0	t	12	\N
2739	778	2022-10-19 16:32:57	13	t	9	\N
2740	778	2022-10-19 16:32:57	12	t	10	\N
2741	778	2022-10-19 16:32:57	13	t	9	\N
2742	778	2022-10-19 16:32:57	1	t	11	\N
2743	786	2022-10-20 18:33:09	12	t	3	\N
2744	786	2022-10-20 18:33:09	13	t	2	\N
2745	786	2022-10-20 18:33:09	0	t	1	\N
2746	786	2022-10-20 18:33:09	12	t	3	\N
2747	786	2022-10-20 18:33:09	0	t	1	\N
2748	786	2022-10-20 18:33:09	12	t	3	\N
2749	786	2022-10-20 18:33:09	13	t	2	\N
2750	786	2022-10-20 18:33:09	0	t	1	\N
2751	786	2022-10-20 18:33:09	12	t	3	\N
2752	786	2022-10-20 18:33:09	13	t	2	\N
2753	787	2022-10-20 18:35:46	12	t	37	\N
2754	787	2022-10-20 18:35:46	0	t	36	\N
2755	787	2022-10-20 18:35:46	13	t	33	\N
2756	787	2022-10-20 18:35:46	12	f	34	\N
2757	787	2022-10-20 18:35:46	0	f	34	\N
2758	787	2022-10-20 18:35:46	23	t	34	\N
2759	787	2022-10-20 18:35:46	13	t	33	\N
2760	787	2022-10-20 18:35:46	1	t	31	\N
2761	787	2022-10-20 18:35:46	23	t	34	\N
2762	787	2022-10-20 18:35:46	1	t	35	\N
2763	787	2022-10-20 18:35:46	1	t	31	\N
2764	787	2022-10-20 18:35:46	13	t	33	\N
2765	787	2022-10-20 18:35:46	12	t	37	\N
2766	787	2022-10-20 18:35:46	1	t	35	\N
2767	787	2022-10-20 18:35:46	12	t	37	\N
2768	787	2022-10-20 18:35:46	0	t	36	\N
2769	787	2022-10-20 18:35:46	23	t	34	\N
2770	787	2022-10-20 18:35:46	0	t	32	\N
2771	787	2022-10-20 18:35:47	0	t	36	\N
2772	787	2022-10-20 18:35:47	1	t	35	\N
2773	787	2022-10-20 18:35:47	13	t	33	\N
2774	787	2022-10-20 18:35:47	1	t	31	\N
2775	787	2022-10-20 18:35:47	0	t	32	\N
2776	787	2022-10-20 18:35:47	1	t	35	\N
2777	787	2022-10-20 18:35:47	12	t	37	\N
2778	787	2022-10-20 18:35:47	23	t	34	\N
2779	787	2022-10-20 18:35:47	0	t	32	\N
2780	787	2022-10-20 18:35:47	13	t	33	\N
2781	787	2022-10-20 18:35:47	12	t	37	\N
2782	787	2022-10-20 18:35:47	23	t	34	\N
2783	787	2022-10-20 18:35:47	1	t	35	\N
2784	787	2022-10-20 18:35:47	0	t	32	\N
2785	805	2022-10-20 20:07:48	13	t	9	\N
2786	805	2022-10-20 20:07:48	12	t	10	\N
2787	805	2022-10-20 20:07:48	1	t	11	\N
2788	805	2022-10-20 20:07:48	12	t	10	\N
2789	805	2022-10-20 20:07:48	0	t	12	\N
2790	805	2022-10-20 20:07:48	1	t	11	\N
2791	805	2022-10-20 20:07:48	0	t	8	\N
2792	805	2022-10-20 20:07:48	12	t	10	\N
2793	805	2022-10-20 20:07:48	13	t	9	\N
2794	805	2022-10-20 20:07:48	12	t	10	\N
2795	805	2022-10-20 20:07:48	0	t	12	\N
2796	805	2022-10-20 20:07:48	13	t	9	\N
2797	805	2022-10-20 20:07:48	0	t	8	\N
2798	805	2022-10-20 20:07:48	0	t	12	\N
2799	805	2022-10-20 20:07:48	13	t	9	\N
2800	808	2022-10-21 16:04:24	13	t	6	\N
2801	808	2022-10-21 16:04:24	0	t	4	\N
2802	808	2022-10-21 16:04:25	13	t	6	\N
2803	808	2022-10-21 16:04:25	0	t	4	\N
2804	808	2022-10-21 16:04:25	13	t	5	\N
2805	808	2022-10-21 16:04:25	0	t	4	\N
2806	808	2022-10-21 16:04:25	13	t	5	\N
2807	808	2022-10-21 16:04:25	1	t	7	\N
2808	808	2022-10-21 16:04:25	13	t	6	\N
2809	808	2022-10-21 16:04:25	1	t	7	\N
2810	808	2022-10-21 16:04:25	13	t	6	\N
2811	808	2022-10-21 16:04:25	1	t	7	\N
2812	814	2022-10-21 20:04:17	0	t	17	\N
2813	814	2022-10-21 20:04:17	0	t	17	\N
2814	814	2022-10-21 20:04:17	0	t	13	\N
2815	814	2022-10-21 20:04:17	0	t	17	\N
2816	814	2022-10-21 20:04:17	0	t	13	\N
2817	814	2022-10-21 20:04:17	0	f	18	\N
2818	814	2022-10-21 20:04:17	0	f	16	\N
2819	814	2022-10-21 20:04:17	1	t	16	\N
2820	814	2022-10-21 20:04:17	0	t	17	\N
2821	814	2022-10-21 20:04:17	0	t	13	\N
2822	814	2022-10-21 20:04:17	0	f	18	\N
2823	814	2022-10-21 20:04:17	0	f	16	\N
2824	814	2022-10-21 20:04:17	1	t	16	\N
2825	814	2022-10-21 20:04:17	1	f	15	\N
2826	814	2022-10-21 20:04:17	1	t	16	\N
2827	814	2022-10-21 20:04:17	1	f	14	\N
2828	814	2022-10-21 20:04:17	0	f	14	\N
2829	814	2022-10-21 20:04:17	1	f	14	\N
2830	814	2022-10-21 20:04:17	13	t	14	\N
2831	814	2022-10-21 20:04:17	0	t	17	\N
2832	814	2022-10-21 20:04:17	0	t	13	\N
2833	814	2022-10-21 20:04:17	0	f	18	\N
2834	814	2022-10-21 20:04:17	0	f	16	\N
2835	814	2022-10-21 20:04:17	1	t	16	\N
2836	814	2022-10-21 20:04:17	1	f	15	\N
2837	814	2022-10-21 20:04:17	1	t	16	\N
2838	814	2022-10-21 20:04:17	1	f	14	\N
2839	814	2022-10-21 20:04:17	0	f	14	\N
2840	814	2022-10-21 20:04:17	1	f	14	\N
2841	814	2022-10-21 20:04:17	13	t	14	\N
2842	814	2022-10-21 20:04:17	13	f	13	\N
2843	814	2022-10-21 20:04:17	13	f	17	\N
2844	814	2022-10-21 20:04:17	13	f	13	\N
2845	814	2022-10-21 20:04:17	13	f	15	\N
2846	814	2022-10-21 20:04:17	13	f	13	\N
2847	814	2022-10-21 20:04:18	3	f	13	\N
2848	814	2022-10-21 20:04:18	0	t	13	\N
2849	814	2022-10-21 20:04:18	0	t	17	\N
2850	814	2022-10-21 20:04:18	0	t	13	\N
2851	814	2022-10-21 20:04:18	0	f	18	\N
2852	814	2022-10-21 20:04:18	0	f	16	\N
2853	814	2022-10-21 20:04:18	1	t	16	\N
2854	814	2022-10-21 20:04:18	1	f	15	\N
2855	814	2022-10-21 20:04:18	1	t	16	\N
2856	814	2022-10-21 20:04:18	1	f	14	\N
2857	814	2022-10-21 20:04:18	0	f	14	\N
2858	814	2022-10-21 20:04:18	1	f	14	\N
2859	814	2022-10-21 20:04:18	13	t	14	\N
2860	814	2022-10-21 20:04:18	13	f	13	\N
2861	814	2022-10-21 20:04:18	13	f	17	\N
2862	814	2022-10-21 20:04:18	13	f	13	\N
2863	814	2022-10-21 20:04:18	13	f	15	\N
2864	814	2022-10-21 20:04:18	13	f	13	\N
2865	814	2022-10-21 20:04:18	3	f	13	\N
2866	814	2022-10-21 20:04:18	0	t	13	\N
2867	814	2022-10-21 20:04:18	0	f	14	\N
2868	814	2022-10-21 20:04:18	0	f	16	\N
2869	814	2022-10-21 20:04:18	0	t	17	\N
2870	814	2022-10-21 20:04:18	0	f	14	\N
2871	814	2022-10-21 20:04:18	0	t	17	\N
2872	814	2022-10-21 20:04:18	0	f	16	\N
2873	814	2022-10-21 20:04:18	1	t	16	\N
2874	824	2022-10-24 18:38:56	0	t	19	\N
2875	824	2022-10-24 18:38:56	2	t	21	\N
2876	824	2022-10-24 18:38:56	0	t	19	\N
2877	824	2022-10-24 18:38:56	1	t	22	\N
2878	824	2022-10-24 18:38:56	2	t	21	\N
2879	824	2022-10-24 18:38:56	1	t	22	\N
2880	824	2022-10-24 18:38:56	2	t	21	\N
2881	824	2022-10-24 18:38:56	0	t	19	\N
2882	824	2022-10-24 18:38:56	1	t	22	\N
2883	824	2022-10-24 18:38:57	0	t	20	\N
2884	824	2022-10-24 18:38:57	1	t	22	\N
2885	824	2022-10-24 18:38:57	2	t	21	\N
2886	824	2022-10-24 18:38:57	0	t	20	\N
2887	824	2022-10-24 18:38:57	0	t	19	\N
2888	824	2022-10-24 18:38:57	2	t	21	\N
2889	826	2022-10-24 19:36:08	0	f	16	\N
2890	826	2022-10-24 19:36:08	0	f	16	\N
2891	826	2022-10-24 19:36:08	0	f	16	\N
2892	826	2022-10-24 19:36:08	0	f	16	\N
2893	826	2022-10-24 19:36:08	0	f	16	\N
2894	826	2022-10-24 19:36:08	1	t	16	\N
2895	826	2022-10-24 19:36:08	0	t	13	\N
2896	826	2022-10-24 19:36:08	2	t	18	\N
2897	826	2022-10-24 19:36:08	0	t	13	\N
2898	826	2022-10-24 19:36:08	2	t	18	\N
2899	826	2022-10-24 19:36:08	12	t	15	\N
2900	826	2022-10-24 19:36:08	0	f	14	\N
2901	826	2022-10-24 19:36:08	0	f	14	\N
2902	826	2022-10-24 19:36:08	13	t	14	\N
2903	826	2022-10-24 19:36:08	13	f	15	\N
2904	826	2022-10-24 19:36:08	12	t	15	\N
2905	826	2022-10-24 19:36:08	12	f	14	\N
2906	826	2022-10-24 19:36:08	13	t	14	\N
2907	826	2022-10-24 19:36:08	13	f	18	\N
2908	826	2022-10-24 19:36:09	2	t	18	\N
2909	826	2022-10-24 19:36:09	2	f	16	\N
2910	826	2022-10-24 19:36:09	1	t	16	\N
2911	826	2022-10-24 19:36:09	1	f	18	\N
2912	826	2022-10-24 19:36:09	2	t	18	\N
2913	826	2022-10-24 19:36:09	2	f	16	\N
2914	826	2022-10-24 19:36:09	1	t	16	\N
2915	826	2022-10-24 19:36:09	1	f	17	\N
2916	826	2022-10-24 19:36:09	0	t	17	\N
2917	826	2022-10-24 19:36:09	0	f	16	\N
2918	826	2022-10-24 19:36:09	1	t	16	\N
2919	826	2022-10-24 19:36:09	1	f	15	\N
2920	826	2022-10-24 19:36:09	12	t	15	\N
2921	826	2022-10-24 19:36:09	12	f	18	\N
2922	826	2022-10-24 19:36:09	2	t	18	\N
2923	826	2022-10-24 19:36:09	2	f	13	\N
2924	826	2022-10-24 19:36:09	0	t	13	\N
2925	828	2022-10-24 19:40:50	2	t	18	\N
2926	828	2022-10-24 19:40:51	0	t	13	\N
2927	828	2022-10-24 19:40:51	2	t	18	\N
2928	828	2022-10-24 19:40:51	1	t	16	\N
2929	828	2022-10-24 19:40:51	13	t	14	\N
2930	828	2022-10-24 19:40:51	2	t	18	\N
2931	828	2022-10-24 19:40:51	0	t	13	\N
2932	828	2022-10-24 19:40:51	0	t	17	\N
2933	828	2022-10-24 19:40:51	2	t	18	\N
2934	828	2022-10-24 19:40:51	12	t	15	\N
2935	828	2022-10-24 19:40:51	0	t	17	\N
2936	828	2022-10-24 19:40:51	12	t	15	\N
2937	828	2022-10-24 19:40:51	1	t	16	\N
2938	828	2022-10-24 19:40:51	0	t	13	\N
2939	828	2022-10-24 19:40:51	12	t	15	\N
2940	828	2022-10-24 19:40:51	1	t	16	\N
2941	828	2022-10-24 19:40:51	2	t	18	\N
2942	828	2022-10-24 19:40:51	12	t	15	\N
2943	834	2022-10-24 20:20:36	0	t	19	\N
2944	834	2022-10-24 20:20:37	0	t	20	\N
2945	834	2022-10-24 20:20:37	2	t	21	\N
2946	834	2022-10-24 20:20:37	0	t	20	\N
2947	834	2022-10-24 20:20:37	1	t	22	\N
2948	834	2022-10-24 20:20:37	0	t	20	\N
2949	834	2022-10-24 20:20:37	2	t	21	\N
2950	834	2022-10-24 20:20:37	0	t	20	\N
2951	834	2022-10-24 20:20:37	1	t	22	\N
2952	834	2022-10-24 20:20:37	0	t	20	\N
2953	834	2022-10-24 20:20:37	2	t	21	\N
2954	834	2022-10-24 20:20:37	1	t	22	\N
2955	834	2022-10-24 20:20:37	0	t	19	\N
2956	834	2022-10-24 20:20:37	2	t	21	\N
2957	834	2022-10-24 20:20:37	1	t	22	\N
2958	837	2022-10-25 18:07:00	0	t	26	\N
2959	837	2022-10-25 18:07:00	1	t	28	\N
2960	837	2022-10-25 18:07:00	1	t	25	\N
2961	837	2022-10-25 18:07:00	1	t	28	\N
2962	837	2022-10-25 18:07:00	2	t	27	\N
2963	837	2022-10-25 18:07:00	0	f	29	\N
2964	837	2022-10-25 18:07:00	12	t	29	\N
2965	837	2022-10-25 18:07:00	0	t	30	\N
2966	837	2022-10-25 18:07:00	0	t	23	\N
2967	837	2022-10-25 18:07:00	2	t	27	\N
2968	837	2022-10-25 18:07:00	1	t	25	\N
2969	837	2022-10-25 18:07:00	1	t	28	\N
2970	837	2022-10-25 18:07:00	0	t	30	\N
2971	837	2022-10-25 18:07:00	1	t	28	\N
2972	837	2022-10-25 18:07:00	0	t	23	\N
2973	837	2022-10-25 18:07:00	0	t	26	\N
2974	837	2022-10-25 18:07:00	2	t	24	\N
2975	837	2022-10-25 18:07:00	0	t	26	\N
2976	837	2022-10-25 18:07:00	1	t	25	\N
2977	837	2022-10-25 18:07:00	12	t	29	\N
2978	837	2022-10-25 18:07:00	0	t	26	\N
2979	840	2022-10-25 18:13:42	2	t	21	\N
2980	840	2022-10-25 18:13:42	1	t	22	\N
2981	840	2022-10-25 18:13:42	0	t	20	\N
2982	840	2022-10-25 18:13:42	2	t	21	\N
2983	840	2022-10-25 18:13:42	0	t	20	\N
2984	840	2022-10-25 18:13:42	1	t	22	\N
2985	840	2022-10-25 18:13:42	0	t	20	\N
2986	840	2022-10-25 18:13:42	2	t	21	\N
2987	840	2022-10-25 18:13:42	0	t	19	\N
2988	840	2022-10-25 18:13:42	0	t	20	\N
2989	840	2022-10-25 18:13:42	1	t	22	\N
2990	840	2022-10-25 18:13:42	0	t	20	\N
2991	840	2022-10-25 18:13:42	1	t	22	\N
2992	840	2022-10-25 18:13:42	0	t	20	\N
2993	840	2022-10-25 18:13:42	2	t	21	\N
2994	842	2022-10-26 22:02:50	13	t	2	\N
2995	842	2022-10-26 22:02:50	12	t	3	\N
2996	842	2022-10-26 22:02:50	13	t	2	\N
2997	842	2022-10-26 22:02:50	0	t	1	\N
2998	842	2022-10-26 22:02:50	13	t	2	\N
2999	842	2022-10-26 22:02:50	12	t	3	\N
3000	842	2022-10-26 22:02:50	0	t	1	\N
3001	842	2022-10-26 22:02:50	12	t	3	\N
3002	842	2022-10-26 22:02:50	13	t	2	\N
3003	842	2022-10-26 22:02:50	12	t	3	\N
3004	843	2022-10-26 22:33:56	0	t	1	\N
3005	843	2022-10-26 22:33:57	13	t	2	\N
3006	843	2022-10-26 22:33:57	12	t	3	\N
3007	843	2022-10-26 22:33:57	13	t	2	\N
3008	843	2022-10-26 22:33:57	12	t	3	\N
3009	843	2022-10-26 22:33:57	0	t	1	\N
3010	843	2022-10-26 22:33:57	13	t	2	\N
3011	843	2022-10-26 22:33:57	12	t	3	\N
3012	843	2022-10-26 22:33:57	0	t	1	\N
3013	843	2022-10-26 22:33:57	13	t	2	\N
3014	846	2022-10-26 23:06:12	1	t	22	\N
3015	846	2022-10-26 23:06:12	0	t	19	\N
3016	846	2022-10-26 23:06:12	0	t	20	\N
3017	846	2022-10-26 23:06:12	0	t	19	\N
3018	846	2022-10-26 23:06:12	0	t	20	\N
3019	846	2022-10-26 23:06:12	2	t	21	\N
3020	846	2022-10-26 23:06:12	0	t	19	\N
3021	846	2022-10-26 23:06:12	2	t	21	\N
3022	846	2022-10-26 23:06:12	0	t	19	\N
3023	846	2022-10-26 23:06:12	0	t	20	\N
3024	846	2022-10-26 23:06:12	2	t	21	\N
3025	846	2022-10-26 23:06:12	0	t	19	\N
3026	846	2022-10-26 23:06:12	0	t	20	\N
3027	846	2022-10-26 23:06:12	2	t	21	\N
3028	846	2022-10-26 23:06:12	1	t	22	\N
3029	847	2022-10-26 23:41:21	1	t	16	\N
3030	847	2022-10-26 23:41:21	12	t	15	\N
3031	847	2022-10-26 23:41:21	1	t	16	\N
3032	847	2022-10-26 23:41:21	0	t	17	\N
3033	847	2022-10-26 23:41:21	13	t	14	\N
3034	847	2022-10-26 23:41:21	2	t	18	\N
3035	847	2022-10-26 23:41:21	13	t	14	\N
3036	847	2022-10-26 23:41:21	12	t	15	\N
3037	847	2022-10-26 23:41:21	0	t	17	\N
3038	847	2022-10-26 23:41:21	1	t	16	\N
3039	847	2022-10-26 23:41:21	0	t	17	\N
3040	847	2022-10-26 23:41:21	2	t	18	\N
3041	847	2022-10-26 23:41:21	12	t	15	\N
3042	847	2022-10-26 23:41:21	0	t	17	\N
3043	847	2022-10-26 23:41:21	1	t	16	\N
3044	847	2022-10-26 23:41:21	2	t	18	\N
3045	847	2022-10-26 23:41:21	13	t	14	\N
3046	847	2022-10-26 23:41:21	12	t	15	\N
3047	848	2022-10-27 00:42:24	13	t	9	\N
3048	848	2022-10-27 00:42:24	0	t	12	\N
3049	848	2022-10-27 00:42:24	1	t	11	\N
3050	848	2022-10-27 00:42:24	12	t	10	\N
3051	848	2022-10-27 00:42:24	1	t	11	\N
3052	848	2022-10-27 00:42:24	13	t	9	\N
3053	848	2022-10-27 00:42:24	0	t	12	\N
3054	848	2022-10-27 00:42:24	0	t	8	\N
3055	848	2022-10-27 00:42:24	1	t	11	\N
3056	848	2022-10-27 00:42:24	0	t	12	\N
3057	848	2022-10-27 00:42:25	13	t	9	\N
3058	848	2022-10-27 00:42:25	0	t	8	\N
3059	848	2022-10-27 00:42:25	1	t	11	\N
3060	848	2022-10-27 00:42:25	0	t	8	\N
3061	848	2022-10-27 00:42:25	1	t	11	\N
3062	870	2022-10-31 18:53:09	12	t	3	\N
3063	870	2022-10-31 18:53:09	13	t	2	\N
3064	870	2022-10-31 18:53:09	0	t	1	\N
3065	870	2022-10-31 18:53:09	13	t	2	\N
3066	870	2022-10-31 18:53:09	0	t	1	\N
3067	870	2022-10-31 18:53:09	12	t	3	\N
3068	870	2022-10-31 18:53:09	13	t	2	\N
3069	870	2022-10-31 18:53:09	0	t	1	\N
3070	870	2022-10-31 18:53:09	12	t	3	\N
3071	870	2022-10-31 18:53:09	0	t	1	\N
3072	871	2022-11-01 19:27:38	13	t	6	\N
3073	871	2022-11-01 19:27:38	1	t	7	\N
3074	871	2022-11-01 19:27:39	0	t	4	\N
3075	871	2022-11-01 19:27:39	1	t	7	\N
3076	871	2022-11-01 19:27:39	12	f	5	\N
3077	871	2022-11-01 19:27:39	23	f	5	\N
3078	871	2022-11-01 19:27:39	13	t	5	\N
3079	871	2022-11-01 19:27:39	1	t	7	\N
3080	871	2022-11-01 19:27:39	0	t	4	\N
3081	871	2022-11-01 19:27:39	13	t	5	\N
3082	871	2022-11-01 19:27:39	1	t	7	\N
3083	871	2022-11-01 19:27:39	0	t	4	\N
3084	871	2022-11-01 19:27:39	13	t	5	\N
3085	871	2022-11-01 19:27:39	0	t	4	\N
3086	873	2022-11-22 14:46:00	0	t	4	\N
3087	873	2022-11-22 14:46:00	13	t	5	\N
3088	873	2022-11-22 14:46:00	1	t	7	\N
3089	873	2022-11-22 14:46:00	0	t	4	\N
3090	873	2022-11-22 14:46:00	1	t	7	\N
3091	873	2022-11-22 14:46:00	0	t	4	\N
3092	873	2022-11-22 14:46:00	13	t	5	\N
3093	873	2022-11-22 14:46:00	0	t	4	\N
3094	873	2022-11-22 14:46:00	13	t	6	\N
3095	873	2022-11-22 14:46:00	0	t	4	\N
3096	873	2022-11-22 14:46:00	13	t	5	\N
3097	873	2022-11-22 14:46:00	1	t	7	\N
3098	874	2022-11-25 16:31:15	12	t	3	\N
3099	874	2022-11-25 16:31:15	13	t	2	\N
3100	874	2022-11-25 16:31:15	12	t	3	\N
3101	874	2022-11-25 16:31:15	0	t	1	\N
3102	874	2022-11-25 16:31:15	12	t	3	\N
3103	874	2022-11-25 16:31:15	0	t	1	\N
3104	874	2022-11-25 16:31:15	13	t	2	\N
3105	874	2022-11-25 16:31:15	12	t	3	\N
3106	874	2022-11-25 16:31:15	13	t	2	\N
3107	874	2022-11-25 16:31:15	12	t	3	\N
3108	877	2022-11-28 20:36:42	12	t	10002	\N
3109	877	2022-11-28 20:36:42	13	t	10001	\N
3110	877	2022-11-28 20:36:42	12	t	10002	\N
3111	877	2022-11-28 20:36:42	13	t	10001	\N
3112	877	2022-11-28 20:36:42	0	t	10000	\N
3113	877	2022-11-28 20:36:42	12	t	10002	\N
3114	877	2022-11-28 20:36:42	0	t	10000	\N
3115	877	2022-11-28 20:36:42	12	t	10002	\N
3116	877	2022-11-28 20:36:42	0	t	10000	\N
3117	877	2022-11-28 20:36:42	12	t	10002	\N
3118	878	2022-11-28 20:50:43	12	t	40045	\N
3119	878	2022-11-28 20:50:43	0	t	40044	\N
3120	878	2022-11-28 20:50:43	1	t	40046	\N
3121	878	2022-11-28 20:50:43	0	t	40044	\N
3122	878	2022-11-28 20:50:43	1	t	40046	\N
3123	878	2022-11-28 20:50:43	23	t	40042	\N
3124	878	2022-11-28 20:50:43	12	t	40045	\N
3125	878	2022-11-28 20:50:43	23	t	40043	\N
3126	878	2022-11-28 20:50:43	23	t	40042	\N
3127	878	2022-11-28 20:50:43	1	t	40046	\N
3128	878	2022-11-28 20:50:43	23	t	40043	\N
3129	878	2022-11-28 20:50:43	1	t	40046	\N
3130	878	2022-11-28 20:50:43	12	t	40045	\N
3131	878	2022-11-28 20:50:43	1	t	40046	\N
3132	879	2022-11-28 20:51:50	23	t	40126	\N
3133	879	2022-11-28 20:51:50	0	t	40127	\N
3134	879	2022-11-28 20:51:50	23	t	40126	\N
3135	879	2022-11-28 20:51:50	2	t	40130	\N
3136	879	2022-11-28 20:51:50	23	t	40126	\N
3137	879	2022-11-28 20:51:50	2	t	40130	\N
3138	879	2022-11-28 20:51:50	12	t	40129	\N
3139	879	2022-11-28 20:51:50	0	t	40127	\N
3140	879	2022-11-28 20:51:50	12	t	40129	\N
3141	879	2022-11-28 20:51:50	2	t	40130	\N
3142	879	2022-11-28 20:51:50	23	t	40128	\N
3143	879	2022-11-28 20:51:50	23	t	40126	\N
3144	879	2022-11-28 20:51:50	12	t	40129	\N
3145	879	2022-11-28 20:51:50	23	t	40128	\N
3146	879	2022-11-28 20:51:50	23	t	40126	\N
3147	879	2022-11-28 20:51:50	12	t	40129	\N
3148	880	2022-11-28 20:52:26	12	t	30017	\N
3149	880	2022-11-28 20:52:26	13	t	30016	\N
3150	880	2022-11-28 20:52:26	12	t	30017	\N
3151	880	2022-11-28 20:52:26	123	t	30015	\N
3152	880	2022-11-28 20:52:26	12	t	30017	\N
3153	880	2022-11-28 20:52:26	13	t	30016	\N
3154	880	2022-11-28 20:52:26	12	t	30017	\N
3155	880	2022-11-28 20:52:26	123	t	30015	\N
3156	880	2022-11-28 20:52:26	12	t	30017	\N
3157	880	2022-11-28 20:52:26	13	t	30016	\N
3158	882	2022-11-28 20:54:05	12	t	30065	\N
3159	882	2022-11-28 20:54:05	0	t	30064	\N
3160	882	2022-11-28 20:54:05	1	t	30062	\N
3161	882	2022-11-28 20:54:06	12	t	30065	\N
3162	882	2022-11-28 20:54:06	0	t	30064	\N
3163	882	2022-11-28 20:54:06	1	t	30062	\N
3164	882	2022-11-28 20:54:06	2	t	30063	\N
3165	882	2022-11-28 20:54:06	12	t	30065	\N
3166	882	2022-11-28 20:54:06	2	t	30063	\N
3167	882	2022-11-28 20:54:06	1	t	30062	\N
3168	882	2022-11-28 20:54:06	12	t	30065	\N
3169	882	2022-11-28 20:54:06	1	t	30062	\N
3170	883	2022-11-28 20:54:47	0	t	30070	\N
3171	883	2022-11-28 20:54:48	0	t	30074	\N
3172	883	2022-11-28 20:54:48	1	t	30080	\N
3173	883	2022-11-28 20:54:48	0	t	30072	\N
3174	883	2022-11-28 20:54:48	1	t	30075	\N
3175	883	2022-11-28 20:54:48	1	t	30066	\N
3176	883	2022-11-28 20:54:48	12	t	30078	\N
3177	883	2022-11-28 20:54:48	1	t	30077	\N
3178	883	2022-11-28 20:54:48	1	t	30071	\N
3179	883	2022-11-28 20:54:48	0	t	30072	\N
3180	883	2022-11-28 20:54:48	1	t	30069	\N
3181	883	2022-11-28 20:54:48	1	t	30075	\N
3182	883	2022-11-28 20:54:48	0	t	30072	\N
3183	883	2022-11-28 20:54:48	1	t	30069	\N
3184	883	2022-11-28 20:54:48	12	t	30068	\N
3185	884	2022-11-28 20:56:18	1	t	40289	\N
3186	884	2022-11-28 20:56:18	1	t	40298	\N
3187	884	2022-11-28 20:56:18	0	t	40276	\N
3188	884	2022-11-28 20:56:18	23	t	40301	\N
3189	884	2022-11-28 20:56:18	13	t	40280	\N
3190	884	2022-11-28 20:56:18	12	t	40292	\N
3191	884	2022-11-28 20:56:18	123	t	40278	\N
3192	884	2022-11-28 20:56:18	13	t	40280	\N
3193	884	2022-11-28 20:56:18	23	t	40279	\N
3194	884	2022-11-28 20:56:18	0	t	40276	\N
3195	884	2022-11-28 20:56:18	13	t	40270	\N
3196	884	2022-11-28 20:56:18	23	t	40279	\N
3197	884	2022-11-28 20:56:18	23	t	40272	\N
3198	884	2022-11-28 20:56:18	2	t	40295	\N
3199	884	2022-11-28 20:56:18	0	t	40300	\N
3200	884	2022-11-28 20:56:18	1	t	40289	\N
3201	884	2022-11-28 20:56:18	2	t	40284	\N
3202	884	2022-11-28 20:56:18	0	t	40285	\N
3203	884	2022-11-28 20:56:18	2	t	40284	\N
3204	884	2022-11-28 20:56:18	2	t	40274	\N
3205	884	2022-11-28 20:56:18	1	t	40294	\N
3206	884	2022-11-28 20:56:19	23	t	40287	\N
3207	884	2022-11-28 20:56:19	1	t	40289	\N
3208	884	2022-11-28 20:56:19	0	t	40297	\N
3209	884	2022-11-28 20:56:19	13	t	40270	\N
3210	884	2022-11-28 20:56:19	2	t	40284	\N
3211	884	2022-11-28 20:56:19	1	t	40289	\N
3212	884	2022-11-28 20:56:19	13	t	40280	\N
3213	884	2022-11-28 20:56:19	2	t	40274	\N
3214	884	2022-11-28 20:56:19	13	t	40270	\N
3215	884	2022-11-28 20:56:19	23	t	40286	\N
3216	884	2022-11-28 20:56:19	23	t	40281	\N
3217	884	2022-11-28 20:56:19	23	t	40279	\N
3218	884	2022-11-28 20:56:19	123	t	40277	\N
3219	884	2022-11-28 20:56:19	2	t	40296	\N
3220	884	2022-11-28 20:56:19	2	t	40284	\N
3221	884	2022-11-28 20:56:19	12	t	40303	\N
3222	884	2022-11-28 20:56:19	23	t	40279	\N
3223	884	2022-11-28 20:56:19	12	t	40288	\N
3224	884	2022-11-28 20:56:19	12	t	40293	\N
3225	884	2022-11-28 20:56:19	0	t	40285	\N
3226	884	2022-11-28 20:56:19	2	t	40274	\N
3227	884	2022-11-28 20:56:19	23	f	40295	\N
3228	884	2022-11-28 20:56:19	2	t	40295	\N
3229	884	2022-11-28 20:56:19	1	t	40298	\N
3230	884	2022-11-28 20:56:19	13	t	40270	\N
3231	884	2022-11-28 20:56:19	1	t	40283	\N
3232	884	2022-11-28 20:56:19	0	t	40300	\N
3233	884	2022-11-28 20:56:19	23	t	40301	\N
3234	884	2022-11-28 20:56:19	2	t	40299	\N
3235	884	2022-11-28 20:56:19	1	t	40294	\N
3236	887	2022-11-28 21:46:29	12	t	40001	\N
3237	887	2022-11-28 21:46:29	23	t	40000	\N
3238	887	2022-11-28 21:46:29	123	t	40002	\N
3239	887	2022-11-28 21:46:29	23	t	40000	\N
3240	887	2022-11-28 21:46:29	123	t	40002	\N
3241	887	2022-11-28 21:46:29	23	t	40000	\N
3242	887	2022-11-28 21:46:29	12	t	40001	\N
3243	887	2022-11-28 21:46:29	123	t	40002	\N
3244	887	2022-11-28 21:46:29	23	t	40000	\N
3245	887	2022-11-28 21:46:30	13	t	40003	\N
3246	887	2022-11-28 21:46:30	23	t	40000	\N
3247	887	2022-11-28 21:46:30	123	t	40002	\N
3248	887	2022-11-28 21:46:30	23	t	40000	\N
3249	887	2022-11-28 21:46:30	123	t	40002	\N
3250	888	2022-12-02 15:01:34	0	t	1	\N
3251	888	2022-12-02 15:01:34	12	t	3	\N
3252	888	2022-12-02 15:01:34	0	t	1	\N
3253	888	2022-12-02 15:01:34	13	t	2	\N
3254	888	2022-12-02 15:01:34	0	t	1	\N
3255	888	2022-12-02 15:01:35	13	t	2	\N
3256	888	2022-12-02 15:01:35	0	t	1	\N
3257	888	2022-12-02 15:01:35	13	t	2	\N
3258	888	2022-12-02 15:01:35	12	t	3	\N
3259	888	2022-12-02 15:01:35	13	t	2	\N
3260	889	2022-12-02 19:05:27	13	t	2	\N
3261	889	2022-12-02 19:05:27	12	t	3	\N
3262	889	2022-12-02 19:05:27	13	t	2	\N
3263	889	2022-12-02 19:05:27	0	t	1	\N
3264	889	2022-12-02 19:05:27	12	t	3	\N
3265	889	2022-12-02 19:05:27	0	t	1	\N
3266	889	2022-12-02 19:05:27	13	t	2	\N
3267	889	2022-12-02 19:05:27	0	t	1	\N
3268	889	2022-12-02 19:05:27	13	t	2	\N
3269	889	2022-12-02 19:05:27	12	t	3	\N
3270	890	2022-12-02 19:07:14	13	t	6	\N
3271	890	2022-12-02 19:07:15	0	t	4	\N
3272	890	2022-12-02 19:07:15	1	t	7	\N
3273	890	2022-12-02 19:07:15	13	t	6	\N
3274	890	2022-12-02 19:07:15	0	t	4	\N
3275	890	2022-12-02 19:07:15	13	t	6	\N
3276	890	2022-12-02 19:07:15	1	t	7	\N
3277	890	2022-12-02 19:07:15	0	t	4	\N
3278	890	2022-12-02 19:07:15	13	t	5	\N
3279	890	2022-12-02 19:07:15	0	t	4	\N
3280	890	2022-12-02 19:07:15	13	t	6	\N
3281	890	2022-12-02 19:07:15	0	t	4	\N
3282	891	2022-12-02 20:53:22	1	t	30002	\N
3283	891	2022-12-02 20:53:23	0	t	30003	\N
3284	891	2022-12-02 20:53:23	12	t	30000	\N
3285	891	2022-12-02 20:53:23	123	t	30004	\N
3286	891	2022-12-02 20:53:23	12	t	30000	\N
3287	891	2022-12-02 20:53:23	2	t	30001	\N
3288	891	2022-12-02 20:53:23	12	t	30000	\N
3289	891	2022-12-02 20:53:23	2	t	30001	\N
3290	891	2022-12-02 20:53:23	12	t	30000	\N
3291	891	2022-12-02 20:53:23	0	t	30003	\N
3292	891	2022-12-02 20:53:23	12	t	30000	\N
3293	891	2022-12-02 20:53:23	0	t	30003	\N
3294	891	2022-12-02 20:53:23	2	t	30001	\N
3295	891	2022-12-02 20:53:23	0	t	30003	\N
3296	892	2022-12-02 21:58:50	12	t	10	\N
3297	892	2022-12-02 21:58:51	13	t	9	\N
3298	892	2022-12-02 21:58:51	12	t	10	\N
3299	892	2022-12-02 21:58:51	0	t	8	\N
3300	892	2022-12-02 21:58:51	12	t	10	\N
3301	892	2022-12-02 21:58:51	0	t	12	\N
3302	892	2022-12-02 21:58:51	12	t	10	\N
3303	892	2022-12-02 21:58:51	13	t	9	\N
3304	892	2022-12-02 21:58:51	1	t	11	\N
3305	892	2022-12-02 21:58:51	0	t	12	\N
3306	892	2022-12-02 21:58:51	13	t	9	\N
3307	892	2022-12-02 21:58:51	1	t	11	\N
3308	892	2022-12-02 21:58:51	13	t	9	\N
3309	892	2022-12-02 21:58:51	1	t	11	\N
3310	892	2022-12-02 21:58:51	0	t	12	\N
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
\.


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: quiz_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_attempt_id_seq', 892, true);


--
-- Name: quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_id_seq', 1, false);


--
-- Name: quiz_pitch_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_pitch_attempt_id_seq', 3310, true);


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

