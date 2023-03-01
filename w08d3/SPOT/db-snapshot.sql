--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 14.1

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

ALTER TABLE IF EXISTS ONLY public.understandings DROP CONSTRAINT IF EXISTS fk_user;
ALTER TABLE IF EXISTS ONLY public.understandings DROP CONSTRAINT IF EXISTS fk_objective;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.tags_objectives DROP CONSTRAINT IF EXISTS unique_tags_objectives_id;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS unique_id;
ALTER TABLE IF EXISTS ONLY public.curricula DROP CONSTRAINT IF EXISTS unique_curricula_id;
ALTER TABLE IF EXISTS ONLY public.understandings DROP CONSTRAINT IF EXISTS understandings_pkey;
ALTER TABLE IF EXISTS ONLY public.course_outcomes DROP CONSTRAINT IF EXISTS outcomes_pkey;
ALTER TABLE IF EXISTS ONLY public.objectives DROP CONSTRAINT IF EXISTS objectives_pkey;
ALTER TABLE IF EXISTS ONLY public.days DROP CONSTRAINT IF EXISTS days_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.unit_outcomes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.understandings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tags_objectives ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.objectives ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.days ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.curricula ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.courses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_outcomes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.activities ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.unit_outcomes_id_seq;
DROP TABLE IF EXISTS public.unit_outcomes;
DROP SEQUENCE IF EXISTS public.understandings_id_seq;
DROP TABLE IF EXISTS public.understandings;
DROP SEQUENCE IF EXISTS public.tags_objectives_id_seq;
DROP TABLE IF EXISTS public.tags_objectives;
DROP SEQUENCE IF EXISTS public.tags_id_seq;
DROP TABLE IF EXISTS public.tags;
DROP SEQUENCE IF EXISTS public.outcomes_id_seq;
DROP SEQUENCE IF EXISTS public.objectives_id_seq;
DROP TABLE IF EXISTS public.objectives;
DROP SEQUENCE IF EXISTS public.days_id_seq;
DROP TABLE IF EXISTS public.days;
DROP SEQUENCE IF EXISTS public.curricula_id_seq;
DROP TABLE IF EXISTS public.curricula;
DROP SEQUENCE IF EXISTS public.courses_id_seq;
DROP TABLE IF EXISTS public.courses;
DROP TABLE IF EXISTS public.course_outcomes;
DROP SEQUENCE IF EXISTS public.activities_id_seq;
DROP TABLE IF EXISTS public.activities;
DROP TYPE IF EXISTS public.outcome_type;
DROP TYPE IF EXISTS public.activitytypeenum;
--
-- Name: activitytypeenum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.activitytypeenum AS ENUM (
    'Reading',
    'Note',
    'Lecture',
    'Quiz',
    'Assignment',
    'Exercise',
    'Task',
    'Challenge',
    'Test'
);


ALTER TYPE public.activitytypeenum OWNER TO postgres;

--
-- Name: outcome_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.outcome_type AS ENUM (
    'Work/Course',
    'Learning/Unit'
);


ALTER TYPE public.outcome_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    day_id integer,
    title character varying(128),
    type public.activitytypeenum
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_seq OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: course_outcomes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_outcomes (
    id integer NOT NULL,
    description character varying(255),
    course_id integer
);


ALTER TABLE public.course_outcomes OWNER TO postgres;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    description character varying(255),
    curriculum_id integer
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: curricula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curricula (
    id integer NOT NULL,
    description character varying(64)
);


ALTER TABLE public.curricula OWNER TO postgres;

--
-- Name: curricula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.curricula_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curricula_id_seq OWNER TO postgres;

--
-- Name: curricula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.curricula_id_seq OWNED BY public.curricula.id;


--
-- Name: days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.days (
    id integer NOT NULL,
    day_mnemonic character varying(5),
    day_description character varying(20),
    title text
);


ALTER TABLE public.days OWNER TO postgres;

--
-- Name: days_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.days_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.days_id_seq OWNER TO postgres;

--
-- Name: days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.days_id_seq OWNED BY public.days.id;


--
-- Name: objectives; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.objectives (
    id integer NOT NULL,
    day_id integer,
    type character varying(12),
    question text,
    answer text,
    sort smallint,
    total_time integer,
    parent_id integer,
    curriculum_id integer DEFAULT 1 NOT NULL,
    svg_diagram text
);


ALTER TABLE public.objectives OWNER TO postgres;

--
-- Name: objectives_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.objectives_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.objectives_id_seq OWNER TO postgres;

--
-- Name: objectives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.objectives_id_seq OWNED BY public.objectives.id;


--
-- Name: outcomes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.outcomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.outcomes_id_seq OWNER TO postgres;

--
-- Name: outcomes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.outcomes_id_seq OWNED BY public.course_outcomes.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(32)
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: tags_objectives; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags_objectives (
    id integer NOT NULL,
    objective_id integer,
    tag_id integer
);


ALTER TABLE public.tags_objectives OWNER TO postgres;

--
-- Name: tags_objectives_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_objectives_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_objectives_id_seq OWNER TO postgres;

--
-- Name: tags_objectives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_objectives_id_seq OWNED BY public.tags_objectives.id;


--
-- Name: understandings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.understandings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    objective_id integer NOT NULL,
    level integer NOT NULL
);


ALTER TABLE public.understandings OWNER TO postgres;

--
-- Name: understandings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.understandings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.understandings_id_seq OWNER TO postgres;

--
-- Name: understandings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.understandings_id_seq OWNED BY public.understandings.id;


--
-- Name: unit_outcomes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_outcomes (
    id integer NOT NULL,
    description character varying(255),
    course_outcome_id integer
);


ALTER TABLE public.unit_outcomes OWNER TO postgres;

--
-- Name: unit_outcomes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_outcomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_outcomes_id_seq OWNER TO postgres;

--
-- Name: unit_outcomes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_outcomes_id_seq OWNED BY public.unit_outcomes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(256) NOT NULL,
    password character varying(256) NOT NULL,
    admin integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: course_outcomes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_outcomes ALTER COLUMN id SET DEFAULT nextval('public.outcomes_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: curricula id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curricula ALTER COLUMN id SET DEFAULT nextval('public.curricula_id_seq'::regclass);


--
-- Name: days id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.days ALTER COLUMN id SET DEFAULT nextval('public.days_id_seq'::regclass);


--
-- Name: objectives id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.objectives ALTER COLUMN id SET DEFAULT nextval('public.objectives_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tags_objectives id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags_objectives ALTER COLUMN id SET DEFAULT nextval('public.tags_objectives_id_seq'::regclass);


--
-- Name: understandings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.understandings ALTER COLUMN id SET DEFAULT nextval('public.understandings_id_seq'::regclass);


--
-- Name: unit_outcomes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_outcomes ALTER COLUMN id SET DEFAULT nextval('public.unit_outcomes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: course_outcomes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.course_outcomes (id, description, course_id) VALUES (24, 'Write a multi-page web server with a route handler that will choose a template to render based on the request details.', 3);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (26, 'Write a template for a multipage app to able to give the appropriate HTML for any given user''s request to a specific URL.', 3);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (27, 'Formulate a user authentication element to a server to register new users, handle registration errors, and login existing users', 3);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (28, 'Adapt a server for security using encryption and hashing', 3);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (30, 'Demonstrate best practices by performing simple refactors', 3);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (31, 'test', 1);
INSERT INTO public.course_outcomes (id, description, course_id) VALUES (25, 'Develop a basic user-facing CRUD app that uses HTTP protocols', 3);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.courses (id, description, curriculum_id) VALUES (1, 'Javascript Programming Fundamentals', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (2, 'Networking and HTTP', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (3, 'Web Server Development with Node', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (4, 'Front-End Development', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (5, 'Relational Databases & SQL', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (6, 'Midterm', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (7, 'React', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (7, 'Automated Testing in React', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (9, 'Ruby on Rails', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (10, 'Research & Reflect', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (11, 'Final Project', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (12, 'Intro to Computer Science', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (1, 'Javascript Programming Fundamentals', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (2, 'Networking and HTTP', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (3, 'Web Server Development with Node', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (4, 'Front-End Development', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (5, 'Relational Databases & SQL', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (6, 'Midterm', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (7, 'React', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (7, 'Automated Testing in React', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (9, 'Ruby on Rails', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (10, 'Research & Reflect', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (11, 'Final Project', 1);
INSERT INTO public.courses (id, description, curriculum_id) VALUES (12, 'Intro to Computer Science', 1);


--
-- Data for Name: curricula; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.curricula (id, description) VALUES (1, 'Web Bootcamp');
INSERT INTO public.curricula (id, description) VALUES (2, 'Data Science Bootcamp');


--
-- Data for Name: days; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (1, 'w01d1', 'Week 1 Day 1', 'Welcome and Introductions');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (2, 'w01d2', 'Week 1 Day 2', 'The Dev Workflow');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (3, 'w01d3', 'Week 1 Day 3', 'Objects in Javascript');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (4, 'w01d4', 'Week 1 Day 4', 'Callbacks');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (5, 'w01d5', 'Week 1 Day 5', 'TEST');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (6, 'w02d1', 'Week 2 Day 1', 'TDD with Mocha & Chai ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (7, 'w02d2', 'Week 2 Day 2', 'Asynchronous Control Flow ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (8, 'w02d3', 'Week 2 Day 3', 'Networking with TCP and HTTP ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (9, 'w02d4', 'Week 2 Day 4', 'Promises');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (10, 'w02d5', 'Week 2 Day 5', 'TEST');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (11, 'w03d1', 'Week 3 Day 1', 'Web Servers 101');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (12, 'w03d2', 'Week 3 Day 2', 'CRUD with Express');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (13, 'w03d3', 'Week 3 Day 3', 'HTTP Cookies & User Authentication ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (14, 'w03d4', 'Week 3 Day 4', 'Security and Real World HTTP Servers ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (15, 'w03d5', 'Week 3 Day 5', 'TEST');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (16, 'w04d1', 'Week 4 Day 1', 'Intro to CSS');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (17, 'w04d2', 'Week 4 Day 2', 'Client Side JavaScript & jQuery ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (18, 'w04d3', 'Week 4 Day 3', 'AJAX');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (19, 'w04d4', 'Week 4 Day 4', 'Responsive Design and SASS');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (20, 'w04d5', 'Week 4 Day 5', 'TEST');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (21, 'w05d1', 'Week 5 Day 1', 'SQL Intro');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (22, 'w05d2', 'Week 5 Day 2', 'Database Design');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (23, 'w05d3', 'Week 5 Day 3', 'SQL from our Apps');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (24, 'w05d4', 'Week 5 Day 4', 'TEST');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (25, 'w05d5', 'Week 5 Day 5', 'Midterms Kickoff');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (26, 'w06d1', 'Week 6 Day 1', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (27, 'w06d2', 'Week 6 Day 2', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (28, 'w06d3', 'Week 6 Day 3', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (29, 'w06d4', 'Week 6 Day 4', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (30, 'w06d5', 'Week 6 Day 5', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (31, 'w07d1', 'Week 7 Day 1', 'Component-Based UI w/ React');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (32, 'w07d2', 'Week 7 Day 2', 'Immutable Update Patterns');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (33, 'w07d3', 'Week 7 Day 3', 'Data Fetching & Other Side Effects ');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (34, 'w07d4', 'Week 7 Day 4', 'Custom Hooks');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (35, 'w07d5', 'Week 7 Day 5', NULL);
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (36, 'w08d1', 'Week 8 Day 1', 'Unit & Integration Testing');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (37, 'w08d2', 'Week 8 Day 2', 'Real World React (Advanced Topics)');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (38, 'w08d3', 'Week 8 Day 3', 'End-to-End Testing with Cypress');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (39, 'w08d4', 'Week 8 Day 4', 'Class-based Components');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (40, 'w08d5', 'Week 8 Day 5', 'Intro to Ruby (for Javascript Developers)');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (41, 'w09d1', 'Week 9 Day 1', 'OOP and Active Record');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (42, 'w09d2', 'Week 9 Day 2', 'Rails Prep Day');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (43, 'w09d3', 'Week 9 Day 3', 'Jungle - Day 1');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (44, 'w09d4', 'Week 9 Day 4', 'Jungle - Day 2');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (45, 'w09d5', 'Week 9 Day 5', 'Research and Reflect');
INSERT INTO public.days (id, day_mnemonic, day_description, title) VALUES (9999, 'w12d5', 'Week 12 Day 5', 'Graduation Celebration');


--
-- Data for Name: objectives; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (27, 22, 'learning', 'What are the features required of a primary key?', 'A Primary Key must be unique (within the table) and can never be null.', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (26, 19, 'learning', 'What are the relative length units available in CSS?', 'em, ex, ch, rem, vw, vh, vmin, vmax, %', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (155, 0, 'learning', 'Students will be able to successfully build, populate and use RDBMS-based SQL databases', '', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (156, 19, 'performance', 'How do you create a CSS rule that will only be applied for small screens?', '@media only screen and (max-width: 500px) {
  /* these styles will be applied if the screen width is less than 500px */
  body {
    background-color: lightblue;
  }
}
', 10, NULL, 1, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (157, 19, 'learning', 'What are some standard media query widths to try?', '<div class="left">
Bootstrap uses media queries to target the following widths:
</div>
<div class="right">
. landscape phones (576px)
. tablets (768px)
. laptops (992px)
. extra large desktop screens (1200px)
</div>
', 12, 120, 1, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (5, 22, 'learning', 'How do I establish a relationship between tables?', 'You can establish a relationship between tables by creating a column that tells you, for each row, which row in another table it is related to.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (28, 22, 'learning', 'What is the most common data type for a Primary Key?', 'A Primary Key''s data type is usually auto-incrementing integer (INTEGER or BIGINT).', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (29, 22, 'learning', 'What is a Foreign Key?', 'A Foreign Key is a column on a second table, where the value in a given row indicates an association with a row from the first table. The Foreign Key value on the second table matches the Primary Key value from the first table.', 8, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (32, 22, 'learning', 'What is an ERD?', 'ERD; an Entity Relationship Diagram is a diagram that shows the relationships established between entities within a system. For databases, this is more often with regard to relationships between tables.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (13, 16, 'learning', 'What is the box model?', 'The box model is how DOM elements are typically rendered to occupy a certain amount of screen real estate, via padding, borders and margins.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (18, NULL, 'learning', 'What is DOM traversal?', 'DOM traversal is the ability of client-side javascript to jump from one node to a parent, sibling or child, step by step throughout the DOM, looking for elements that match a certain criteria.', NULL, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (36, 23, 'performance', 'How do we prevent a SQL Injection attack?', 'client.query(''SELECT * FROM <table> WHERE id = $1'', [<id>])   
.then((result) => console.log(result));', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (35, 23, 'learning', 'What is a SQL injection attack?', 'A malicious user crafts input for a form submission that will be mistakenly input directly into a database. That input might be any SQL query, including dropping tables or deleting rows. ', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (34, 23, 'performance', 'How, given a postgres client object, do you submit queries to the database from back-end javascript?', 'client.query(''SELECT * FROM <table>'')
   .then((result) => console.log(result));', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (40, 12, 'learning', 'In the context of web programming, what is a template?', 'A template is a file containing mainly HTML, but with syntactic morsels of dynamic content.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (20, 17, 'performance', 'How do you traverse the DOM with jQuery?', '$(''.parent'').children().addClass("tagged");', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (2, 21, 'learning', 'What is a database?', 'A database is a collection of tables. The collection is typically used as a set. A connection to a database is granted via a username and password.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (4, 21, 'learning', 'What is a WHERE clause?', 'A query can filter or restrict the information that results via a WHERE clause.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (6, 21, 'learning', 'What is a JOIN clause?', 'The data that a query has access to, can be expanded via JOIN-ing two tables together.', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (3, 21, 'learning', 'What is a query?', 'A query is a task executed against a database, table or combination of tables. e.g. SELECT, INSERT, etc.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (9, 21, 'performance', 'How do I INSERT rows into a table?', 'INSERT INTO objectives(id, type, question, answer, sort)\nVALUES (21, w05d1, "How do I INSERT rows into a table?", "solution goes here",2);', 9, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (31, 21, 'learning', 'What are the four types of commands for databases?', 'DDL, DML, DCL, and TCL. See: https://stackoverflow.com/questions/2578194/what-are-ddl-and-dml', 8, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (7, 21, 'learning', 'What is an ERD?', 'In the context of databases, an ERD is a diagram that shows each table as an entity, and also shows the relationships between tables.', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (1, 21, 'learning', 'What is a table?', 'A table is a set of data collected as columns and rows.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (30, 21, 'learning', 'What are the queries that correspond to the CRUD actions?', 'The CRUD queries are: INSERT, SELECT, UPDATE and DELETE.', 10, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (8, 21, 'performance', 'How do I create a table?', 'CREATE TABLE objectives\n(\n    id bigint,\n    day_id character varying(5),\n    type character varying(12),\n    question text,\n    answer text,\n    sort smallint\n)', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (41, 12, 'learning', 'What is the main reason to use a templating system?', 'Separating business logic from the presentation layer (separation of concerns), enables specialization of roles for programmers.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (23, 19, 'performance', 'How do you set a maximum width on HTML elements?', '.these_elements { max-width: 135px; }', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (25, 19, 'learning', 'What are the absolute length units available in CSS?', 'mm, cm, in, px, pt, pc (1 pc = 12 pt)', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (22, 19, 'performance', 'How do you set a minimum width on HTML elements?', '.these_elements { min-width: 135px; }', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (24, 19, 'performance', 'How should we set the web browser''s viewport?', '<meta name="viewport" content="width=device-width, initial-scale=1.0">', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (10, 14, 'learning', 'Why would we never want to store passwords as plaintext?', 'To keep the passwords away from prying eyes, like hackers and website employees.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (39, 18, 'learning', 'What are some disadvantages of AJAX?', 'Creating dynamic content is tricky, asynchronous programming patterns are more complex to code, it requires js and XMLHTTPRequest support, history is not automatically updated.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (11, 14, 'learning', 'Rather than storing passwords as plaintext, how should they be stored?', 'Passwords should always be _hashed_. There is no need to encrypt them, since you never want to be able to see the password yourself.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (44, 12, 'learning', 'How, in NodeJS, do you write a route that accepts a dynamic value as part of the URL??', '```
app.get(''/path/:fuzz'', (req,res) => { 
  console.log(req.params.fuzz);
});
```
', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (45, 12, 'learning', 'Does the order that your routes appear in your source code matter?', 'Yes. The order of the routes in your file matters. First matched -> First used.', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (42, 12, 'learning', 'How do you code EJS templates?', '```
$> npm i ejs  


$> mkdir views  

// ...

app.set(''view engine'', ''ejs'');

// ...

// then, inside your route callback:

res.render(''viewfilestub'');

```
', 8, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (46, 13, 'learning', 'How do you read a cookie value that arrives at a NodeJS program in the web request?', '```js

app.get(''/protected'', (req, res) => {

  const userId = req.cookies.userId;

  // do something with the userId

});

```', 4, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (15, 16, 'learning', 'What is the basic syntax for a CSS ''Rule''?', '[selector] { style: value; ... } ', 3, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (14, 16, 'learning', 'How do you set the preferred box model?', '* { box-sizing: border-box; }', 5, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (63, 16, 'learning', 'What does it mean to say that with version 5, HTML became more ''semantic''?', 'The tags introduced in HTML 5 provide ways of describing the purpose and meaning of parts of a page. This is useful for developers, as well as crawlers and bots that are trying to find specific parts of a page to highlight.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (60, 16, 'learning', 'What are the three CSS styles most directly related to the box model for any given DOM element?', 'Margin, Border, Padding', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (61, 16, 'learning', 'For the CSS styles that take 1,2 or 4 length parameters (padding, margin, etc.) how is each number of parameters interpreted?', 'For 1 parameter, all 4 sides of the box get the same value. For 2 parameters, the first is ''top'' and ''bottom'' and the second is ''left'' and ''right''. Four parameters specify each side, top, right, bottom and left, respectively.', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (59, 16, 'learning', 'What is a Single Page App?', 'An SPA is an app that leverages AJAX to prevent page reloads. Instead it changes page content by manipulating the DOM directly, using front-end javascript.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (33, 23, 'performance', 'How do you connect to a Postgres DB from within Javascript?', 'const pg = require(''pg'');
const config = { 
  user: ''<user name>'',
  password: ''<password>'',
  database: ''<db>'',
  host: ''<host>'' };
const client = new pg.Client(config);
client.connect()
.then(() => console.log(''db connected''))
.catch(err => console.error(''db connection error'', err.stack));', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (64, 17, 'learning', 'What are some examples of Javascript objects that are only defined in the browser context?', 'window, navigator, document', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (16, 17, 'performance', 'How do you create a new element using jQuery and dynamically append it to a DOM element?', '$(''<div class="newElement">Text content goes here.</div>'').appendTo($( ".container" ));', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (65, 17, 'learning', 'What is DOM traversal?', 'DOM travsersal is the ability for client-side Javascript to move from one node of the DOM to another. Test.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (78, 31, 'learning', 'What is React''s Virtual DOM?', 'The virtual DOM is a copy of the DOM that it kept in memory. React does most of its work there, and then as a final step patches the actual DOM, but only where needed.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (79, 31, 'performance', 'How do you create a boilerplate React app?', 'On the terminal:

$> npx create-react-app name-of-app-goes-here
', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (70, 19, 'learning', 'How do you define variables in SASS?', '$main-size: 2em;
$background-color: purple;', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (81, 31, 'performance', 'How do you make your own HTML Tags using JSX?', 'In JSX, a new component can be made by creating a function that returns HTML.

function Button(props){
  return (
    <button>{props.text}</button>
  );
}

The following two ways of executing that function from within HTML are equivalent:

<Button text="click me"></Button>

or

{Button({text: ''click me''});', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (17, 17, 'learning', 'What is DOM manipulation?', 'DOM manipulation is the ability of client-side javascript to add, remove or change parts of the DOM after the initial page load.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (57, 14, 'learning', 'How can you use verbs other than GET and POST in your HTML, given that you''re using a NodeJS back-end?', 'The method-override package: https://www.npmjs.com/package/method-override', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (58, 14, 'learning', 'What package is available to help you implemented encrypted cookie values?', 'cookie-session: http://expressjs.com/en/resources/middleware/cookie-session.html', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (37, 18, 'learning', 'What is AJAX?', 'Asynchronous Javascript and XML is a different paradigm of web request, where smaller amounts of data, or small parts of a webpage are sent and recieved in requests that do not result in page a refresh.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (56, 14, 'learning', 'What is REST?', 'REST is a convention for choosing paths and HTTP verbs for end-point routes.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (38, 18, 'learning', 'What are some advantages of AJAX?', 'No page reloads, faster page renders, improved response times, client side rendering reduces network load.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (68, 18, 'learning', 'What are the implications of using AJAX calls on the browser history?', 'An AJAX call in and of itself does not add any locations to the browser history. If it is important that the history be updated to a URL that can return a user to a certain state of the app, then it is the front-end code''s responsibility to call the History API to make changes to the browser history.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (77, 6, 'performance', 'How do you prevent files from being stored in your git repository?', 'Create a file named .gitignore

Inside that file put a list of filenames (wildcards allowed) where if the line matches a name, it won''t be ''seen'' by git.

e.g.

See: https://git-scm.com/docs/gitignore
', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (75, 6, 'learning', 'How do you export things from any given Javascript file?', 'module.exports = [AN EXPRESSION WITH A VALUE THAT REQUIRE WILL PICK UP];

e.g. 

module.exports = {
  myFunc,
  myOtherFunc
};', 0, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (73, 6, 'learning', 'What is Mocha?', 'Mocha is a testing framework. It looks for test files to run in the ./test/ folder.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (76, 6, 'learning', 'How do you bring in things that are exported from another Javascript file?', 'const thing = require("./path/to/javascript-file");', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (72, 6, 'learning', 'What is Test Driven Development?', 'Tests are written before the code. The tests make the expectations of the code explicit. Red - Green - Refactor are the stages of code development. You make the code work (pass the tests!) and then you can refactor the code, safe in the knowledge that the code is relatively easily testable.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (74, 6, 'learning', 'What is Chai?', 'Chai is an assertion library. It defines a large number of assertions useful for testing.', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (88, 33, 'learning', 'What is a pure function?', '1) The function only depends on its inputs to return a value.

2) Given the same input, the function always returns the same output.

3) It doesn''t produce changes beyond it''s scope.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (90, 33, 'learning', 'Why would you choose to put code into a useEffect hook, rather than at the top level of a component?', 'If you need to ensure that a block of code runs after the component is rendered, then placing that block of code inside a useEffect hook will achieve this.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (62, 16, 'learning', 'What is the difference between a block element and an inline element?', 'A block element (e.g. <div></div> or display: block;) occupies the entire width of its container, whereas an inline element (e.g. <span></span> or display: inline;) will flow, by default from left to right within the container.', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (124, 39, 'learning', 'What are three main lifecycle methods with Class-based components?', 'componentDidMount for set up  (axios call, setInterval, etc.)

componentDidUpdate opportunity for state values to be set

componentWillUnmount() for cleanup of intervals, prevent memory leaks', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (96, 37, 'learning', 'Compare and contrast Front-End routing with Back-End routing.', 'Both Front-End and Back-End Routing involve providing a set of code that will be chosen from by the particular system. There is a section of code that applies to any given URL.

With Back-End Routing, that code is selected depending on the path included in a new web request, and the appropriate code lives on and is executed on the back-end server.

With Front-End Routing, no new web request is actually created. The entire operation is conducted within Front-End code.

With React Router Dom, for example, all the endpoints are specified as a specific set of components that will be displayed for any given route.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (97, 37, 'learning', 'What are the basic components for React Router Dom?', 'BrowserRouter (imported ''as'' <Router>) knows about (and can control) itself and its descendents. An entirely application would usually have only one component that imports and implements this tag.

<Link> provides a link that won''t initiate a new request. Use the ''to'' attribute as the destination.

<Route> catches the changes initiated by a <Link>. They contain the conditional components to be displayed for any given path. The path attribute is ''fuzzy matched'', unless you include the ''exact'' attribute.

<Switch> enforces a ''first match only'' policy on <Route> tags. Switch tags can also be put on a sub-component. This helps display page specific content that needs to live inside a sub-component.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (83, 32, 'learning', 'What is the difference between props and state?', 'Props are values that are handed down into a component, as attributes on the custom HTML tag associated with that component''s being called.

State is controlled data that springs into existance when the useState function is called.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (84, 32, 'learning', 'When updating state on a component, what might cause an infinite loop?', 'If your component has an event handler that updates state (and certainly, there are many events that should update state), then if your onClick or onChange etc. directly calls your function that updates state, that by itself will trigger a rerendering of the component, which starts the process all over again.

To avoid that infinite loop, your event handler can be set to be a callback function. Then when the component rerenders, it will only establish that callback rather than invoking the state setter again. This breaks what would otherwise start an infinite loop of rendering/stateSetting/etc.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (98, 37, 'learning', 'Which hook allows your Front-End routing code to extract parameters from the URL?', 'useParams is a hook, provided by React Router Dom, that allows your code to extract URL parameters, just as req.params would do for node.js.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (99, 37, 'learning', 'What is deep linking?', 'Deep linking is a feature of Front-End Routing, where even if a user clicks on a URL to the app that arrived in an email, or perhaps was saved as a bookmark, the app is loaded from scratch and then displays some deep subpage or state that the link represents.

While the app is still a ''single page app'', the app will load all of itself up on that deep link request, but then render the appropriate state to correspond to the link.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (100, 37, 'learning', 'How do you create Styled Components?', 'import styled from ''styled-components'';

const Styled = () => {

  const Header2 = styled.h2`
    color: pink;
    text-decoration: underline;
  `;

  return (
    <div>
      <Header2>Styled Component</h2>
    </div>
  );

};

// This is an inline style, that destroys separation of concerns. :-)', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (101, 37, 'learning', 'How does useContext avoid prop drilling?', 'Prop drilling is where a component hierarchy passes props from grandparent down to a parent and then down to children, etc.

We need one file that stores some context. Import that file and use it as a component that provides context.

<ContextHolder.Provider value={{counter,setCounter}}>
  <ChildOne/>
  <ChildTwo/>
</ContextHolder.Provider>

', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (21, 19, 'learning', 'What is responsive web design?', 'Responsive Web Design is a set of practices that allows web pages to alter their layout and appearance to suit different screen widths and resolutions.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (69, 19, 'learning', 'What is the advantage of mobile first design?', 'Mobile First Design forces stakeholders to choose the very most important elements for any given webpage. Scaling pages sizes up from there results in a design that retains that focus and affords reasonable value to empty space. This approach is most compatible with the typical tensions associated with the desire to put as much up as possible. Overcrowding a webpage cheapens it, in a design sense.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (102, 22, 'learning', 'In SQL, what convention applies to whether you can include lowercase or uppercase letters in a table or column name?', 'By convention, tables and columns are given names in snake_case. That is, words are separated by underscores and all letters are lower case.', 9, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (91, 32, 'learning', 'When returning a multi-line value from a function, what do parentheses achieve for you?', 'When returning a multi-line value via a return statement, parentheses enable you to avoid ''automatic semicolon insertion''. 

return (
<div>
 <h1>Text Goes Here.</h1>
</div>
);', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (82, 32, 'learning', 'What are the two ways to set state on a React Component?', 'Let''s say you have some state set up thusly:

const [numVisitors, setNumVisitors] = useState(0);

Setting state involves calling the state''s associated setter function (setNumVisitors in this case).

That function can either take the new value for that state, like so:

setNumVisitors(5);

OR...

... it can take a callback as a parameter, like so:

setNumVisitors(currentValue => 5);

This second method is the preferred method for setting state.

Remember that all of the following are equivalent definitions of a function. The input parameter is ignored every time.

function (currentValue){
  return 5;
}

(currentValue) => { return 5; } 

currentValue => 5;
', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (48, 13, 'learning', 'What is a web cookie?', 'A cookie is a name/value pair that stores information related to a particular user on their browser by a certain domain.', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (50, 12, 'learning', 'In NodeJS, how do you accept values from an HTML form?', '```
app.post(''/path'', (req,res) => { 
  console.log(req.body.fuzz); 
});
```
', 5, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (47, 13, 'learning', 'How do you set a cookie value from within a NodeJS app?', '``` js

app.post(''/login'', (req, res) => {

  // >> code to authenticate the user goes here <<

  // set the cookie''s key and value   
  res.cookie(''userId'', user.id);

  res.redirect(''/'');
});

```', 3, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (121, 39, 'learning', 'How do you use Classes to define components in React?', 'class OurComponent extends React.Component {

  constructor(){
    super();
  }

  render(){
    return (
             <h1>Some Text</h1>
           );
  }

}', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (123, 39, 'performance', 'How is state handled in Class-based components?', 'class OurComponent extends React.Component {

  constructor(){
    super();
    this.state = {counter: 0};
  }

  clickHandler = () => { // this syntax will bind properly
    this.setState({counter: this.state.counter + 1});
  }

  render(){
    <div>
      <h4>Counter: {this.state.counter}</h4>
      <button onClick={ () => { this.clickHandler() } }>Add 1</button>
    </div>
  }

}', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (133, 999, 'class', 'Coffee or Naan or Doggie Video?', 'Dog Of Course!', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (85, 32, 'learning', 'Why is it important to leave the original version of our state unchanged when we are updating state?', 'React compares the old and new values of state before deciding which DOM elements to update. A significant speed increase results from using React because it only chooses to update the DOM elements with changed states.

This means that when we are updating state, we need to create a new (deep) copy of the state (at least the parts that will change within a given event listener) and leave the original state data structure untouched.

Javascript''s basic operations are often reference values. For example, the = operator will copy the reference to an object, rather than instantiating a new object.

For this reason, you will often need to use the spread operator (new in ES6) to make a copy of an object, like so:

const copy = {
  ...originalObject,
  keyWithAChangedValue: ''newValue''
};', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (106, 7, 'learning', 'What is Javascripts Event Loop?', 'Javascript''s ''Event Loop'' is a special feature of Javascript where the JS processor can stay alive after the main code has been parsed, and scheduled events will run processes in parallel.

This enables your code to stay on its feet, to react to user input or other inputs, while at the same time, managing the underlying OS''s actions like reading files, downloading data from an API, gathering user input from a terminal, etc.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (107, 7, 'performance', 'How do you schedule a callback to be called (by the Event Loop) at some point in the future, after the current thread is finished?', 'setTimeout(callback, delay); // where callback is a function definition, and delay is a number of milliseconds minimum before the callback will be called. (It cannot be called at all, until after the current thread is done.)', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (111, 7, 'learning', 'If you schedule a callback to be executed directly by the the Event Loop, can its return value be collected?', 'No.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (108, 7, 'learning', 'How can you configure a callback to be called at a regular interval?', 'setInterval(callback, timeBetweenCalls); // timeBetweenCalls is in milliseconds.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (109, 7, 'learning', 'When can callbacks that have been configured to be invoked by the Event Loop being?', 'If a callback has been scheduled to be called on the Event Loop, there is no way for it to be called until after the scheduling thread has finished. (Is this also true of process.netTick() ?)

The Event Loop DOES NOT START until after the main thread is finished.
', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (110, 7, 'learning', 'What are some examples of tasks that would be better handled by a system that can run things in parallel?', 'Any time that a task may take some large amount of time, and that that time could potentially get in the way of more important tasks, consider scheduling the execution of that task on the Event Loop (i.e. in an asynchronous callback) instead of as a blocking call on the main thread.

For example: calling an API, reading a file, waiting for keystrokes of user input, waiting for mouse clicks on elements, etc.', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (112, 9, 'learning', 'What is "callback hell"?', '"Callback hell" is a problem with code, where the hierarchy of callbacks has gone so deep that debugging the code has become difficult.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (117, 11, 'learning', 'What is a Route?', 'A route is the combination of HTTP Request Verb (GET, POST, etc.) and a Path ("/contact", etc.)

A web server chooses which code to build the specific response based on the route.', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (118, 11, 'learning', 'What is Middleware?', 'In the context of an Express Web Server, middleware is code that will be executed for every route.

Examples include parsing cookie or form data from the request headers, performing debugging logging, and performing authentication tasks.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (12, 14, 'learning', 'What is the difference between encryption and hashing?', 'Hashing is one way, so you can''t recover the original text from the hash.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (54, 14, 'learning', 'What is HTTPS?', 'HTTP Secure is the encrypted version of HTTP. Using it means that the traffic between your computer and its destination cannot be read by any server or public wifi system in the delivery path.', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (67, 18, 'learning', 'What is CORS and how might you deal with it as an app developer?', 'Cross Origin Resource Sharing (CORS) is a policy that some APIs use to prevent vulnerabilities to certain kinds of hacking.

For a development deployment only, you might choose to install a browser extension that disables your own browser from checking an API''s CORS policy, or you might send your API requests via a proxy that does something similar.

See https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS and 
https://medium.com/@dtkatz/3-ways-to-fix-the-cors-error-and-how-access-control-allow-origin-works-d97d55946d9', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (131, 40, 'learning', 'What is the syntax for a constructor in Ruby?', '```
# the name of the constructor function in Ruby is initialize

class Car

  def initialize make, model, year
    @make = make
    @model = model
    @year = year
  end

end
```', 4, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (130, 40, 'learning', 'How do you instantiate an object in Ruby?', '
class Car

car = Car.new

puts car
', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (129, 40, 'learning', 'In Ruby, what is a lambda?', 'A lambda is a named block of code.

names = [''Alice'', ''Bob'', ''Carol'']

names.each do |name|
  puts "hello there #{name}"
end

my_lambda = lambda do |name|
  puts "hello there #{name}"
end

an & will dereference a lambda and convert it back into a block of code

names.each &my_lambda

', 7, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (116, 11, 'learning', 'What is a Web server?', 'A web server is a computer program that listens for TCP/IP connections and HTTP requests, processes the inputs that came within that request and sends an appropriate, customized response back to the computer that made the request.', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (119, 39, 'learning', 'What is Object Oriented Programming?', 'OOP is a paradigm of programming where Classes are templates from which Objects are created. Classes are a mixture of variables and functions in one structure. Classes are the recipe, Objects are the individual instances of that recipe.', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (120, 39, 'learning', 'How do you define a Class?', 'class Rectangle {

  constructor(length, width){
    this.length = length;
    this.width = width;
  }

  area(){
    return this.length * this.width;
  }  

}', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (122, 39, 'learning', 'How are props handled in Class-based components?', 'Props are handed in as parameters to the constructor.

Class OurComponent extends React.Component {
  constructor(props){
    super(props);
  }

  render(){
    return (
             {this.props.myProp}
           );
  }

}', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (134, 4, 'performance', 'How do you define a named function using a function statement?', '```
function nameOfFunction(parameter){
  // do stuff
}
```', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (138, 4, 'learning', 'What is a callback?', 'A <span style="background-color:lightblue">callback</span> is a function that is passed as a parameter into another function.


```
const printRandomNumber = function(upperLimit){
  const value = Math.random()*upperLimit;
  console.log(''value'',value);
  return value;
}

function doActionNumTimes(num, action){
  for (let ii = 0; ii < num; ii++){
    action(ii);
  }
}

doActionNumTimes(3,printRandomNumber);
```
', 2, 60, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (140, 4, 'learning', 'When can you omit much of the syntax used to define an arrow function?', 'If you only have one parameter, you can omit the parentheses around it.

If you have only one line of code inside the function, you can omit the braces around that line, and the evaluation of that line will be used to imply a return value for the function.

x => x++ // this is an anonymous function expression', 6, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (139, 4, 'performance', 'How do you define an arrow function?', 'const functionValuedVariable = (parameter1, parameter2) => {
  // do stuff
};
', 5, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (142, 4, 'learning', 'When would you use a callback?', 'Callbacks are commonly used in two circumstances.

1) If you are writing a function that needs to (abstract/factor) out a particular sub-task that is included in that functions processing, a callback is the perfect way to do that. The callback arrives in that function as a parameter, and the details of what that callback does are left entirely unspecified.

2) If you are trying to access the output of a function that will run asynchronously, you''ll use callbacks to gain access to that output. [This topic is explored in Week 2.]', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (137, 4, 'performance', 'How do you define an anonymous function using a function expression?', '```
const functionValuedVariable = function (parameter) {
  // do stuff
};
```', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (141, 4, 'learning', 'What is a higher-order function?', 'A function that accepts a callback as a parameter is called a <span style="background-color:lightblue">higher-order function</span>.

e.g. doActionNumTimes

```
const printRandomNumber = function(upperLimit){
  return Math.random()*upperLimit;
}

function doActionNumTimes(num, action){
  for (let ii = 0; ii < num; ii++){
    action();
  }
}

doActionNumTimes(3,printRandomNumber);
```
', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (144, 6, 'learning', 'What is NPM and what does it stand for?', 'NPM, also known as Node Package Manager, is the largest collection of open source code on the planet.

Its name comes from the obvious acronym, although the main website will direct you to a variety of definitions for N.P.M.
', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (143, 6, 'learning', 'What is the main disadvantage of using the assert function built into node?', 'The assert function built into node will cause a fatal error to occur if the assertion clause is not true.

This makes it less than ideal to use in any test driven development framework because once any test fails, the whole program would halt.', 4, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (146, 41, 'learning', 'How do you set an instance variable in a Ruby class?', '```
class Person

  def initialize(name)
    @name = name
  end

end
```
', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (147, 41, 'learning', 'What table names are associated with Ruby classes while using Active Record?', '
| Model / Class  | Table / Schema |
|---|---|
| Article | articles |
| LineItem | line_items |
| Deer | deers |
| Mouse | mice |
| Person | people |', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (148, 41, 'learning', 'How do you create a Class that works with  Active Record to build the associated table?', '```
class Product < ApplicationRecord

end
```', 3, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (126, 40, 'learning', 'What are hashes in Ruby?', 'A hash is a collection of key value pairs.

e.g. 

user = {
 "first_name" => "Paul",
 "last_name" => "McCartney"
}

puts user["first_name"] # must use square brackets
', 1, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (127, 40, 'learning', 'What are symbols in Ruby?', 'A symbol is a lightweight string. They were introduced into the language to speed things up.

e.g. 
user = {
  :first_name => ''John'',
  :last_name => ''Lennon''
}

OR

Javascript syntax will also define symbols as well.

user = {
  first_name: ''Yoko'',
  last_name: ''Ono''
}

But we still need to use this:

puts user[:first_name]
', 2, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (128, 40, 'learning', 'How are blocks of code written in Ruby?', 'A block of code is written with an ''do'' for before it, and an ''end'' after it.

So here...

```
for name in names do
  puts "Hello #{name}"
end
```

... the block starts with the word do and ends at the word end.

NOTE: { } has also been added to the language', 3, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (125, 40, 'performance', 'How does ''implicit return'' work in Ruby?', 'def say_hello first_name
  "hello there #{first_name}"
end

puts say_hello ''Alice''
', 0, NULL, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (149, 42, 'learning', 'What is the MVC code pattern?', 'MVC stands for Model, View, Controller.

Models holds and manages the application data, usually on the back-end.

A Controller implements functionality that gathers and processes information intended to be displayed in a View. It sets up requests that will fire as the result of UI controls being used.

A View is where data is interpolated into a template for display to the end-user.', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (153, 0, 'learning', 'Students will be able to successfully build and test Javascript-based web applications.', '', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (132, 40, 'learning', 'How can you quickly create getters and setters for an instance variable in a class in Ruby?', '```

# notice the attr_* functions here...

class Car

  def initialize make, model, year
    @make = make
    @model = model
    @year = year
  end

  # just a getter
  attr_reader :model

  # just a setter
  attr_writer :model

  # both getter and setter
  attr_accessor :year

end

```
', 6, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (53, 13, 'learning', 'What does it mean to say that HTTP is ''stateless''?', 'The HTTP protocol itself is unable to associate one request with another. Each request starts from scratch. Cookies are a payload within the headers of a request that enable a server to identify the browser session/user.', 0, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (43, 12, 'learning', 'How often do you need to restart your web server?', 'Template files are reloaded every time they are rendered, so there is no need to restart your server if you have only changed your EJS template.

If, however, the server code itself changes, then the server will need to be restarted.

Nodemon is a helper program, available in the npm repository, that will run node programs and restart them when required.', 6, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (49, 13, 'learning', 'How does a web cookie''s value transmit from one computer to another?', '<div class="left">
A webserver sets a cookie value by including the cookie in a response header. After that, every web request that is sent back to that web server by a browswer will include the cookie in the header of those requests.
</div>
', 2, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (114, 9, 'learning', 'Given a promise object, how do you attach a callback that would run if the promise resolves?', '<div class="left">

the then function (defined on all promise objects) is how you establish which 

callback should be called for the case when a promise resolves.

</div>

<div class="right">

```
const promise = <some object from some package or library that builds promises>;

promise.then( (result) => { console.log(result)} );
```

</div>
', 3, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (115, 9, 'learning', 'Given a promise object, how do you attach a callback that would run if the promise is rejected?', '// the catch function (defined on all promise objects) is how you establish which
// callback should be called for the case when a promise is rejected.

const promise = <some object from some package or library that builds promises>;                                                                promise.catch( (error) => { console.log(error)} );', 5, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (89, 33, 'learning', 'What are some common side-effects that, if you needed to do them, would make a pure function impure?', '
1. Writing to standard out (i.e. console.log()).
1. Modifying DOM elements outside of React''s control.
1. Establishing socket connections.
1. Retrieving data from an API.
1. Setting timers or intervals.', 1, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (92, 33, 'learning', 'How can you prevent a useEffect hook from running, for instance, if that particular call is not relevant?', 'The second parameter to the useEffect() function call is a ''dependency array''. That array contains values that React will monitor for changes. So for the following:

* const [numVisitors, setNumVisitors] = useState(0);
* useEffect(callback, numVisitors);
* ... the callback will only be called (after a render) when numVisitors changes.
', 4, 120, 0, 1, NULL);
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (113, 9, 'learning', 'In Javascript, what is a Promise?', '[] A Promise is an object that keeps track of the state of an action. At the beginning of its lifecycle, it is in a pending state. Later on, after the action has finished, the Promise object will either have resolved or have been rejected.

[] If a promise resolves, your code can be configured to call the next callback in a chain.

[] If a promise rejects, your code can be configured to call an error handling callback instead.
', 1, 120, 0, 1, '<?xml version="1.0" encoding="UTF-8"?>
<!-- Do not edit this file with editors other than diagrams.net -->
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="501px" height="501px" viewBox="-0.5 -0.5 501 501" content="&lt;mxfile host=&quot;app.diagrams.net&quot; modified=&quot;2022-03-15T22:52:57.381Z&quot; agent=&quot;5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36&quot; etag=&quot;wbo3PMkSjsniiMkQfLGN&quot; version=&quot;17.1.3&quot;&gt;&lt;diagram id=&quot;rvujitfWx5mvbhpYCwYS&quot; name=&quot;Promise Diagram&quot;&gt;7Vhbb+I4GP01PDZy7FwfWwhTVjO0KrOXPo3cxBBvkzjrmAL769cmzj1dqAakSrvqQ+3zXRx/5/jGBE3T/ReO8/gbi0gygSDaT9BsAqHpuVD+U8hBI7ZvlsiG00hjDbCifxMNAo1uaUSKjqNgLBE074IhyzISig6GOWe7rtuaJd1Rc7whA2AV4mSI/k4jEZeoZ4MGvyd0E1cjm0BbUlw5a6CIccR2LQgFEzTljImyle6nJFHVq+pSxs3fsdYfxkkmzgnI8leekemCZfjH6jmMrft9emPqNG842eoZ668Vh6oEnG2ziKgsYILudjEVZJXjUFl3knWJxSJNZM+UzTVNkilLGD/GosBRfxLXwxAuyP7dCZh1WaSgCEuJ4AfpogNu6qprMd001d413NgVFrd4qUGs9bCp0zclkw1dtQ9UEI4U0EnksHcvsrFRjadg9fD1t2BWGeQ4tW1Q7eKViDDWxc4ZzQThwZssUaErXOtIOUS4iGtqWjQUgrNXUhGRsYwMuQFgPgcqLsEvJHlkBRWUZdIWEjWoNCi6qFwLX3sOL0wIlrYcbhO6UQbBlBzYViRUFqpekmoQrF3q5HIeuZpzut+ovcNg6zUNiSEXckhyURgkxTT5gfOcszc1xYtIyPV6EnJ8YAAAXQs5HkQmcAZ6ch3Dc6SDDXwPIL8atKMuzzBhk8Nyr6Q1dI7Wfgmm3z+d1pTSPr3WOPlT5riY1qyjtIDpO8D1LGRaH1aebcgcdTxyR5QnxWn7ENiu65gugt6VlGedVt5jsJwtll/OEl5zpJinjxT8UrBkK8gtD/X94Ig2PasWYXVEwzEF6t3uEtQ6jm20eIFO71wCcHguST8D2i1Ch2ya0DGQjVwfONLb9KwrsWmeQWcFrJmsSZs8568tqww3xZGCW+kArXzfGGtRPD18W6wCaX+4UxtTSx1l4u5g/yoayZf44M6jocF+0N9LUhpFaphRKXbvPxc5hWD/IgO8oWCgNXKRQde6x5j+u5oocpxVrMwW0gK+3ytKG3Lni+VidS8bT78ul2oTQPMWpe34n7xdSs3oVQ+t8TU+n19qjXuOYbtdnjxnZF17IzSZ1tXum+D0jZ1k0a16+zQroFXDbsH7FSV7Kv7Qnqr93GrP9jro2Dl0FgSJBu+oXqXlF7ItD8kZGhSYb4g4dREaUsdJggV9637IGAM69FFdedondv+BUfNdJSmnoOPaj61+KuifSlVOcpDqKIp6Tj+hkzNedhfQCfjUOoH/6+SkTsYesFfQiWGfrRSpB35oBanuc9vWhB17V1CYdabASiX+VxUmu83vV6V78zMgCv4B&lt;/diagram&gt;&lt;/mxfile&gt;" style="background-color: rgb(255, 255, 255);"><defs/><g><rect x="0" y="0" width="500" height="500" fill="#e6e6e6" stroke="rgb(0, 0, 0)" pointer-events="all"/><rect x="70" y="410" width="76.86" height="58.12" fill="none" stroke="none" pointer-events="all"/><path d="M 123.42 468.12 L 109.01 453.05 C 108.72 452.73 108.66 452.19 109.04 451.84 L 112.89 448.53 C 113.3 448.19 113.87 448.25 114.26 448.62 L 123.3 457.81 L 140.85 436.21 C 141.31 435.71 141.96 435.82 142.35 436.06 L 146.3 439.09 C 146.86 439.57 146.85 440.06 146.52 440.46 Z M 119.12 425.26 L 119.12 416.67 L 127.31 416.67 L 127.31 425.26 Z M 82.29 436.72 L 82.29 433.86 L 110.94 433.86 L 110.94 436.72 Z M 82.29 444.36 L 82.29 441.5 L 117.08 441.5 L 117.08 444.36 Z M 70 456.77 L 70 410 L 134.46 410 L 134.46 439.08 L 131.4 442.84 L 131.4 412.86 L 73.06 412.86 L 73.06 453.9 L 106 453.9 C 106.25 454.66 107.31 455.44 108.47 456.77 Z" fill="#00ff00" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 475px; margin-left: 108px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;"><b>RESOLVED</b></div></div></div></foreignObject><text x="108" y="487" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">RESOLVED</text></switch></g><rect x="360" y="410" width="75.49" height="56.86" fill="none" stroke="none" pointer-events="all"/><path d="M 420.31 457.72 L 410.83 466.42 C 410.33 466.86 409.61 466.73 409.18 466.4 L 405.67 463.16 C 405.25 462.75 405.25 462.08 405.65 461.64 L 415.12 452.92 L 405.61 444.07 C 405.25 443.74 405.29 442.99 405.68 442.6 L 409.22 439.33 C 409.57 439.03 410.25 438.92 410.83 439.33 L 420.31 448.05 L 429.77 439.33 C 430.15 438.99 430.92 438.98 431.41 439.34 L 434.96 442.63 C 435.42 443.08 435.27 443.81 434.89 444.16 L 425.5 452.83 L 434.94 461.53 C 435.49 462.09 435.2 462.8 434.92 463.07 L 431.5 466.41 C 431.05 466.83 430.27 466.73 429.87 466.42 Z M 360 456.85 L 360 410 L 425.37 410 L 425.37 439.55 L 422.27 442.4 L 422.27 412.87 L 363.1 412.87 L 363.1 453.98 L 409.71 453.98 L 406.59 456.85 Z M 372.47 444.42 L 372.47 441.55 L 402.87 441.55 C 402.24 442.68 402.28 443.58 402.48 444.42 Z M 372.47 436.77 L 372.47 433.9 L 401.52 433.9 L 401.52 436.77 Z M 409.82 425.28 L 409.82 416.68 L 418.12 416.68 L 418.12 425.28 Z" fill="#ff0000" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 474px; margin-left: 398px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: nowrap;"><b>REJECTED</b></div></div></div></foreignObject><text x="398" y="486" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">REJECTED</text></switch></g><rect x="184.8" y="80" width="137.25" height="126.35" rx="7" ry="7" fill="#ffff00" stroke="rgb(0, 0, 0)" stroke-width="2" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 135px; height: 1px; padding-top: 143px; margin-left: 186px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;"><b>PENDING</b></div></div></div></foreignObject><text x="253" y="147" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">PENDING</text></switch></g><rect x="130" y="20" width="240" height="30" fill="none" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 238px; height: 1px; padding-top: 35px; margin-left: 131px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;"><b><font style="font-size: 24px">PROMISE OBJECT</font></b></div></div></div></foreignObject><text x="250" y="39" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">PROMISE OBJECT</text></switch></g><rect x="163.43" y="240" width="180" height="140" fill="#ffffff" stroke="rgb(0, 0, 0)" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 178px; height: 1px; padding-top: 310px; margin-left: 164px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 24px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;"><span>DID THE PROMISE FINISH RUNNING?</span></div></div></div></foreignObject><text x="253" y="317" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="24px" text-anchor="middle">DID THE PROMISE...</text></switch></g><path d="M 343.43 380 L 371.32 410" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 163.43 380 L 135.49 410" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 253.43 206.35 L 253.43 240" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/></g><switch><g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform="translate(0,-5)" xlink:href="https://www.diagrams.net/doc/faq/svg-export-text-problems" target="_blank"><text text-anchor="middle" font-size="10px" x="50%" y="100%">Text is not SVG - cannot display</text></a></switch></svg>

');
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (66, 18, 'learning', 'How do you invoke an AJAX request from jQuery?', '```
$.ajax({
  url: url,
  method: "GET", 
})
.then((result) => {
  console.log(''result:'',result);
})
.catch(err => {
  console.log(err); // related error
});
```', 1, 120, 0, 1, '');
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (51, 12, 'learning', 'What do the C.R.U.D. and B.R.E.A.D. acronyms stand for?', 'CRUD and BREAD are helpful acronyms for remembering all of the routes required in order to be able to manage entities. The B in Bread is an extra route associated with retrieving a list of all entities.

CRUD; Create. Read. Update. Delete.

BREAD; Browse. Read. Edit. Add. Delete.', 0, 120, 0, 1, '<?xml version="1.0" encoding="UTF-8"?>
<!-- Do not edit this file with editors other than diagrams.net -->
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="441px" height="361px" viewBox="-0.5 -0.5 441 361" content="&lt;mxfile host=&quot;app.diagrams.net&quot; modified=&quot;2022-03-18T01:14:17.385Z&quot; agent=&quot;5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36&quot; etag=&quot;JGpqSHvxRgMTEkttV9LB&quot; version=&quot;17.1.3&quot;&gt;&lt;diagram id=&quot;J4ghzFIDiqPk2XlFEuXc&quot; name=&quot;Page-1&quot;&gt;7Zpbb9MwFIB/TSV4GIqdNi2PvQWQmASdEOPRJCaxcOLiuLf9euzETpO43cpIG4a6i5ZzfHx8OZ8d+6w9d5ps33G0jG9ZiGkPOuG25856EAIHwp76ccJdoem7/UIRcRJqo73ijjxgU1NrVyTEWc1QMEYFWdaVAUtTHIiaDnHONnWzH4zWW12iCFuKuwBRW/uVhCIutKOBs9e/xySKTcvA0SXfUfAz4myV6vZ60A3z76I4QcaXts9iFLJNReXOe+6UMyaKp2Q7xVTNrZm2op5/pLTsN8epOKXC7iP7TMYf1uzXJn7oL9a3yWR2o72sEV1hMwyPSn+TH0y6lb0WOz1T3q8VMwU3WR7HsTQAo+V2XyifIv039/LdKKaLL9KHY/Sym2URkjPYNJemk8V8PDtkXxpzo3klNkzhEHCW7pIsx4ArkGKshoASnAskjbLXFY/FEI1TWBstFHir9LFIqFQA+ZgJzn7iKaPStztLWYrVbBBKGypESZRKMZCBwVI/WWMuiCRurAsSEoaqmckmJgLfLVGg2tzI9SV1OVFYxcwpu6Uc4O3RuIOSJrlKMUuw4DtpoisY/vT6dLW42cPeNyZxBXRP65BeX1HpeM+YfNCY/QFy0EJuamKSLVF6nLmN7p2iLmU8QdTmjmMkcCXEhcf2QiwXueP4vuO0HGc1QL03gpGRdU9BCxD06xAAaFPgHYDAPRcErgXBoj0IMArPi4Dv+3A6fdkIQKdjBPoWAl/aQ2AZnn0f8LwJ9P2XBgGoQzDqGIKBBcGsxX2A4nND4Pue/HppEDROBF7HEHhXCLqA4B+jYGhRMG6PgvDMJ4IXeihsXg06RmBkITBvEQEirgeCJxkoXw5dMfD2ejPomgHQ9anQ5AYrEEzag0DlDM95IjhDGujiBHSdHwB2lsgKDU7DsUoAqzmmKMtIkEcHcWGrK/F7fGblhPHdvTbNhW/K8s3AiLOtrllIOyNtibivPFdqSWlfSQmmTjEiHFoJ6kbY5KjZigf46V1TDj7C4hE79zAGlTAPDoTZ6DimSJB1vbuHYq9b+MRInkQ+9q4ZNvAphqlrVVPZTUeDhiPYcFTMg+UoR7Ec9l/QaaevLkTnMyh7LtEt0umdSOegUzrBkQvRn9IJmhn3wYXptDNrl6UTPIdOpzM64Yl0Dq97Zxt02im/65v9kfkanUhn/1/aO6EzeObe2XQEG47OTaedi1zkl0YHyd+PJBM2rJSSZXbsHF/Bswlk7+/P7WDYOLcD+9xe3uYu8t9dYKfxTlve//s6NpF5ciEXCF7fM0dXshT3n5opzPcfTXLnvwE=&lt;/diagram&gt;&lt;/mxfile&gt;" style="background-color: rgb(211, 211, 211);"><defs/><g><rect x="0" y="0" width="420" height="60" fill="none" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 418px; height: 1px; padding-top: 30px; margin-left: 1px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;"><font style="font-size: 18px"><b>CRUD </b>and<b> BREAD</b><br />(two acronyms for the same things)</font></div></div></div></foreignObject><text x="210" y="34" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="12px" text-anchor="middle">CRUD and BREAD...</text></switch></g><rect x="20" y="90" width="60" height="30" fill="#00ff00" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 105px; margin-left: 21px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">C<span style="font-weight: normal">reate</span></div></div></div></foreignObject><text x="50" y="110" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Create</text></switch></g><rect x="20" y="170" width="60" height="30" fill="#fff2cc" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 185px; margin-left: 21px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">R<span style="font-weight: normal">ead</span></div></div></div></foreignObject><text x="50" y="190" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Read</text></switch></g><rect x="21" y="250" width="60" height="30" fill="#66b2ff" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 265px; margin-left: 22px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">U<span style="font-weight: normal">pdate</span></div></div></div></foreignObject><text x="51" y="270" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Update</text></switch></g><rect x="20" y="330" width="60" height="30" fill="#ff6666" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 345px; margin-left: 21px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">D<span style="font-weight: normal">elete</span></div></div></div></foreignObject><text x="50" y="350" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Delete</text></switch></g><rect x="380" y="330" width="60" height="30" fill="#ff6666" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 345px; margin-left: 381px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">D<span style="font-weight: normal">elete</span></div></div></div></foreignObject><text x="410" y="350" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Delete</text></switch></g><rect x="380" y="270" width="60" height="30" fill="#00ff00" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 285px; margin-left: 381px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">A<span style="font-weight: normal">dd</span></div></div></div></foreignObject><text x="410" y="290" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Add</text></switch></g><rect x="380" y="210" width="60" height="30" fill="#66b2ff" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 225px; margin-left: 381px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">E<span style="font-weight: normal">dit</span></div></div></div></foreignObject><text x="410" y="230" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Edit</text></switch></g><rect x="380" y="150" width="60" height="30" fill="#fff2cc" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 165px; margin-left: 381px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">R<span style="font-weight: normal">ead</span></div></div></div></foreignObject><text x="410" y="170" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Read</text></switch></g><rect x="380" y="90" width="60" height="30" fill="none" stroke="none" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 105px; margin-left: 381px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; font-weight: bold; white-space: normal; overflow-wrap: normal;">B<span style="font-weight: normal">rowse</span></div></div></div></foreignObject><text x="410" y="110" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle" font-weight="bold">Browse</text></switch></g><path d="M 373.65 165.42 L 86.35 184.58" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 378.88 165.07 L 372.13 169.03 L 373.65 165.42 L 371.67 162.05 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 81.12 184.93 L 87.87 180.97 L 86.35 184.58 L 88.33 187.95 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 373.63 345 L 86.37 345" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 378.88 345 L 371.88 348.5 L 373.63 345 L 371.88 341.5 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 81.12 345 L 88.12 341.5 L 86.37 345 L 88.12 348.5 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 85.46 108.28 L 374.54 281.72" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 80.96 105.58 L 88.76 106.18 L 85.46 108.28 L 85.16 112.18 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 379.04 284.42 L 371.24 283.82 L 374.54 281.72 L 374.84 277.82 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 373.69 225.84 L 87.31 264.16" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 378.89 225.15 L 372.42 229.55 L 373.69 225.84 L 371.49 222.61 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><path d="M 82.11 264.85 L 88.58 260.45 L 87.31 264.16 L 89.51 267.39 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/><ellipse cx="240" cy="110" rx="90" ry="30" fill="rgb(255, 255, 255)" stroke="rgb(0, 0, 0)" pointer-events="all"/><g transform="translate(-0.5 -0.5)"><switch><foreignObject pointer-events="none" width="100%" height="100%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility" style="overflow: visible; text-align: left;"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 178px; height: 1px; padding-top: 110px; margin-left: 151px;"><div data-drawio-colors="color: rgb(0, 0, 0); " style="box-sizing: border-box; font-size: 0px; text-align: center;"><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Read a List</div></div></div></foreignObject><text x="240" y="115" fill="rgb(0, 0, 0)" font-family="Helvetica" font-size="18px" text-anchor="middle">Read a List</text></switch></g><path d="M 380 105 L 336.34 109.37" fill="none" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 331.11 109.89 L 337.73 105.71 L 336.34 109.37 L 338.43 112.67 Z" fill="rgb(0, 0, 0)" stroke="rgb(0, 0, 0)" stroke-miterlimit="10" pointer-events="all"/></g><switch><g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform="translate(0,-5)" xlink:href="https://www.diagrams.net/doc/faq/svg-export-text-problems" target="_blank"><text text-anchor="middle" font-size="10px" x="50%" y="100%">Text is not SVG - cannot display</text></a></switch></svg>
');
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (80, 31, 'learning', 'What is JSX?', 'JSX is a syntax that combines Javascript and HTML. For example, here is a line of valid JSX.

const simple = <h1>Hello, World!</h1>;

When you''re inside some markup, and want to include some Javascript, you need to enclose it in braces, thusly.

const simple = <h1>Hello, {planetNameVariable}!</h1>;

Adjacent HTML tags must have a parent.', 4, 120, 0, 1, '');
INSERT INTO public.objectives (id, day_id, type, question, answer, sort, total_time, parent_id, curriculum_id, svg_diagram) VALUES (161, 38, 'learning', 'adsfas', 'fdafd', 0, NULL, 0, 1, NULL);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags (id, name) VALUES (1, 'callbacks');
INSERT INTO public.tags (id, name) VALUES (2, 'promises');
INSERT INTO public.tags (id, name) VALUES (3, 'asynchronous');
INSERT INTO public.tags (id, name) VALUES (4, 'HTML');
INSERT INTO public.tags (id, name) VALUES (5, 'CSS');
INSERT INTO public.tags (id, name) VALUES (6, 'jQuery');
INSERT INTO public.tags (id, name) VALUES (7, 'React');
INSERT INTO public.tags (id, name) VALUES (8, 'Ruby');
INSERT INTO public.tags (id, name) VALUES (9, 'middleware');
INSERT INTO public.tags (id, name) VALUES (10, 'REST');
INSERT INTO public.tags (id, name) VALUES (11, 'HTTP');
INSERT INTO public.tags (id, name) VALUES (12, 'request');


--
-- Data for Name: tags_objectives; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags_objectives (id, objective_id, tag_id) VALUES (1, 55, 1);
INSERT INTO public.tags_objectives (id, objective_id, tag_id) VALUES (2, 65, 1);


--
-- Data for Name: understandings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (1, 1, 50, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (2, 1, 42, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (3, 1, 42, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (4, 1, 96, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (5, 1, 96, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (6, 1, 96, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (7, 1, 96, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (8, 1, 59, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (9, 1, 59, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (10, 1, 59, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (11, 2, 59, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (12, 2, 59, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (13, 2, 62, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (14, 2, 62, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (15, 4, 59, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (16, 4, 62, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (17, 4, 63, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (18, 4, 15, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (19, 4, 13, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (20, 4, 14, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (21, 4, 60, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (22, 4, 61, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (23, 4, 59, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (24, 4, 61, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (25, 4, 59, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (26, 4, 59, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (27, 9, 59, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (28, 9, 62, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (29, 9, 63, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (30, 13, 59, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (33, 18, 1, 0);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (34, 18, 8, 0);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (35, 21, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (36, 29, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (37, 32, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (38, 24, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (39, 29, 8, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (40, 29, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (41, 29, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (42, 29, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (43, 29, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (44, 28, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (45, 39, 1, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (46, 39, 1, 0);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (47, 29, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (48, 28, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (49, 29, 31, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (50, 29, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (51, 32, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (52, 28, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (53, 28, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (54, 34, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (55, 36, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (56, 32, 8, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (57, 28, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (58, 24, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (59, 28, 6, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (60, 29, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (61, 41, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (62, 24, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (63, 35, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (64, 32, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (65, 34, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (66, 34, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (67, 28, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (68, 26, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (69, 24, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (70, 32, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (71, 35, 8, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (72, 41, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (73, 36, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (74, 34, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (75, 41, 1, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (76, 40, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (77, 35, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (78, 40, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (79, 30, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (80, 41, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (81, 22, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (82, 32, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (83, 31, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (84, 35, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (85, 24, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (86, 41, 1, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (87, 33, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (88, 32, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (89, 28, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (90, 39, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (91, 35, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (92, 39, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (93, 26, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (94, 28, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (95, 34, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (96, 24, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (97, 33, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (98, 39, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (99, 26, 8, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (100, 39, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (101, 41, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (102, 22, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (103, 33, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (104, 39, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (105, 34, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (106, 31, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (107, 39, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (108, 35, 7, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (109, 32, 7, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (110, 25, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (111, 39, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (112, 34, 6, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (113, 26, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (114, 35, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (115, 31, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (116, 39, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (117, 35, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (118, 34, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (119, 35, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (120, 39, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (121, 36, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (122, 26, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (123, 32, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (124, 34, 31, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (125, 34, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (126, 39, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (127, 24, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (128, 36, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (129, 32, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (130, 24, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (131, 39, 30, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (132, 39, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (133, 26, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (134, 32, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (135, 35, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (136, 24, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (137, 24, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (138, 26, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (139, 24, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (140, 44, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (141, 36, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (142, 25, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (143, 34, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (144, 26, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (145, 44, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (146, 22, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (147, 36, 6, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (148, 22, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (149, 25, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (150, 26, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (151, 34, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (152, 36, 7, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (153, 40, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (154, 26, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (155, 22, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (156, 33, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (157, 26, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (158, 40, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (159, 33, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (160, 36, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (161, 40, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (162, 33, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (163, 31, 6, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (164, 22, 6, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (165, 36, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (166, 40, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (167, 33, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (168, 36, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (169, 22, 7, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (170, 40, 6, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (171, 31, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (172, 30, 8, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (173, 30, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (174, 40, 7, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (175, 40, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (176, 30, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (177, 45, 1, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (178, 40, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (179, 40, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (180, 30, 3, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (181, 30, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (182, 45, 8, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (183, 30, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (184, 22, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (185, 30, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (186, 22, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (187, 22, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (188, 31, 7, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (189, 30, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (190, 31, 31, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (191, 31, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (192, 30, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (193, 25, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (194, 31, 30, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (195, 45, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (196, 45, 4, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (197, 41, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (198, 41, 4, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (199, 41, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (200, 41, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (201, 41, 7, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (202, 19, 9, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (203, 19, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (204, 19, 9, 0);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (205, 19, 30, 0);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (206, 25, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (207, 25, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (208, 46, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (209, 46, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (210, 46, 2, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (211, 46, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (212, 46, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (213, 46, 6, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (214, 46, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (215, 28, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (216, 46, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (217, 46, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (218, 41, 30, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (219, 46, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (220, 41, 9, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (221, 41, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (222, 42, 1, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (223, 42, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (224, 42, 2, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (225, 42, 4, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (226, 42, 3, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (227, 42, 6, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (228, 42, 7, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (229, 42, 31, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (230, 42, 9, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (231, 42, 30, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (232, 1, 8, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (234, 48, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (235, 48, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (236, 51, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (237, 49, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (238, 51, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (239, 50, 112, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (240, 48, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (241, 50, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (242, 54, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (243, 53, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (244, 48, 115, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (245, 56, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (246, 53, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (247, 55, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (248, 50, 114, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (249, 62, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (250, 55, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (251, 51, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (252, 56, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (253, 51, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (254, 55, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (255, 49, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (256, 63, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (257, 62, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (258, 55, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (259, 57, 112, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (260, 58, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (261, 66, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (262, 50, 115, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (263, 69, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (264, 62, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (265, 69, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (266, 69, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (267, 69, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (268, 68, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (269, 72, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (270, 62, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (271, 64, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (272, 66, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (273, 50, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (274, 51, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (275, 50, 112, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (276, 51, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (277, 50, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (278, 50, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (279, 66, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (280, 50, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (281, 68, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (282, 74, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (283, 54, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (284, 56, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (285, 66, 115, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (286, 50, 114, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (287, 64, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (288, 50, 115, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (289, 52, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (290, 66, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (291, 72, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (292, 49, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (293, 49, 114, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (294, 49, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (295, 73, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (296, 54, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (297, 74, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (298, 72, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (299, 74, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (300, 74, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (301, 72, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (302, 61, 112, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (303, 70, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (304, 56, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (305, 70, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (306, 70, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (307, 60, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (308, 70, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (309, 54, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (310, 71, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (311, 49, 115, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (312, 71, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (313, 63, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (314, 64, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (315, 67, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (316, 53, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (317, 74, 113, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (318, 53, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (319, 53, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (320, 76, 112, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (321, 76, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (322, 64, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (323, 67, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (324, 76, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (325, 53, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (326, 53, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (327, 76, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (328, 74, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (329, 74, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (330, 63, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (331, 68, 114, 1);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (332, 68, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (333, 68, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (334, 60, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (335, 67, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (336, 67, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (337, 52, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (338, 52, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (339, 52, 114, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (340, 60, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (341, 60, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (342, 73, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (343, 73, 113, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (344, 52, 115, 2);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (345, 73, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (346, 73, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (347, 63, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (348, 71, 114, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (349, 71, 115, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (350, 58, 113, 3);
INSERT INTO public.understandings (id, user_id, objective_id, level) VALUES (351, 2, 59, 1);


--
-- Data for Name: unit_outcomes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (17, '', 1);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (34, 'Discover what templates are and why they are useful for multipage apps', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (35, 'Explore how templates are used to display the appropriate HTML for a specified route', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (36, 'Produce a functional multi-page app using a template', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (25, 'Replicate a basic HTTP web server', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (32, 'Understand how an Express app leverages asynchronous code and callbacks to set up code that will run for a given route', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (33, 'Build a multi-page web server that handles dynamic URLs', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (17, '', 1);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (34, 'Discover what templates are and why they are useful for multipage apps', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (35, 'Explore how templates are used to display the appropriate HTML for a specified route', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (36, 'Produce a functional multi-page app using a template', 25);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (25, 'Replicate a basic HTTP web server', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (32, 'Understand how an Express app leverages asynchronous code and callbacks to set up code that will run for a given route', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (33, 'Build a multi-page web server that handles dynamic URLs', 24);
INSERT INTO public.unit_outcomes (id, description, course_outcome_id) VALUES (37, 'sub thing', 24);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, email, password, admin) VALUES (2, 'sticksallison@gmail.com', '$2b$10$pDEufymxQOi3kPpUvrIaBO.J4H9v.fWs5JlS75o9MeXeROC9X5ggu', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (1, 'christian.nally@lighthouselabs.com', '$2b$10$mgnKRQpDFxTqNws71Lxl5.H7BlTIa.5UdFmDojAfKEnzgqPRT3qqG', 1);
INSERT INTO public.users (id, email, password, admin) VALUES (3, 'galianofoodgirl@gmail.com', '$2b$10$gd8u6UCo6H0koF10PALJ/uijzTeRzOLTB9dVjqGcqHk6wv.xBtzSG', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (4, 'naliano@protonmail.ch', '$2b$10$k7wWhaVMKc/mHjgukWOoAOiAW.QO4US6.rIhQOR98a1m4G7JRAF/2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (5, 'nadernasr7@gmail.com', '$2b$10$z.CdrSiQVBKGVYKFz0KZGuXZY4a2xdNJfeQVBnJ/BW3.I311SyhQC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (6, 'a@a.com', '$2b$10$JZDlCwW8.sdLoLUAkKvauOZNE6BnFfJWKeGgxd.JUHiepU7SKzIFu', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (7, 'pineapple@mail.com', '$2b$10$mFBzzCEGE4uwA23/icox/uCws3Bjq9aX6W6OnGBISbZ.rTciNrms6', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (8, 'nik@gmail.com', '$2b$10$ClD.GkLuBNmCC1dYM/IpZ.i0KF67qRrLovHx39V7quTbCaNm6Fhy6', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (9, 'lucianavivianigallo@gmail.com', '$2b$10$78SLVByXfBNLg0za6hDPSecFGy/beuSIwWUV7tDC4dZI6l4uY9rpS', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (10, 'duygu.yldrm4820@gmail.com', '$2b$10$eMiz117z8Qd0AEys1odfnOYT6JGKJReemo17f4be3tX9I40LmCo.O', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (11, 'nadi.fatah@gmail.com', '$2b$10$TNtzTyRIic9HlK/85KJmFeRlgeEj7giUmRNwYzeIrYxjNFfaLGk3S', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (12, '', '$2b$10$S8amHOAdjKRKrr6Lh4jHPOIHydSm/dN.Gm5Vk63Fp8K5vYtlZ7dlq', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (13, 'martinp0512@gmail.com', '$2b$10$fqX7sMwcN4RB17v/SiymU.EuD2zW7YYqKaiH.fKSHk7Gp8F3wu3ea', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (14, 'jessica.suzumura@aol.com', '$2b$10$94QHL3kw2xgQ/caeH.oVn.Mm8wjJT4V1zh2r9VbrCVU2BaXHqKrUy', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (15, 'abc@abcd.com', '$2b$10$jW38gfqy6Rv02syGu2NRH.8I8DRA71CeHFPP.6ZWjBVUA4akIsasO', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (16, 'hailan6257@gmail.com', '$2b$10$AxCiUNGO2buJwjFgAS39EuiFD/QLJ9Yx4SgztJHer7wRvaNMgxMpC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (17, 'sonia@gmail.com', '$2b$10$i.uxWPZXBRS0Bqf8TxDx4.meNPXZWxpNNIkD9z74Nn08N63zyrImi', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (18, 'test@example.com', '$2b$10$xh1VWKv4T133kq3NZKfBremQNzuHLjYg5LiobJQ06i.Lu6OQfLMKm', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (19, 'valhustle@gmail.com', '$2b$10$eQm58dibRAQbcS9JWsocluR2M7luJ32JebYX/Sl6S8piauB/vMLey', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (20, 'injectSQLmodules@hackthis.com', '$2b$10$.lVyfOwo0U.k/CX0Zr0k/O7yZK0FGtaXwMjBR1hXahi8jbZlb.e2C', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (21, 'a@example.com', '$2b$10$B..EGTyJSnJtzELavDU88.51cpiszh6.P9Xnfs4vDoirwqNG5ZQh2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (22, '1@a.com', '$2b$10$lhpVZZ3aUpe/EzJjZVgB2ObsuaeCt/95PlNQwjf/I10cO652O8btq', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (23, 'hi@hi.hi', '$2b$10$dTEarexkHuLXrd6udveekOzQFdxWNIzEvdzghZS/zo7BYPmiYMj/C', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (24, 'anon@gmail.com', '$2b$10$pMzr5iueJgq5u6X3aKHmjO6o3aeSDqcEE.bYaSYy5XCG.BOPjW3Bu', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (25, 'valid@email.com', '$2b$10$D53OUXJiI2hjAdCUpQuJaerDBqA4XWXYL/mywofbr7WsIe/Pkfz6m', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (26, 'email@email.com', '$2b$10$v.UhkntGVMqMxFiaoBZSoOIYE27nxOZ2CaWofqnifnqpn7mTGj/YS', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (27, 'Chcchuksng@yahoo.com', '$2b$10$8dLk9tCADpoHSOnWVDpMqOseFhg1Nb4k9YslQBKDISBw2bJfN0ay2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (28, 'kittens@kitty.ca', '$2b$10$HSVdSsDKbWrwAKyamGezC.MAsTc8uTFlc3Yx/X/T7fY3pl2a.HtFK', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (29, 'uwu@uwu.com', '$2b$10$SQ6/VzrSK7EhfTS3AB4vzemfkH8TURn5zVnQT6eGTOS1e4/7BXfHi', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (30, 'hello@hello.com', '$2b$10$XgpQX3v7MNTnUIqZ5zfMJuffujJ/wVW4CWOkhmjoCuw1wU5ZbfAgC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (31, '1@2.com', '$2b$10$GW/JV4s0u4QXcbVGAoRos.IMPHYZhUvX35ZEeuw0.cPkCEbyUcYr.', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (32, 'try2@hotmail.com', '$2b$10$BLGFHa5zBMouzpytTkf83.dFy/JPt0e6m6Sd0ltoRyNrjXmnc1g02', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (33, 'coolem@il.com', '$2b$10$16TUfrh/zCUjue9QRl9uSOOBP7R8fzAy8asiYEdxgB9iePD4cYwrm', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (34, 'elena.cherpakova@gmail.com', '$2b$10$2SalW7XL42gMfxNer2TH5en.jrFPHeuKpFGKofaZYiC8xlRy0RAwC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (35, 'hi@gmail.com', '$2b$10$hcI38mOh08oMzQzJC3EHmuuzHtlTzJExJvbXqV4uPLJDBS8bV0zTC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (36, 'gandalf@middleearth.ca', '$2b$10$vypJPR36jRrM45r8hcJqr.h72LDxio9652aiS6Mi9pr/fDDH9.2tG', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (37, 'asdf@gmail.com', '$2b$10$LUztKoLUVHBf0P0CdrEvxuVEZPjQE3POP1TqJM/RA5HOrDrqdR.DS', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (38, 'chcchuksng@yahoo.com', '$2b$10$aCowTcLBaqYJtCTL5czv9uzuX7RKzCr5wcz9sh75GDE0xBYCZzgNK', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (39, 'b@msn.com', '$2b$10$rL6.Dlkcoe3rX.DqTqYVxeF5YRRoC7ClFUruw9.JdJXL/huRbRaGa', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (40, 'database@table.com', '$2b$10$5BBPW3HD71j/JD5OV0aJ2ONxfagWmg/NOlIei8hRtCuq9azmaKgbe', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (41, 'donthephan@gmail.com', '$2b$10$gjILSvgl.sDFGsM2I2a5guUgvVMV3jEUm0Vu.C3UrOHD8XCHQ.uGO', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (42, 'mdever@live.ca', '$2b$10$EVzADftzVf24mKvp90iToOX4Kf9503bBJntx0QdK7y4/rWaLJOUIy', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (43, 'helllo@ello', '$2b$10$57ogT565G2L1e9jEFyAcIeh07s9/fXwTG6FELU3EXOkB3mmhA2U9W', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (44, 'hello@hello', '$2b$10$D/KJ0wZ2zNbLglftkM/XRep70vMh8rrAMBcKGiySZkuRPm3XGipO6', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (45, 'eight@8.com', '$2b$10$HOaqeBsa6Q6ssqTGVOgfKueOqupE4Bx0AfmI5fmx9DwNfHji7Fbym', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (46, 'goodwisheseveryone@gmail.com', '$2b$10$sDIOldFlUUbgtQZvHxvXLeRARNNlKz7rg2las1FzwhSXDS.ip2StG', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (47, 'iskrablackhold@gmail.com', '$2b$10$sZkRReEArI9/GtPxWkWr..nRJjlv8qnAHHv/Vn2TAy9tCGdaOCfri', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (48, 'christopher.neil.degroot@gmail.com', '$2b$10$brdwjMEQcfCJI8NorVt6DOzn3FXPExNJ2EOUZYhQeGxyiJx1srzv2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (49, 'rileypaul96@gmail.com', '$2b$10$27L98PwIwAwdnOIElXPbH.ojjpYjscNRt5OS2e4QLjqVgXKBdVfPi', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (50, 'lbtannahill@gmail.com', '$2b$10$lBAhIO4Lxv/vxnf2furMTuBYj35Rw0tV0J0AA0S8O1wsUJ4a9uB3C', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (51, 'mathesonchisholm@hotmail.com', '$2b$10$yguJtTEPd03mnhA2/6zkfeY1TgxreROHgDP7qRhge62VGArBvuCeK', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (52, 'brandon.dahlberg21@gmail.com', '$2b$10$0xfVhVu//xfe2mz1zTKl0.hsFa31bEqXVrgtnQ148VSoaMc6NrBI.', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (53, 'girling.christian@gmail.com', '$2b$10$sCXPJcq1Xj.DfbItP4OT0eD1hWfLvZUtl4.LiQlpjQg3FI2ARtsE2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (54, 'jlin9702@gmail.com', '$2b$10$n1ABhkOO2fhyCHvmRYnzo.vAhAkVtvtKwjMwjt7jf47rZ8kjrB5s.', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (55, 'john.chia0106@gmail.com', '$2b$10$NSgImMhsrnQo0xOD8vpWKOz9bRAW1orsLFJsC/xJXiwPwe2is9uKi', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (56, 'christopherwrose2@gmail.com', '$2b$10$vApSXjxJw3zQtySTk9mfiu0M1BG.FBn3GEDlYa4LDFWUbxfPnbYgm', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (57, 't.jamesphan@gmail.com', '$2b$10$jQgJhjBFlbJzry6C.4O9yuKDP7Q7kCmg2IiKMzn5ntuXy9cMi9N62', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (58, 'ayaaa.okzk@gmail.com', '$2b$10$IYmMDLmb1nZsZunLvuVGce4yLmhAA5NAFH4YBvnKVdvE1sULFpuQO', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (59, 'mawilliamson10@gmail.com', '$2b$10$3O./vv.D3i3rnjJbWcoUT..66lgZOdiyayI1cn/heLmvpitJUdkRG', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (60, 'thomasngo818@gmail.com', '$2b$10$8387RtCIVEBwTDneGSXB7.jrnb8LvaVEqtmnv6G7NUMsKH.Yqawzy', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (61, 'millanbob@hotmail.com', '$2b$10$j.Pr5WvmiN6DMqJAFpi5zeSq4az9kbgFrB5iMBmQSeAfGG03pWgOC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (62, 'jordan.benson4@gmail.com', '$2b$10$0UlrPoHh/fzG.wxfXC532O/RS1WQ6.SlNg0T19fkQNDavYBT9wpFC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (63, 'jianicakes@gmail.com', '$2b$10$OGysxyZpUZbiQzibJweU7uSRyBNXzQWdwVdnHZNzMETu3hd23tIYi', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (64, 'gleb.shkut@gmail.com', '$2b$10$IUB4/puBiwv9T/.3GoFQaemt03yssOYamxUIyJFHyvs0eMoVmvJxm', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (65, 'bshin132@gmail.com', '$2b$10$d45.GZJdBZT8qzzQvXy0o.kuxSMXKS6S0hsP7QwVe8RAzEN5YT.NK', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (66, 'chrisbeckertonbell@gmail.com', '$2b$10$n63Okd2jsn505fgthDjhmegIFJ9HT8XvzTMO5yObR.VyJh6n0zHme', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (67, 'loganwoolf@gmail.com', '$2b$10$hMzHLv7eY7fSxFvoOEjLqu.cUHc6VQlCPgIeMPMcmoDP182pto9g2', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (68, 'xinyuchen98@gmail.com', '$2b$10$JpaCWRb8wnUifjP5eQet5.mtutkNFDZ9L4eXWTGvilmeG54q5enUe', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (69, 'adrianetodesign@gmail.com', '$2b$10$qeZTE/fewmeTefT/ffPz1.pLC0Xhgt1bvJh0LUw2XrYr3UkQQigNe', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (70, 'abc@abc.com', '$2b$10$1zJnDkpxWjRvwW4dIq6td.1QFjXixMxBp8ltv9m0FgXEmJVV7.B4G', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (71, 'leepavelich@gmail.com', '$2b$10$yMJsBaYKR6zah4gvS.HALe2SvQn9ffJfTrBQvm.TJZpv5HytbmvfO', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (72, 'blake.sartin8@gmail.com', '$2b$10$OMzeoTwsOgvaP7Xne.UQy.P9SqNaG1FCK1.i3Bl.nQeM4u00Uf.Kq', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (73, 'albertcyi.ho@gmail.com', '$2b$10$dYKoY.llj8oJVLrhqTJz0OQmn0Y93erkvufz7PIYtQVvD5d8Twwb6', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (74, 'olivia.cowan@hotmail.com', '$2b$10$mjLo2GI5xqoWp4gp6IOqgO9dlcG2XG5GAKvWQETa6xLV07QyCxgRC', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (75, 'albertho5348@gmail.com', '$2b$10$KXIM9Khb/8ye82t8E6HIZObUyLUReqX6XkZY2pUZLDWI8R6n6eMPS', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (76, 'noah@noahvandenberg.com', '$2b$10$fWPswLOh7t5rGuE5kzC8MOSq36ueWr.g8Q58RvrK0Xsske6TlBgPe', 0);
INSERT INTO public.users (id, email, password, admin) VALUES (77, 'hatcherchris20@gmail.com', '$2b$10$3/0X5HfaWD5b.vm/E.oeCePRxxlOiq2VPYlZCvUECFnFx4R6UwaDq', 0);


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_seq', 1, false);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 1, true);


--
-- Name: curricula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curricula_id_seq', 2, true);


--
-- Name: days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.days_id_seq', 26, true);


--
-- Name: objectives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.objectives_id_seq', 163, true);


--
-- Name: outcomes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.outcomes_id_seq', 31, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 15, true);


--
-- Name: tags_objectives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_objectives_id_seq', 2, true);


--
-- Name: understandings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.understandings_id_seq', 351, true);


--
-- Name: unit_outcomes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_outcomes_id_seq', 37, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 77, true);


--
-- Name: days days_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.days
    ADD CONSTRAINT days_pkey PRIMARY KEY (id);


--
-- Name: objectives objectives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.objectives
    ADD CONSTRAINT objectives_pkey PRIMARY KEY (id);


--
-- Name: course_outcomes outcomes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_outcomes
    ADD CONSTRAINT outcomes_pkey PRIMARY KEY (id);


--
-- Name: understandings understandings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.understandings
    ADD CONSTRAINT understandings_pkey PRIMARY KEY (id);


--
-- Name: curricula unique_curricula_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curricula
    ADD CONSTRAINT unique_curricula_id UNIQUE (id);


--
-- Name: tags unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- Name: tags_objectives unique_tags_objectives_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags_objectives
    ADD CONSTRAINT unique_tags_objectives_id UNIQUE (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: understandings fk_objective; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.understandings
    ADD CONSTRAINT fk_objective FOREIGN KEY (objective_id) REFERENCES public.objectives(id);


--
-- Name: understandings fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.understandings
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

