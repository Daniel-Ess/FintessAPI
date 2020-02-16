--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: goodrequest
--

CREATE TABLE public.activity (
    id integer NOT NULL,
    type integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    duration integer NOT NULL,
    latitude character varying NOT NULL,
    longtitude character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public.activity OWNER TO goodrequest;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: goodrequest
--

CREATE SEQUENCE public.activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_id_seq OWNER TO goodrequest;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: goodrequest
--

ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: goodrequest
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO goodrequest;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: goodrequest
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO goodrequest;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: goodrequest
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: goodrequest
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."user" OWNER TO goodrequest;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: goodrequest
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO goodrequest;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: goodrequest
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: goodrequest
--

COPY public.activity (id, type, name, description, duration, latitude, longtitude, "createdAt", "updatedAt", "userId") FROM stdin;
39	0	Running	ASDASD	6666	19.542681	32.896421	2020-02-16 14:49:38.912077	2020-02-16 14:49:38.912077	3
43	1	Walking	ASDASD	6666	19.542681	32.896421	2020-02-16 17:19:57.541904	2020-02-16 17:19:57.541904	2
42	2	CrossFit	ASDAsadadSD	666666666	19.542681	32.896421	2020-02-16 17:19:54.511004	2020-02-16 17:52:03.64185	2
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: goodrequest
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1581705586960	CreateAdminUser1581705586960
2	1581796205747	CreateCommonUser1581796205747
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: goodrequest
--

COPY public."user" (id, email, password, role, "createdAt", "updatedAt") FROM stdin;
2	user	$2a$08$KuWdklcR66rgnYS5lBhPzODRfmtz8IzXAl2Ip9f8es70vCZpV63tC	USER	2020-02-16 11:25:41.57857	2020-02-16 11:25:41.57857
1	admin	$2a$08$Y18sWHst5V8zkNwARwWpGOwa/hU3tB23saIUyJg0CXeHTx2ZWo83y	ADMIN	2020-02-16 11:25:41.505181	2020-02-16 17:38:04.229172
3	new@asd.sk	$2a$08$5va6./xzyz63ZUqWZlEAI.2GHmDvcLq2e2M.ybFDS6nrxJKaW2Vbu	USER	2020-02-16 11:27:10.349853	2020-02-16 17:41:13.939947
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: goodrequest
--

SELECT pg_catalog.setval('public.activity_id_seq', 43, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: goodrequest
--

SELECT pg_catalog.setval('public.migrations_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: goodrequest
--

SELECT pg_catalog.setval('public.user_id_seq', 4, true);


--
-- Name: activity PK_24625a1d6b1b089c8ae206fe467; Type: CONSTRAINT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT "PK_24625a1d6b1b089c8ae206fe467" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- Name: activity FK_3571467bcbe021f66e2bdce96ea; Type: FK CONSTRAINT; Schema: public; Owner: goodrequest
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT "FK_3571467bcbe021f66e2bdce96ea" FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

