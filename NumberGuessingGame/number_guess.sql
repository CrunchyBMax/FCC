--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: master; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.master (
    user_id integer NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_guesses integer,
    username character varying(22) NOT NULL
);


ALTER TABLE public.master OWNER TO freecodecamp;

--
-- Name: master_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.master_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.master_user_id_seq OWNER TO freecodecamp;

--
-- Name: master_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.master_user_id_seq OWNED BY public.master.user_id;


--
-- Name: master user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.master ALTER COLUMN user_id SET DEFAULT nextval('public.master_user_id_seq'::regclass);


--
-- Data for Name: master; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.master VALUES (170, 1, 48, 'user_1679349454208');
INSERT INTO public.master VALUES (169, 2, 75, 'user_1679349454209');
INSERT INTO public.master VALUES (172, 1, 464, 'user_1679349488375');
INSERT INTO public.master VALUES (171, 3, 173, 'user_1679349488376');
INSERT INTO public.master VALUES (174, 2, 57, 'user_1679349505375');
INSERT INTO public.master VALUES (173, 2, 12, 'user_1679349505376');
INSERT INTO public.master VALUES (176, 2, 447, 'user_1679349520254');
INSERT INTO public.master VALUES (175, 2, 212, 'user_1679349520255');
INSERT INTO public.master VALUES (177, 2, 10, 'user_1679349535339');
INSERT INTO public.master VALUES (178, 2, 295, 'user_1679349535338');


--
-- Name: master_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.master_user_id_seq', 178, true);


--
-- Name: master master_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.master
    ADD CONSTRAINT master_pkey PRIMARY KEY (user_id);


--
-- Name: master unique_username; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.master
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- PostgreSQL database dump complete
--

