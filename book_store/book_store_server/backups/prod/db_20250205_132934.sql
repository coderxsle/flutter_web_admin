--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id bigint NOT NULL,
    name text NOT NULL,
    isbn text,
    author text DEFAULT ''::text NOT NULL,
    keyword text DEFAULT ''::text NOT NULL,
    publisher text DEFAULT ''::text NOT NULL,
    image text DEFAULT ''::text NOT NULL,
    "originalPrice" double precision NOT NULL,
    "purchasePrice" double precision,
    "salePrice" double precision,
    "promotionPrice" double precision,
    inventory bigint DEFAULT 0 NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL,
    "activityId" bigint,
    category text,
    "categoryId" bigint,
    status bigint
);


ALTER TABLE public.book OWNER TO postgres;

--
-- Name: book_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_category (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.book_category OWNER TO postgres;

--
-- Name: book_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_category_id_seq OWNER TO postgres;

--
-- Name: book_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_category_id_seq OWNED BY public.book_category.id;


--
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_id_seq OWNER TO postgres;

--
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- Name: book_package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_package (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    "bundlePrice" double precision NOT NULL,
    "originalPrice" double precision NOT NULL,
    "discountRate" double precision DEFAULT 1.0 NOT NULL,
    "contentDescription" text DEFAULT ''::text NOT NULL,
    status bigint DEFAULT 0 NOT NULL,
    "startTime" timestamp without time zone,
    "endTime" timestamp without time zone,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.book_package OWNER TO postgres;

--
-- Name: book_package_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_package_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_package_id_seq OWNER TO postgres;

--
-- Name: book_package_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_package_id_seq OWNED BY public.book_package.id;


--
-- Name: book_package_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_package_item (
    id bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "packageId" bigint NOT NULL,
    quantity bigint DEFAULT 1 NOT NULL,
    "packagePrice" double precision NOT NULL,
    "originalPrice" double precision NOT NULL,
    "discountRate" double precision DEFAULT 1.0 NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.book_package_item OWNER TO postgres;

--
-- Name: book_package_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_package_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_package_item_id_seq OWNER TO postgres;

--
-- Name: book_package_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_package_item_id_seq OWNED BY public.book_package_item.id;


--
-- Name: book_sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_sale (
    id bigint NOT NULL,
    "saleType" bigint NOT NULL,
    "bookPackageId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "categoryId" bigint NOT NULL,
    quantity bigint NOT NULL,
    "salePrice" double precision NOT NULL,
    "saleTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.book_sale OWNER TO postgres;

--
-- Name: book_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_sale_id_seq OWNER TO postgres;

--
-- Name: book_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_sale_id_seq OWNED BY public.book_sale.id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id bigint NOT NULL,
    "userName" text DEFAULT ''::text NOT NULL,
    password text DEFAULT ''::text NOT NULL,
    nickname text DEFAULT ''::text NOT NULL,
    phone text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    status bigint DEFAULT 0 NOT NULL,
    "memberLevel" bigint DEFAULT 0 NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_id_seq OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- Name: dict_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dict_item (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    sn bigint DEFAULT 0 NOT NULL,
    disabled bigint DEFAULT 0 NOT NULL,
    "typeId" bigint DEFAULT 0 NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dict_item OWNER TO postgres;

--
-- Name: dict_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dict_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dict_item_id_seq OWNER TO postgres;

--
-- Name: dict_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dict_item_id_seq OWNED BY public.dict_item.id;


--
-- Name: dict_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dict_type (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    intro text DEFAULT ''::text NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dict_type OWNER TO postgres;

--
-- Name: dict_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dict_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dict_type_id_seq OWNER TO postgres;

--
-- Name: dict_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dict_type_id_seq OWNED BY public.dict_type.id;


--
-- Name: inventory_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_log (
    id bigint NOT NULL,
    "bookId" bigint NOT NULL,
    quantity bigint NOT NULL,
    "changeType" bigint NOT NULL,
    "changeTime" timestamp without time zone NOT NULL,
    description text,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.inventory_log OWNER TO postgres;

--
-- Name: inventory_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_log_id_seq OWNER TO postgres;

--
-- Name: inventory_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_log_id_seq OWNED BY public.inventory_log.id;


--
-- Name: party; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    latitude double precision,
    longitude double precision,
    address text,
    capacity bigint,
    "creatorId" bigint,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.party OWNER TO postgres;

--
-- Name: party_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.party_id_seq OWNER TO postgres;

--
-- Name: party_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.party_id_seq OWNED BY public.party.id;


--
-- Name: promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion (
    id bigint NOT NULL,
    name text NOT NULL,
    type bigint NOT NULL,
    "discountRate" double precision,
    "startTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description text,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.promotion OWNER TO postgres;

--
-- Name: promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotion_id_seq OWNER TO postgres;

--
-- Name: promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promotion_id_seq OWNED BY public.promotion.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    pinyin text DEFAULT ''::text NOT NULL,
    "parentId" bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_id_seq OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;


--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permission (
    id bigint NOT NULL,
    "roleId" bigint NOT NULL,
    "permissionKey" text NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.role_permission OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_permission_id_seq OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permission_id_seq OWNED BY public.role_permission.id;


--
-- Name: serverpod_cloud_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_cloud_storage (
    id bigint NOT NULL,
    "storageId" text NOT NULL,
    path text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    expiration timestamp without time zone,
    "byteData" bytea NOT NULL,
    verified boolean NOT NULL
);


ALTER TABLE public.serverpod_cloud_storage OWNER TO postgres;

--
-- Name: serverpod_cloud_storage_direct_upload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_cloud_storage_direct_upload (
    id bigint NOT NULL,
    "storageId" text NOT NULL,
    path text NOT NULL,
    expiration timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);


ALTER TABLE public.serverpod_cloud_storage_direct_upload OWNER TO postgres;

--
-- Name: serverpod_cloud_storage_direct_upload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_cloud_storage_direct_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_cloud_storage_direct_upload_id_seq OWNER TO postgres;

--
-- Name: serverpod_cloud_storage_direct_upload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_cloud_storage_direct_upload_id_seq OWNED BY public.serverpod_cloud_storage_direct_upload.id;


--
-- Name: serverpod_cloud_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_cloud_storage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_cloud_storage_id_seq OWNER TO postgres;

--
-- Name: serverpod_cloud_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_cloud_storage_id_seq OWNED BY public.serverpod_cloud_storage.id;


--
-- Name: serverpod_future_call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_future_call (
    id bigint NOT NULL,
    name text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    identifier text
);


ALTER TABLE public.serverpod_future_call OWNER TO postgres;

--
-- Name: serverpod_future_call_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_future_call_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_future_call_id_seq OWNER TO postgres;

--
-- Name: serverpod_future_call_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_future_call_id_seq OWNED BY public.serverpod_future_call.id;


--
-- Name: serverpod_health_connection_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_health_connection_info (
    id bigint NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    active bigint NOT NULL,
    closing bigint NOT NULL,
    idle bigint NOT NULL,
    granularity bigint NOT NULL
);


ALTER TABLE public.serverpod_health_connection_info OWNER TO postgres;

--
-- Name: serverpod_health_connection_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_health_connection_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_health_connection_info_id_seq OWNER TO postgres;

--
-- Name: serverpod_health_connection_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_health_connection_info_id_seq OWNED BY public.serverpod_health_connection_info.id;


--
-- Name: serverpod_health_metric; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_health_metric (
    id bigint NOT NULL,
    name text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    value double precision NOT NULL,
    granularity bigint NOT NULL
);


ALTER TABLE public.serverpod_health_metric OWNER TO postgres;

--
-- Name: serverpod_health_metric_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_health_metric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_health_metric_id_seq OWNER TO postgres;

--
-- Name: serverpod_health_metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_health_metric_id_seq OWNED BY public.serverpod_health_metric.id;


--
-- Name: serverpod_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_log (
    id bigint NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    reference text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    message text NOT NULL,
    error text,
    "stackTrace" text,
    "order" bigint NOT NULL
);


ALTER TABLE public.serverpod_log OWNER TO postgres;

--
-- Name: serverpod_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_log_id_seq OWNER TO postgres;

--
-- Name: serverpod_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_log_id_seq OWNED BY public.serverpod_log.id;


--
-- Name: serverpod_message_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_message_log (
    id bigint NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    endpoint text NOT NULL,
    "messageName" text NOT NULL,
    duration double precision NOT NULL,
    error text,
    "stackTrace" text,
    slow boolean NOT NULL,
    "order" bigint NOT NULL
);


ALTER TABLE public.serverpod_message_log OWNER TO postgres;

--
-- Name: serverpod_message_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_message_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_message_log_id_seq OWNER TO postgres;

--
-- Name: serverpod_message_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_message_log_id_seq OWNED BY public.serverpod_message_log.id;


--
-- Name: serverpod_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_method (
    id bigint NOT NULL,
    endpoint text NOT NULL,
    method text NOT NULL
);


ALTER TABLE public.serverpod_method OWNER TO postgres;

--
-- Name: serverpod_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_method_id_seq OWNER TO postgres;

--
-- Name: serverpod_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_method_id_seq OWNED BY public.serverpod_method.id;


--
-- Name: serverpod_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_migrations (
    id bigint NOT NULL,
    module text NOT NULL,
    version text NOT NULL,
    "timestamp" timestamp without time zone
);


ALTER TABLE public.serverpod_migrations OWNER TO postgres;

--
-- Name: serverpod_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_migrations_id_seq OWNER TO postgres;

--
-- Name: serverpod_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_migrations_id_seq OWNED BY public.serverpod_migrations.id;


--
-- Name: serverpod_query_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_query_log (
    id bigint NOT NULL,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    query text NOT NULL,
    duration double precision NOT NULL,
    "numRows" bigint,
    error text,
    "stackTrace" text,
    slow boolean NOT NULL,
    "order" bigint NOT NULL
);


ALTER TABLE public.serverpod_query_log OWNER TO postgres;

--
-- Name: serverpod_query_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_query_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_query_log_id_seq OWNER TO postgres;

--
-- Name: serverpod_query_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_query_log_id_seq OWNED BY public.serverpod_query_log.id;


--
-- Name: serverpod_readwrite_test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_readwrite_test (
    id bigint NOT NULL,
    number bigint NOT NULL
);


ALTER TABLE public.serverpod_readwrite_test OWNER TO postgres;

--
-- Name: serverpod_readwrite_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_readwrite_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_readwrite_test_id_seq OWNER TO postgres;

--
-- Name: serverpod_readwrite_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_readwrite_test_id_seq OWNED BY public.serverpod_readwrite_test.id;


--
-- Name: serverpod_runtime_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_runtime_settings (
    id bigint NOT NULL,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);


ALTER TABLE public.serverpod_runtime_settings OWNER TO postgres;

--
-- Name: serverpod_runtime_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_runtime_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_runtime_settings_id_seq OWNER TO postgres;

--
-- Name: serverpod_runtime_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_runtime_settings_id_seq OWNED BY public.serverpod_runtime_settings.id;


--
-- Name: serverpod_session_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverpod_session_log (
    id bigint NOT NULL,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    module text,
    endpoint text,
    method text,
    duration double precision,
    "numQueries" bigint,
    slow boolean,
    error text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    touched timestamp without time zone NOT NULL
);


ALTER TABLE public.serverpod_session_log OWNER TO postgres;

--
-- Name: serverpod_session_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serverpod_session_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serverpod_session_log_id_seq OWNER TO postgres;

--
-- Name: serverpod_session_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serverpod_session_log_id_seq OWNED BY public.serverpod_session_log.id;


--
-- Name: sys_operation_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_operation_log (
    id bigint NOT NULL,
    "tableNameStr" text DEFAULT ''::text NOT NULL,
    "operationType" bigint DEFAULT 0 NOT NULL,
    "recordId" bigint,
    "oldData" text DEFAULT ''::text NOT NULL,
    "newData" text DEFAULT ''::text NOT NULL,
    "operatorId" bigint DEFAULT 0 NOT NULL,
    "operationTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.sys_operation_log OWNER TO postgres;

--
-- Name: sys_operation_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_operation_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_operation_log_id_seq OWNER TO postgres;

--
-- Name: sys_operation_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_operation_log_id_seq OWNED BY public.sys_operation_log.id;


--
-- Name: sys_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_resource (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    uri text DEFAULT ''::text NOT NULL,
    permission text DEFAULT ''::text NOT NULL,
    type bigint DEFAULT 0 NOT NULL,
    icon text DEFAULT ''::text NOT NULL,
    sn bigint DEFAULT 0 NOT NULL,
    "parentId" bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.sys_resource OWNER TO postgres;

--
-- Name: sys_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_resource_id_seq OWNER TO postgres;

--
-- Name: sys_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_resource_id_seq OWNED BY public.sys_resource.id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- Name: sys_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_role_id_seq OWNER TO postgres;

--
-- Name: sys_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_id_seq OWNED BY public.sys_role.id;


--
-- Name: sys_role_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_resource (
    id bigint NOT NULL,
    "roleId" bigint DEFAULT 0 NOT NULL,
    "resourceId" bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.sys_role_resource OWNER TO postgres;

--
-- Name: sys_role_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_role_resource_id_seq OWNER TO postgres;

--
-- Name: sys_role_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_resource_id_seq OWNED BY public.sys_role_resource.id;


--
-- Name: sys_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user (
    id bigint NOT NULL,
    truename text DEFAULT ''::text NOT NULL,
    nickname text DEFAULT ''::text NOT NULL,
    username text DEFAULT ''::text NOT NULL,
    password text DEFAULT ''::text NOT NULL,
    phone text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    avatar text,
    roles text,
    permissions text,
    "creatorId" bigint DEFAULT 0 NOT NULL,
    "createTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "loginTime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status bigint DEFAULT 0 NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- Name: sys_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_user_id_seq OWNER TO postgres;

--
-- Name: sys_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_id_seq OWNED BY public.sys_user.id;


--
-- Name: sys_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_role (
    id bigint NOT NULL,
    "roleId" bigint DEFAULT 0 NOT NULL,
    "userId" bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.sys_user_role OWNER TO postgres;

--
-- Name: sys_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_user_role_id_seq OWNER TO postgres;

--
-- Name: sys_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_role_id_seq OWNED BY public.sys_user_role.id;


--
-- Name: book id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- Name: book_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category ALTER COLUMN id SET DEFAULT nextval('public.book_category_id_seq'::regclass);


--
-- Name: book_package id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_package ALTER COLUMN id SET DEFAULT nextval('public.book_package_id_seq'::regclass);


--
-- Name: book_package_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_package_item ALTER COLUMN id SET DEFAULT nextval('public.book_package_item_id_seq'::regclass);


--
-- Name: book_sale id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_sale ALTER COLUMN id SET DEFAULT nextval('public.book_sale_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- Name: dict_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dict_item ALTER COLUMN id SET DEFAULT nextval('public.dict_item_id_seq'::regclass);


--
-- Name: dict_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dict_type ALTER COLUMN id SET DEFAULT nextval('public.dict_type_id_seq'::regclass);


--
-- Name: inventory_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_log ALTER COLUMN id SET DEFAULT nextval('public.inventory_log_id_seq'::regclass);


--
-- Name: party id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party ALTER COLUMN id SET DEFAULT nextval('public.party_id_seq'::regclass);


--
-- Name: promotion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion ALTER COLUMN id SET DEFAULT nextval('public.promotion_id_seq'::regclass);


--
-- Name: region id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- Name: role_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission ALTER COLUMN id SET DEFAULT nextval('public.role_permission_id_seq'::regclass);


--
-- Name: serverpod_cloud_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_cloud_storage ALTER COLUMN id SET DEFAULT nextval('public.serverpod_cloud_storage_id_seq'::regclass);


--
-- Name: serverpod_cloud_storage_direct_upload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_cloud_storage_direct_upload ALTER COLUMN id SET DEFAULT nextval('public.serverpod_cloud_storage_direct_upload_id_seq'::regclass);


--
-- Name: serverpod_future_call id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_future_call ALTER COLUMN id SET DEFAULT nextval('public.serverpod_future_call_id_seq'::regclass);


--
-- Name: serverpod_health_connection_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_health_connection_info ALTER COLUMN id SET DEFAULT nextval('public.serverpod_health_connection_info_id_seq'::regclass);


--
-- Name: serverpod_health_metric id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_health_metric ALTER COLUMN id SET DEFAULT nextval('public.serverpod_health_metric_id_seq'::regclass);


--
-- Name: serverpod_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_log ALTER COLUMN id SET DEFAULT nextval('public.serverpod_log_id_seq'::regclass);


--
-- Name: serverpod_message_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_message_log ALTER COLUMN id SET DEFAULT nextval('public.serverpod_message_log_id_seq'::regclass);


--
-- Name: serverpod_method id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_method ALTER COLUMN id SET DEFAULT nextval('public.serverpod_method_id_seq'::regclass);


--
-- Name: serverpod_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_migrations ALTER COLUMN id SET DEFAULT nextval('public.serverpod_migrations_id_seq'::regclass);


--
-- Name: serverpod_query_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_query_log ALTER COLUMN id SET DEFAULT nextval('public.serverpod_query_log_id_seq'::regclass);


--
-- Name: serverpod_readwrite_test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_readwrite_test ALTER COLUMN id SET DEFAULT nextval('public.serverpod_readwrite_test_id_seq'::regclass);


--
-- Name: serverpod_runtime_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_runtime_settings ALTER COLUMN id SET DEFAULT nextval('public.serverpod_runtime_settings_id_seq'::regclass);


--
-- Name: serverpod_session_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_session_log ALTER COLUMN id SET DEFAULT nextval('public.serverpod_session_log_id_seq'::regclass);


--
-- Name: sys_operation_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_operation_log ALTER COLUMN id SET DEFAULT nextval('public.sys_operation_log_id_seq'::regclass);


--
-- Name: sys_resource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_resource ALTER COLUMN id SET DEFAULT nextval('public.sys_resource_id_seq'::regclass);


--
-- Name: sys_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN id SET DEFAULT nextval('public.sys_role_id_seq'::regclass);


--
-- Name: sys_role_resource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_resource ALTER COLUMN id SET DEFAULT nextval('public.sys_role_resource_id_seq'::regclass);


--
-- Name: sys_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);


--
-- Name: sys_user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role ALTER COLUMN id SET DEFAULT nextval('public.sys_user_role_id_seq'::regclass);


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (id, name, isbn, author, keyword, publisher, image, "originalPrice", "purchasePrice", "salePrice", "promotionPrice", inventory, "createTime", "updateTime", "isDeleted", "activityId", category, "categoryId", status) FROM stdin;
\.


--
-- Data for Name: book_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_category (id, name, description, "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: book_package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_package (id, name, "bundlePrice", "originalPrice", "discountRate", "contentDescription", status, "startTime", "endTime", "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: book_package_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_package_item (id, "bookId", "packageId", quantity, "packagePrice", "originalPrice", "discountRate", "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: book_sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_sale (id, "saleType", "bookPackageId", "bookId", "categoryId", quantity, "salePrice", "saleTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id, "userName", password, nickname, phone, email, status, "memberLevel", "createTime", "updateTime") FROM stdin;
\.


--
-- Data for Name: dict_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dict_item (id, name, value, sn, disabled, "typeId", "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: dict_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dict_type (id, name, value, intro, "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: inventory_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_log (id, "bookId", quantity, "changeType", "changeTime", description, "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: party; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party (id, name, latitude, longitude, address, capacity, "creatorId", "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion (id, name, type, "discountRate", "startTime", "endTime", description, "createTime", "updateTime", "isDeleted") FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id, name, pinyin, "parentId") FROM stdin;
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permission (id, "roleId", "permissionKey", "createTime", "updateTime") FROM stdin;
\.


--
-- Data for Name: serverpod_cloud_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_cloud_storage (id, "storageId", path, "addedTime", expiration, "byteData", verified) FROM stdin;
\.


--
-- Data for Name: serverpod_cloud_storage_direct_upload; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_cloud_storage_direct_upload (id, "storageId", path, expiration, "authKey") FROM stdin;
\.


--
-- Data for Name: serverpod_future_call; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_future_call (id, name, "time", "serializedObject", "serverId", identifier) FROM stdin;
\.


--
-- Data for Name: serverpod_health_connection_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_health_connection_info (id, "serverId", "timestamp", active, closing, idle, granularity) FROM stdin;
1	default	2025-02-05 01:39:00	0	0	0	1
2	default	2025-02-05 01:40:00	0	0	0	1
3	default	2025-02-05 01:41:00	0	0	0	1
4	default	2025-02-05 01:42:00	0	0	0	1
5	default	2025-02-05 01:43:00	0	0	0	1
6	default	2025-02-05 01:44:00	0	0	0	1
7	default	2025-02-05 01:45:00	0	0	0	1
8	default	2025-02-05 01:46:00	0	0	0	1
9	default	2025-02-05 01:47:00	0	0	0	1
10	default	2025-02-05 01:48:00	0	0	0	1
11	default	2025-02-05 01:49:00	0	0	0	1
12	default	2025-02-05 01:50:00	0	0	0	1
13	default	2025-02-05 01:51:00	0	0	0	1
14	default	2025-02-05 01:52:00	0	0	0	1
15	default	2025-02-05 01:53:00	0	0	0	1
16	default	2025-02-05 01:54:00	0	0	0	1
17	default	2025-02-05 01:55:00	0	0	0	1
18	default	2025-02-05 01:56:00	0	0	0	1
19	default	2025-02-05 01:57:00	0	0	0	1
20	default	2025-02-05 01:58:00	0	0	0	1
21	default	2025-02-05 01:59:00	0	0	0	1
22	default	2025-02-05 02:00:00	0	0	0	1
23	default	2025-02-05 02:01:00	0	0	0	1
24	default	2025-02-05 02:02:00	0	0	0	1
25	default	2025-02-05 02:03:00	0	0	0	1
26	default	2025-02-05 02:04:00	0	0	0	1
27	default	2025-02-05 02:05:00	0	0	0	1
28	default	2025-02-05 02:06:00	0	0	0	1
29	default	2025-02-05 02:07:00	0	0	0	1
30	default	2025-02-05 02:08:00	0	0	0	1
31	default	2025-02-05 02:09:00	0	0	0	1
32	default	2025-02-05 02:10:00	0	0	0	1
33	default	2025-02-05 02:11:00	0	0	0	1
34	default	2025-02-05 02:12:00	0	0	0	1
35	default	2025-02-05 02:13:00	0	0	0	1
36	default	2025-02-05 02:14:00	0	0	0	1
37	default	2025-02-05 02:16:00	0	0	0	1
38	default	2025-02-05 02:20:00	0	0	0	1
39	default	2025-02-05 02:21:00	0	0	0	1
40	default	2025-02-05 02:22:00	0	0	0	1
41	default	2025-02-05 02:23:00	0	0	0	1
42	default	2025-02-05 02:24:00	0	0	0	1
43	default	2025-02-05 02:25:00	0	0	0	1
44	default	2025-02-05 02:26:00	0	0	0	1
45	default	2025-02-05 02:27:00	0	0	0	1
46	default	2025-02-05 02:28:00	0	0	0	1
47	default	2025-02-05 02:29:00	0	0	0	1
48	default	2025-02-05 02:30:00	0	0	0	1
49	default	2025-02-05 02:31:00	0	0	0	1
50	default	2025-02-05 02:32:00	0	0	0	1
51	default	2025-02-05 02:33:00	0	0	0	1
52	default	2025-02-05 02:34:00	0	0	0	1
53	default	2025-02-05 02:35:00	0	0	0	1
54	default	2025-02-05 02:36:00	0	0	0	1
55	default	2025-02-05 02:37:00	0	0	0	1
56	default	2025-02-05 02:38:00	0	0	0	1
57	default	2025-02-05 02:39:00	0	0	0	1
58	default	2025-02-05 02:40:00	0	0	0	1
59	default	2025-02-05 02:41:00	0	0	0	1
60	default	2025-02-05 02:42:00	0	0	0	1
61	default	2025-02-05 02:43:00	0	0	0	1
62	default	2025-02-05 02:44:00	0	0	0	1
63	default	2025-02-05 02:45:00	0	0	0	1
64	default	2025-02-05 02:46:00	0	0	0	1
65	default	2025-02-05 02:47:00	0	0	0	1
66	default	2025-02-05 02:48:00	0	0	0	1
67	default	2025-02-05 02:49:00	0	0	0	1
68	default	2025-02-05 02:50:00	0	0	0	1
69	default	2025-02-05 02:51:00	0	0	0	1
70	default	2025-02-05 02:52:00	0	0	0	1
71	default	2025-02-05 02:53:00	0	0	0	1
72	default	2025-02-05 02:54:00	0	0	0	1
73	default	2025-02-05 02:55:00	0	0	0	1
74	default	2025-02-05 02:56:00	0	0	0	1
75	default	2025-02-05 02:57:00	0	0	0	1
76	default	2025-02-05 02:58:00	0	0	0	1
77	default	2025-02-05 02:59:00	0	0	0	1
78	default	2025-02-05 03:00:00	0	0	0	1
79	default	2025-02-05 03:01:00	0	0	0	1
80	default	2025-02-05 03:02:00	0	0	0	1
81	default	2025-02-05 03:03:00	0	0	0	1
82	default	2025-02-05 03:04:00	0	0	0	1
83	default	2025-02-05 03:05:00	0	0	0	1
84	default	2025-02-05 03:06:00	0	0	0	1
85	default	2025-02-05 03:07:00	0	0	0	1
86	default	2025-02-05 03:08:00	0	0	0	1
87	default	2025-02-05 03:09:00	0	0	0	1
88	default	2025-02-05 03:10:00	0	0	0	1
89	default	2025-02-05 03:11:00	0	0	0	1
90	default	2025-02-05 03:12:00	0	0	0	1
91	default	2025-02-05 03:13:00	0	0	0	1
92	default	2025-02-05 03:14:00	0	0	0	1
93	default	2025-02-05 03:15:00	0	0	0	1
94	default	2025-02-05 03:16:00	0	0	0	1
95	default	2025-02-05 03:17:00	0	0	0	1
96	default	2025-02-05 03:18:00	0	0	0	1
97	default	2025-02-05 03:19:00	0	0	0	1
98	default	2025-02-05 03:20:00	0	0	0	1
99	default	2025-02-05 03:21:00	0	0	0	1
100	default	2025-02-05 03:22:00	0	0	0	1
101	default	2025-02-05 03:23:00	0	0	0	1
102	default	2025-02-05 03:24:00	0	0	0	1
103	default	2025-02-05 03:25:00	0	0	0	1
104	default	2025-02-05 03:26:00	0	0	0	1
105	default	2025-02-05 03:27:00	0	0	0	1
106	default	2025-02-05 03:28:00	0	0	0	1
107	default	2025-02-05 03:29:00	0	0	0	1
108	default	2025-02-05 03:30:00	0	0	0	1
109	default	2025-02-05 03:31:00	0	0	0	1
110	default	2025-02-05 03:32:00	0	0	0	1
111	default	2025-02-05 03:33:00	0	0	0	1
112	default	2025-02-05 03:34:00	0	0	0	1
113	default	2025-02-05 03:35:00	0	0	0	1
114	default	2025-02-05 03:36:00	0	0	0	1
115	default	2025-02-05 03:37:00	0	0	0	1
116	default	2025-02-05 03:38:00	0	0	0	1
117	default	2025-02-05 03:39:00	0	0	0	1
118	default	2025-02-05 03:40:00	0	0	0	1
119	default	2025-02-05 03:41:00	0	0	0	1
120	default	2025-02-05 03:42:00	0	0	0	1
121	default	2025-02-05 03:43:00	0	0	0	1
122	default	2025-02-05 03:44:00	0	0	0	1
123	default	2025-02-05 03:45:00	0	0	0	1
124	default	2025-02-05 03:46:00	0	0	0	1
125	default	2025-02-05 03:47:00	0	0	0	1
126	default	2025-02-05 03:48:00	0	0	0	1
127	default	2025-02-05 03:49:00	0	0	0	1
128	default	2025-02-05 03:50:00	0	0	0	1
129	default	2025-02-05 03:51:00	0	0	0	1
130	default	2025-02-05 03:52:00	0	0	0	1
131	default	2025-02-05 03:53:00	0	0	0	1
132	default	2025-02-05 03:54:00	0	0	0	1
133	default	2025-02-05 03:55:00	0	0	0	1
134	default	2025-02-05 03:56:00	0	0	0	1
135	default	2025-02-05 03:57:00	0	0	0	1
136	default	2025-02-05 03:58:00	0	0	0	1
137	default	2025-02-05 03:59:00	0	0	0	1
138	default	2025-02-05 04:00:00	0	0	0	1
139	default	2025-02-05 04:01:00	0	0	0	1
140	default	2025-02-05 04:02:00	0	0	0	1
141	default	2025-02-05 04:03:00	0	0	0	1
142	default	2025-02-05 04:04:00	0	0	0	1
143	default	2025-02-05 04:05:00	0	0	0	1
144	default	2025-02-05 04:06:00	0	0	0	1
145	default	2025-02-05 04:07:00	0	0	0	1
146	default	2025-02-05 04:08:00	0	0	0	1
147	default	2025-02-05 04:09:00	0	0	0	1
148	default	2025-02-05 04:10:00	0	0	0	1
149	default	2025-02-05 04:11:00	0	0	0	1
150	default	2025-02-05 04:12:00	0	0	0	1
151	default	2025-02-05 04:13:00	0	0	0	1
152	default	2025-02-05 04:14:00	0	0	0	1
153	default	2025-02-05 04:22:00	0	0	0	1
154	default	2025-02-05 04:23:00	0	0	0	1
155	default	2025-02-05 04:24:00	0	0	0	1
156	default	2025-02-05 04:25:00	0	0	0	1
157	default	2025-02-05 04:26:00	0	0	0	1
158	default	2025-02-05 04:27:00	0	0	0	1
159	default	2025-02-05 04:28:00	0	0	0	1
160	default	2025-02-05 04:29:00	0	0	0	1
161	default	2025-02-05 04:30:00	0	0	0	1
162	default	2025-02-05 04:31:00	0	0	0	1
163	default	2025-02-05 04:32:00	0	0	0	1
164	default	2025-02-05 04:33:00	0	0	0	1
165	default	2025-02-05 04:34:00	0	0	0	1
166	default	2025-02-05 04:35:00	0	0	0	1
167	default	2025-02-05 04:36:00	0	0	0	1
168	default	2025-02-05 04:37:00	0	0	0	1
169	default	2025-02-05 04:38:00	0	0	0	1
170	default	2025-02-05 04:39:00	0	0	0	1
171	default	2025-02-05 04:40:00	0	0	0	1
172	default	2025-02-05 04:41:00	0	0	0	1
173	default	2025-02-05 04:42:00	0	0	0	1
174	default	2025-02-05 04:43:00	0	0	0	1
175	default	2025-02-05 04:44:00	0	0	0	1
176	default	2025-02-05 04:45:00	0	0	0	1
177	default	2025-02-05 04:46:00	0	0	0	1
178	default	2025-02-05 04:47:00	0	0	0	1
179	default	2025-02-05 04:48:00	0	0	0	1
180	default	2025-02-05 04:49:00	0	0	0	1
181	default	2025-02-05 04:50:00	0	0	0	1
182	default	2025-02-05 04:51:00	0	0	0	1
183	default	2025-02-05 04:52:00	0	0	0	1
184	default	2025-02-05 04:53:00	0	0	0	1
185	default	2025-02-05 04:54:00	0	0	0	1
186	default	2025-02-05 04:55:00	0	0	0	1
187	default	2025-02-05 04:56:00	0	0	0	1
188	default	2025-02-05 04:57:00	0	0	0	1
189	default	2025-02-05 04:58:00	0	0	0	1
190	default	2025-02-05 04:59:00	0	0	0	1
191	default	2025-02-05 05:00:00	0	0	0	1
192	default	2025-02-05 05:01:00	0	0	0	1
193	default	2025-02-05 05:02:00	0	0	0	1
194	default	2025-02-05 05:03:00	0	0	0	1
195	default	2025-02-05 05:04:00	0	0	0	1
196	default	2025-02-05 05:05:00	0	0	0	1
197	default	2025-02-05 05:06:00	0	0	0	1
198	default	2025-02-05 05:07:00	0	0	0	1
199	default	2025-02-05 05:08:00	0	0	0	1
200	default	2025-02-05 05:09:00	0	0	0	1
201	default	2025-02-05 05:10:00	0	0	0	1
202	default	2025-02-05 05:11:00	0	0	0	1
203	default	2025-02-05 05:12:00	0	0	0	1
204	default	2025-02-05 05:15:00	0	0	0	1
205	default	2025-02-05 05:16:00	0	0	0	1
206	default	2025-02-05 05:17:00	0	0	0	1
207	default	2025-02-05 05:18:00	0	0	0	1
208	default	2025-02-05 05:19:00	0	0	0	1
209	default	2025-02-05 05:20:00	0	0	0	1
210	default	2025-02-05 05:21:00	0	0	0	1
211	default	2025-02-05 05:22:00	0	0	0	1
212	default	2025-02-05 05:23:00	0	0	0	1
213	default	2025-02-05 05:24:00	0	0	0	1
214	default	2025-02-05 05:25:00	0	0	0	1
215	default	2025-02-05 05:26:00	0	0	0	1
216	default	2025-02-05 05:27:00	0	0	0	1
217	default	2025-02-05 05:28:00	0	0	0	1
\.


--
-- Data for Name: serverpod_health_metric; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_health_metric (id, name, "serverId", "timestamp", "isHealthy", value, granularity) FROM stdin;
1	serverpod_database	default	2025-02-05 01:39:00	t	0.005121	1
2	serverpod_database	default	2025-02-05 01:40:00	t	0.003903	1
3	serverpod_database	default	2025-02-05 01:41:00	t	0.013269	1
4	serverpod_database	default	2025-02-05 01:42:00	t	0.002579	1
5	serverpod_database	default	2025-02-05 01:43:00	t	0.004355	1
6	serverpod_database	default	2025-02-05 01:44:00	t	0.003896	1
7	serverpod_database	default	2025-02-05 01:45:00	t	0.004795	1
8	serverpod_database	default	2025-02-05 01:46:00	t	0.002272	1
9	serverpod_database	default	2025-02-05 01:47:00	t	0.004268	1
10	serverpod_database	default	2025-02-05 01:48:00	t	0.003166	1
11	serverpod_database	default	2025-02-05 01:49:00	t	0.002742	1
12	serverpod_database	default	2025-02-05 01:50:00	t	0.004128	1
13	serverpod_database	default	2025-02-05 01:51:00	t	0.002974	1
14	serverpod_database	default	2025-02-05 01:52:00	t	0.003609	1
15	serverpod_database	default	2025-02-05 01:53:00	t	0.005492	1
16	serverpod_database	default	2025-02-05 01:54:00	t	0.004774	1
17	serverpod_database	default	2025-02-05 01:55:00	t	0.003375	1
18	serverpod_database	default	2025-02-05 01:56:00	t	0.004321	1
19	serverpod_database	default	2025-02-05 01:57:00	t	0.001765	1
20	serverpod_database	default	2025-02-05 01:58:00	t	0.004211	1
21	serverpod_database	default	2025-02-05 01:59:00	t	0.00334	1
22	serverpod_database	default	2025-02-05 02:00:00	t	0.004923	1
23	serverpod_database	default	2025-02-05 02:01:00	t	0.003231	1
24	serverpod_database	default	2025-02-05 02:02:00	t	0.003919	1
25	serverpod_database	default	2025-02-05 02:03:00	t	0.004969	1
26	serverpod_database	default	2025-02-05 02:04:00	t	0.005068	1
27	serverpod_database	default	2025-02-05 02:05:00	t	0.004658	1
28	serverpod_database	default	2025-02-05 02:06:00	t	0.004792	1
29	serverpod_database	default	2025-02-05 02:07:00	t	0.003674	1
30	serverpod_database	default	2025-02-05 02:08:00	t	0.004276	1
31	serverpod_database	default	2025-02-05 02:09:00	t	0.005997	1
32	serverpod_database	default	2025-02-05 02:10:00	t	0.003494	1
33	serverpod_database	default	2025-02-05 02:11:00	t	0.004275	1
34	serverpod_database	default	2025-02-05 02:12:00	t	0.003533	1
35	serverpod_database	default	2025-02-05 02:13:00	t	0.00441	1
36	serverpod_database	default	2025-02-05 02:14:00	t	0.003583	1
37	serverpod_database	default	2025-02-05 02:16:00	t	0.005944	1
38	serverpod_database	default	2025-02-05 02:20:00	t	0.003874	1
40	serverpod_database	default	2025-02-05 02:21:00	t	0.005054	1
41	serverpod_database	default	2025-02-05 02:22:00	t	0.003245	1
42	serverpod_database	default	2025-02-05 02:23:00	t	0.004033	1
43	serverpod_database	default	2025-02-05 02:24:00	t	0.003795	1
44	serverpod_database	default	2025-02-05 02:25:00	t	0.003276	1
45	serverpod_database	default	2025-02-05 02:26:00	t	0.004434	1
46	serverpod_database	default	2025-02-05 02:27:00	t	0.004378	1
47	serverpod_database	default	2025-02-05 02:28:00	t	0.003843	1
48	serverpod_database	default	2025-02-05 02:29:00	t	0.004181	1
49	serverpod_database	default	2025-02-05 02:30:00	t	0.005356	1
50	serverpod_database	default	2025-02-05 02:31:00	t	0.004785	1
51	serverpod_database	default	2025-02-05 02:32:00	t	0.004273	1
52	serverpod_database	default	2025-02-05 02:33:00	t	0.004997	1
53	serverpod_database	default	2025-02-05 02:34:00	t	0.00409	1
54	serverpod_database	default	2025-02-05 02:35:00	t	0.003656	1
55	serverpod_database	default	2025-02-05 02:36:00	t	0.004385	1
56	serverpod_database	default	2025-02-05 02:37:00	t	0.002124	1
57	serverpod_database	default	2025-02-05 02:38:00	t	0.0056	1
58	serverpod_database	default	2025-02-05 02:39:00	t	0.004805	1
59	serverpod_database	default	2025-02-05 02:40:00	t	0.003451	1
60	serverpod_database	default	2025-02-05 02:41:00	t	0.00468	1
61	serverpod_database	default	2025-02-05 02:42:00	t	0.004927	1
62	serverpod_database	default	2025-02-05 02:43:00	t	0.004596	1
63	serverpod_database	default	2025-02-05 02:44:00	t	0.003524	1
64	serverpod_database	default	2025-02-05 02:45:00	t	0.004154	1
65	serverpod_database	default	2025-02-05 02:46:00	t	0.004878	1
66	serverpod_database	default	2025-02-05 02:47:00	t	0.005148	1
67	serverpod_database	default	2025-02-05 02:48:00	t	0.004401	1
68	serverpod_database	default	2025-02-05 02:49:00	t	0.003784	1
69	serverpod_database	default	2025-02-05 02:50:00	t	0.004615	1
70	serverpod_database	default	2025-02-05 02:51:00	t	0.004358	1
71	serverpod_database	default	2025-02-05 02:52:00	t	0.003943	1
72	serverpod_database	default	2025-02-05 02:53:00	t	0.003432	1
73	serverpod_database	default	2025-02-05 02:54:00	t	0.004742	1
74	serverpod_database	default	2025-02-05 02:55:00	t	0.004538	1
75	serverpod_database	default	2025-02-05 02:56:00	t	0.004503	1
76	serverpod_database	default	2025-02-05 02:57:00	t	0.004674	1
77	serverpod_database	default	2025-02-05 02:58:00	t	0.005318	1
78	serverpod_database	default	2025-02-05 02:59:00	t	0.004687	1
79	serverpod_database	default	2025-02-05 03:00:00	t	0.004835	1
80	serverpod_database	default	2025-02-05 03:01:00	t	0.004351	1
81	serverpod_database	default	2025-02-05 03:02:00	t	0.004981	1
82	serverpod_database	default	2025-02-05 03:03:00	t	0.004453	1
83	serverpod_database	default	2025-02-05 03:04:00	t	0.00468	1
84	serverpod_database	default	2025-02-05 03:05:00	t	0.00416	1
85	serverpod_database	default	2025-02-05 03:06:00	t	0.005026	1
86	serverpod_database	default	2025-02-05 03:07:00	t	0.004612	1
87	serverpod_database	default	2025-02-05 03:08:00	t	0.005784	1
88	serverpod_database	default	2025-02-05 03:09:00	t	0.004293	1
89	serverpod_database	default	2025-02-05 03:10:00	t	0.002099	1
90	serverpod_database	default	2025-02-05 03:11:00	t	0.004816	1
91	serverpod_database	default	2025-02-05 03:12:00	t	0.003581	1
92	serverpod_database	default	2025-02-05 03:13:00	t	0.005523	1
93	serverpod_database	default	2025-02-05 03:14:00	t	0.004439	1
94	serverpod_database	default	2025-02-05 03:15:00	t	0.003375	1
95	serverpod_database	default	2025-02-05 03:16:00	t	0.003858	1
96	serverpod_database	default	2025-02-05 03:17:00	t	0.004693	1
97	serverpod_database	default	2025-02-05 03:18:00	t	0.004005	1
98	serverpod_database	default	2025-02-05 03:19:00	t	0.004205	1
99	serverpod_database	default	2025-02-05 03:20:00	t	0.004304	1
100	serverpod_database	default	2025-02-05 03:21:00	t	0.004318	1
101	serverpod_database	default	2025-02-05 03:22:00	t	0.00424	1
102	serverpod_database	default	2025-02-05 03:23:00	t	0.005085	1
103	serverpod_database	default	2025-02-05 03:24:00	t	0.002772	1
104	serverpod_database	default	2025-02-05 03:25:00	t	0.005034	1
105	serverpod_database	default	2025-02-05 03:26:00	t	0.001879	1
106	serverpod_database	default	2025-02-05 03:27:00	t	0.003632	1
107	serverpod_database	default	2025-02-05 03:28:00	t	0.005151	1
108	serverpod_database	default	2025-02-05 03:29:00	t	0.004951	1
109	serverpod_database	default	2025-02-05 03:30:00	t	0.004673	1
110	serverpod_database	default	2025-02-05 03:31:00	t	0.004486	1
111	serverpod_database	default	2025-02-05 03:32:00	t	0.004232	1
112	serverpod_database	default	2025-02-05 03:33:00	t	0.004611	1
113	serverpod_database	default	2025-02-05 03:34:00	t	0.003977	1
114	serverpod_database	default	2025-02-05 03:35:00	t	0.004377	1
115	serverpod_database	default	2025-02-05 03:36:00	t	0.005025	1
116	serverpod_database	default	2025-02-05 03:37:00	t	0.004769	1
117	serverpod_database	default	2025-02-05 03:38:00	t	0.002764	1
118	serverpod_database	default	2025-02-05 03:39:00	t	0.00247	1
119	serverpod_database	default	2025-02-05 03:40:00	t	0.00315	1
120	serverpod_database	default	2025-02-05 03:41:00	t	0.004243	1
121	serverpod_database	default	2025-02-05 03:42:00	t	0.002344	1
122	serverpod_database	default	2025-02-05 03:43:00	t	0.00418	1
123	serverpod_database	default	2025-02-05 03:44:00	t	0.004526	1
124	serverpod_database	default	2025-02-05 03:45:00	t	0.003094	1
125	serverpod_database	default	2025-02-05 03:46:00	t	0.004784	1
126	serverpod_database	default	2025-02-05 03:47:00	t	0.004422	1
127	serverpod_database	default	2025-02-05 03:48:00	t	0.004607	1
128	serverpod_database	default	2025-02-05 03:49:00	t	0.004369	1
129	serverpod_database	default	2025-02-05 03:50:00	t	0.003014	1
130	serverpod_database	default	2025-02-05 03:51:00	t	0.002869	1
131	serverpod_database	default	2025-02-05 03:52:00	t	0.003779	1
132	serverpod_database	default	2025-02-05 03:53:00	t	0.004727	1
133	serverpod_database	default	2025-02-05 03:54:00	t	0.003797	1
134	serverpod_database	default	2025-02-05 03:55:00	t	0.00488	1
135	serverpod_database	default	2025-02-05 03:56:00	t	0.004552	1
136	serverpod_database	default	2025-02-05 03:57:00	t	0.004668	1
137	serverpod_database	default	2025-02-05 03:58:00	t	0.002642	1
138	serverpod_database	default	2025-02-05 03:59:00	t	0.004068	1
139	serverpod_database	default	2025-02-05 04:00:00	t	0.003949	1
140	serverpod_database	default	2025-02-05 04:01:00	t	0.003362	1
141	serverpod_database	default	2025-02-05 04:02:00	t	0.004502	1
142	serverpod_database	default	2025-02-05 04:03:00	t	0.003714	1
143	serverpod_database	default	2025-02-05 04:04:00	t	0.005319	1
144	serverpod_database	default	2025-02-05 04:05:00	t	0.004183	1
145	serverpod_database	default	2025-02-05 04:06:00	t	0.004241	1
146	serverpod_database	default	2025-02-05 04:07:00	t	0.004471	1
147	serverpod_database	default	2025-02-05 04:08:00	t	0.005603	1
148	serverpod_database	default	2025-02-05 04:09:00	t	0.003363	1
149	serverpod_database	default	2025-02-05 04:10:00	t	0.004429	1
150	serverpod_database	default	2025-02-05 04:11:00	t	0.005995	1
151	serverpod_database	default	2025-02-05 04:12:00	t	0.005531	1
152	serverpod_database	default	2025-02-05 04:13:00	t	0.005022	1
153	serverpod_database	default	2025-02-05 04:14:00	t	0.004451	1
154	serverpod_database	default	2025-02-05 04:22:00	t	0.002352	1
155	serverpod_database	default	2025-02-05 04:23:00	t	0.003483	1
157	serverpod_database	default	2025-02-05 04:24:00	t	0.004465	1
158	serverpod_database	default	2025-02-05 04:25:00	t	0.00503	1
159	serverpod_database	default	2025-02-05 04:26:00	t	0.003074	1
160	serverpod_database	default	2025-02-05 04:27:00	t	0.004527	1
161	serverpod_database	default	2025-02-05 04:28:00	t	0.004343	1
162	serverpod_database	default	2025-02-05 04:29:00	t	0.004438	1
163	serverpod_database	default	2025-02-05 04:30:00	t	0.00417	1
164	serverpod_database	default	2025-02-05 04:31:00	t	0.004526	1
165	serverpod_database	default	2025-02-05 04:32:00	t	0.004853	1
166	serverpod_database	default	2025-02-05 04:33:00	t	0.004376	1
167	serverpod_database	default	2025-02-05 04:34:00	t	0.003406	1
168	serverpod_database	default	2025-02-05 04:35:00	t	0.003995	1
169	serverpod_database	default	2025-02-05 04:36:00	t	0.004931	1
170	serverpod_database	default	2025-02-05 04:37:00	t	0.00379	1
171	serverpod_database	default	2025-02-05 04:38:00	t	0.004071	1
172	serverpod_database	default	2025-02-05 04:39:00	t	0.004263	1
173	serverpod_database	default	2025-02-05 04:40:00	t	0.004519	1
174	serverpod_database	default	2025-02-05 04:41:00	t	0.003601	1
175	serverpod_database	default	2025-02-05 04:42:00	t	0.003885	1
176	serverpod_database	default	2025-02-05 04:43:00	t	0.004521	1
177	serverpod_database	default	2025-02-05 04:44:00	t	0.004667	1
178	serverpod_database	default	2025-02-05 04:45:00	t	0.001993	1
180	serverpod_database	default	2025-02-05 04:46:00	t	0.002703	1
181	serverpod_database	default	2025-02-05 04:47:00	t	0.004952	1
182	serverpod_database	default	2025-02-05 04:48:00	t	0.001587	1
183	serverpod_database	default	2025-02-05 04:49:00	t	0.004898	1
184	serverpod_database	default	2025-02-05 04:50:00	t	0.004896	1
185	serverpod_database	default	2025-02-05 04:51:00	t	0.004257	1
186	serverpod_database	default	2025-02-05 04:52:00	t	0.001951	1
187	serverpod_database	default	2025-02-05 04:53:00	t	0.004594	1
188	serverpod_database	default	2025-02-05 04:54:00	t	0.004564	1
189	serverpod_database	default	2025-02-05 04:55:00	t	0.004158	1
190	serverpod_database	default	2025-02-05 04:56:00	t	0.004862	1
191	serverpod_database	default	2025-02-05 04:57:00	t	0.004487	1
192	serverpod_database	default	2025-02-05 04:58:00	t	0.00383	1
193	serverpod_database	default	2025-02-05 04:59:00	t	0.00423	1
194	serverpod_database	default	2025-02-05 05:00:00	t	0.002811	1
195	serverpod_database	default	2025-02-05 05:01:00	t	0.002776	1
196	serverpod_database	default	2025-02-05 05:02:00	t	0.004498	1
197	serverpod_database	default	2025-02-05 05:03:00	t	0.003967	1
198	serverpod_database	default	2025-02-05 05:04:00	t	0.003817	1
199	serverpod_database	default	2025-02-05 05:05:00	t	0.004091	1
200	serverpod_database	default	2025-02-05 05:06:00	t	0.004489	1
201	serverpod_database	default	2025-02-05 05:07:00	t	0.004113	1
202	serverpod_database	default	2025-02-05 05:08:00	t	0.001974	1
203	serverpod_database	default	2025-02-05 05:09:00	t	0.001785	1
204	serverpod_database	default	2025-02-05 05:10:00	t	0.000863	1
205	serverpod_database	default	2025-02-05 05:11:00	t	0.001409	1
206	serverpod_database	default	2025-02-05 05:12:00	t	0.001389	1
207	serverpod_database	default	2025-02-05 05:15:00	t	0.00647	1
208	serverpod_database	default	2025-02-05 05:16:00	t	0.005065	1
209	serverpod_database	default	2025-02-05 05:17:00	t	0.004854	1
210	serverpod_database	default	2025-02-05 05:18:00	t	0.005423	1
211	serverpod_database	default	2025-02-05 05:19:00	t	0.004199	1
212	serverpod_database	default	2025-02-05 05:20:00	t	0.004125	1
213	serverpod_database	default	2025-02-05 05:21:00	t	0.00459	1
214	serverpod_database	default	2025-02-05 05:22:00	t	0.004268	1
215	serverpod_database	default	2025-02-05 05:23:00	t	0.002424	1
216	serverpod_database	default	2025-02-05 05:24:00	t	0.004272	1
217	serverpod_database	default	2025-02-05 05:25:00	t	0.004487	1
218	serverpod_database	default	2025-02-05 05:26:00	t	0.003302	1
219	serverpod_database	default	2025-02-05 05:27:00	t	0.005721	1
220	serverpod_database	default	2025-02-05 05:28:00	t	0.004879	1
\.


--
-- Data for Name: serverpod_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_log (id, "sessionLogId", "messageId", reference, "serverId", "time", "logLevel", message, error, "stackTrace", "order") FROM stdin;
\.


--
-- Data for Name: serverpod_message_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_message_log (id, "sessionLogId", "serverId", "messageId", endpoint, "messageName", duration, error, "stackTrace", slow, "order") FROM stdin;
\.


--
-- Data for Name: serverpod_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_method (id, endpoint, method) FROM stdin;
\.


--
-- Data for Name: serverpod_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_migrations (id, module, version, "timestamp") FROM stdin;
1	book_store	20250204105704387	2025-02-05 01:39:02.049404
2	serverpod	20240516151843329	2025-02-05 01:39:02.049404
\.


--
-- Data for Name: serverpod_query_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_query_log (id, "serverId", "sessionLogId", "messageId", query, duration, "numRows", error, "stackTrace", slow, "order") FROM stdin;
\.


--
-- Data for Name: serverpod_readwrite_test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_readwrite_test (id, number) FROM stdin;
1	27525
2	777022
3	542565
4	822220
5	289854
6	890670
7	316407
8	497738
9	713517
10	654232
11	579145
12	809706
13	991108
14	737554
15	36695
16	952869
17	800260
18	683363
19	462774
20	268469
21	561963
22	316175
23	34522
24	930984
25	857236
26	192325
27	39087
28	65859
29	938469
30	395220
31	501653
32	55211
33	9736
34	225975
35	478176
36	221650
37	240260
38	143405
39	994686
40	960725
41	231669
42	86787
43	594363
44	396023
45	481830
46	299840
47	872496
48	502538
49	767122
50	188806
51	698630
52	45230
53	687907
54	980991
55	645436
56	124099
57	395102
58	228334
59	272337
60	812719
61	940557
62	850300
63	315984
64	126143
65	860308
66	715001
67	594747
68	776969
69	228418
70	752920
71	290778
72	624143
73	706684
74	896338
75	836945
76	956238
77	607050
78	695320
79	17676
80	872876
81	753085
82	376982
83	297263
84	64751
85	10237
86	163465
87	823598
88	195821
89	580697
90	127596
91	815875
92	253041
93	132164
94	486410
95	129685
96	488180
97	374520
98	328784
99	241859
100	891742
101	41165
102	837371
103	198766
104	180585
105	850334
106	958829
107	569020
108	513410
109	945416
110	144600
111	467993
112	896024
113	918558
114	219813
115	59801
116	815734
117	922914
118	404825
119	566950
120	25837
121	11871
122	875263
123	250408
124	582318
125	199703
126	319984
127	931810
128	900801
129	812397
130	108819
131	433455
132	158736
133	601374
134	903575
135	237158
136	28724
137	849343
138	426638
139	645913
140	471299
141	754067
142	300521
143	178899
144	274705
145	591046
146	559201
147	460837
148	271494
149	398751
150	851577
151	935995
152	858678
153	338817
154	522349
155	871931
156	822928
157	78949
158	913612
159	115476
160	503245
161	78871
162	640081
163	657008
164	65066
165	572081
166	683098
167	477654
168	216244
169	539755
170	497693
171	73558
172	371720
173	440962
174	643786
175	244369
176	588956
177	289865
178	471162
179	173472
180	736401
181	708143
182	362099
183	924883
184	129564
185	347368
186	560130
187	435759
188	189199
189	513204
190	718070
191	582092
192	828108
193	315302
194	922229
195	78295
196	116105
197	549058
198	41033
199	992314
200	997574
201	351577
202	771778
203	972763
204	304379
205	144090
206	833655
207	335876
208	607981
209	581398
210	450169
211	664165
212	277996
213	744062
214	412180
215	847950
216	363202
217	125704
218	748235
219	95799
220	887703
\.


--
-- Data for Name: serverpod_runtime_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_runtime_settings (id, "logSettings", "logSettingsOverrides", "logServiceCalls", "logMalformedCalls") FROM stdin;
1	{"logLevel":1,"logAllSessions":false,"logAllQueries":false,"logSlowSessions":true,"logStreamingSessionsContinuously":true,"logSlowQueries":true,"logFailedSessions":true,"logFailedQueries":true,"slowSessionDuration":1.0,"slowQueryDuration":1.0}	[]	f	f
\.


--
-- Data for Name: serverpod_session_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverpod_session_log (id, "serverId", "time", module, endpoint, method, duration, "numQueries", slow, error, "stackTrace", "authenticatedUserId", "isOpen", touched) FROM stdin;
\.


--
-- Data for Name: sys_operation_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_operation_log (id, "tableNameStr", "operationType", "recordId", "oldData", "newData", "operatorId", "operationTime") FROM stdin;
\.


--
-- Data for Name: sys_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_resource (id, name, uri, permission, type, icon, sn, "parentId") FROM stdin;
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role (id, name) FROM stdin;
\.


--
-- Data for Name: sys_role_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role_resource (id, "roleId", "resourceId") FROM stdin;
\.


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user (id, truename, nickname, username, password, phone, email, avatar, roles, permissions, "creatorId", "createTime", "loginTime", status, "isDeleted") FROM stdin;
\.


--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user_role (id, "roleId", "userId") FROM stdin;
\.


--
-- Name: book_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_category_id_seq', 1, false);


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 1, false);


--
-- Name: book_package_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_package_id_seq', 1, false);


--
-- Name: book_package_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_package_item_id_seq', 1, false);


--
-- Name: book_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_sale_id_seq', 1, false);


--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_seq', 1, false);


--
-- Name: dict_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dict_item_id_seq', 1, false);


--
-- Name: dict_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dict_type_id_seq', 1, false);


--
-- Name: inventory_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_log_id_seq', 1, false);


--
-- Name: party_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_id_seq', 1, false);


--
-- Name: promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promotion_id_seq', 1, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.region_id_seq', 1, false);


--
-- Name: role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permission_id_seq', 1, false);


--
-- Name: serverpod_cloud_storage_direct_upload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_cloud_storage_direct_upload_id_seq', 1, false);


--
-- Name: serverpod_cloud_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_cloud_storage_id_seq', 1, false);


--
-- Name: serverpod_future_call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_future_call_id_seq', 1, false);


--
-- Name: serverpod_health_connection_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_health_connection_info_id_seq', 217, true);


--
-- Name: serverpod_health_metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_health_metric_id_seq', 220, true);


--
-- Name: serverpod_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_log_id_seq', 1, false);


--
-- Name: serverpod_message_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_message_log_id_seq', 1, false);


--
-- Name: serverpod_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_method_id_seq', 1, false);


--
-- Name: serverpod_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_migrations_id_seq', 2, true);


--
-- Name: serverpod_query_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_query_log_id_seq', 1, false);


--
-- Name: serverpod_readwrite_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_readwrite_test_id_seq', 220, true);


--
-- Name: serverpod_runtime_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_runtime_settings_id_seq', 1, true);


--
-- Name: serverpod_session_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_session_log_id_seq', 1, false);


--
-- Name: sys_operation_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_operation_log_id_seq', 1, false);


--
-- Name: sys_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_resource_id_seq', 1, false);


--
-- Name: sys_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_id_seq', 1, false);


--
-- Name: sys_role_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_resource_id_seq', 1, false);


--
-- Name: sys_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_id_seq', 1, false);


--
-- Name: sys_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_role_id_seq', 1, false);


--
-- Name: book_category book_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category
    ADD CONSTRAINT book_category_pkey PRIMARY KEY (id);


--
-- Name: book_package_item book_package_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_package_item
    ADD CONSTRAINT book_package_item_pkey PRIMARY KEY (id);


--
-- Name: book_package book_package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_package
    ADD CONSTRAINT book_package_pkey PRIMARY KEY (id);


--
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- Name: book_sale book_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_sale
    ADD CONSTRAINT book_sale_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: dict_item dict_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dict_item
    ADD CONSTRAINT dict_item_pkey PRIMARY KEY (id);


--
-- Name: dict_type dict_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dict_type
    ADD CONSTRAINT dict_type_pkey PRIMARY KEY (id);


--
-- Name: inventory_log inventory_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_log
    ADD CONSTRAINT inventory_log_pkey PRIMARY KEY (id);


--
-- Name: party party_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_pkey PRIMARY KEY (id);


--
-- Name: promotion promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id);


--
-- Name: serverpod_cloud_storage_direct_upload serverpod_cloud_storage_direct_upload_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_cloud_storage_direct_upload
    ADD CONSTRAINT serverpod_cloud_storage_direct_upload_pkey PRIMARY KEY (id);


--
-- Name: serverpod_cloud_storage serverpod_cloud_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_cloud_storage
    ADD CONSTRAINT serverpod_cloud_storage_pkey PRIMARY KEY (id);


--
-- Name: serverpod_future_call serverpod_future_call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_future_call
    ADD CONSTRAINT serverpod_future_call_pkey PRIMARY KEY (id);


--
-- Name: serverpod_health_connection_info serverpod_health_connection_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_health_connection_info
    ADD CONSTRAINT serverpod_health_connection_info_pkey PRIMARY KEY (id);


--
-- Name: serverpod_health_metric serverpod_health_metric_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_health_metric
    ADD CONSTRAINT serverpod_health_metric_pkey PRIMARY KEY (id);


--
-- Name: serverpod_log serverpod_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_log
    ADD CONSTRAINT serverpod_log_pkey PRIMARY KEY (id);


--
-- Name: serverpod_message_log serverpod_message_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_message_log
    ADD CONSTRAINT serverpod_message_log_pkey PRIMARY KEY (id);


--
-- Name: serverpod_method serverpod_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_method
    ADD CONSTRAINT serverpod_method_pkey PRIMARY KEY (id);


--
-- Name: serverpod_migrations serverpod_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_migrations
    ADD CONSTRAINT serverpod_migrations_pkey PRIMARY KEY (id);


--
-- Name: serverpod_query_log serverpod_query_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_query_log
    ADD CONSTRAINT serverpod_query_log_pkey PRIMARY KEY (id);


--
-- Name: serverpod_readwrite_test serverpod_readwrite_test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_readwrite_test
    ADD CONSTRAINT serverpod_readwrite_test_pkey PRIMARY KEY (id);


--
-- Name: serverpod_runtime_settings serverpod_runtime_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_runtime_settings
    ADD CONSTRAINT serverpod_runtime_settings_pkey PRIMARY KEY (id);


--
-- Name: serverpod_session_log serverpod_session_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_session_log
    ADD CONSTRAINT serverpod_session_log_pkey PRIMARY KEY (id);


--
-- Name: sys_operation_log sys_operation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_operation_log
    ADD CONSTRAINT sys_operation_log_pkey PRIMARY KEY (id);


--
-- Name: sys_resource sys_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_resource
    ADD CONSTRAINT sys_resource_pkey PRIMARY KEY (id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (id);


--
-- Name: sys_role_resource sys_role_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_resource
    ADD CONSTRAINT sys_role_resource_pkey PRIMARY KEY (id);


--
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (id);


--
-- Name: sys_user_role sys_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pkey PRIMARY KEY (id);


--
-- Name: book_package_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX book_package_unique ON public.book_package_item USING btree ("bookId", "packageId");


--
-- Name: book_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX book_unique ON public.book USING btree (isbn, name);


--
-- Name: customer_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_unique ON public.customer USING btree ("userName");


--
-- Name: dict_item_name_type_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dict_item_name_type_unique ON public.dict_item USING btree (name, "typeId");


--
-- Name: dict_item_value_type_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dict_item_value_type_unique ON public.dict_item USING btree (value, "typeId");


--
-- Name: dict_type_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dict_type_unique ON public.dict_type USING btree (name, value);


--
-- Name: package_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX package_name_unique ON public.book_package USING btree (name);


--
-- Name: region_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX region_unique ON public.region USING btree ("parentId", name);


--
-- Name: serverpod_cloud_storage_direct_upload_storage_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_cloud_storage_direct_upload_storage_path ON public.serverpod_cloud_storage_direct_upload USING btree ("storageId", path);


--
-- Name: serverpod_cloud_storage_expiration; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_cloud_storage_expiration ON public.serverpod_cloud_storage USING btree (expiration);


--
-- Name: serverpod_cloud_storage_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_cloud_storage_path_idx ON public.serverpod_cloud_storage USING btree ("storageId", path);


--
-- Name: serverpod_future_call_identifier_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_future_call_identifier_idx ON public.serverpod_future_call USING btree (identifier);


--
-- Name: serverpod_future_call_serverId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "serverpod_future_call_serverId_idx" ON public.serverpod_future_call USING btree ("serverId");


--
-- Name: serverpod_future_call_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_future_call_time_idx ON public.serverpod_future_call USING btree ("time");


--
-- Name: serverpod_health_connection_info_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_health_connection_info_timestamp_idx ON public.serverpod_health_connection_info USING btree ("timestamp", "serverId", granularity);


--
-- Name: serverpod_health_metric_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_health_metric_timestamp_idx ON public.serverpod_health_metric USING btree ("timestamp", "serverId", name, granularity);


--
-- Name: serverpod_log_sessionLogId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "serverpod_log_sessionLogId_idx" ON public.serverpod_log USING btree ("sessionLogId");


--
-- Name: serverpod_method_endpoint_method_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_method_endpoint_method_idx ON public.serverpod_method USING btree (endpoint, method);


--
-- Name: serverpod_migrations_ids; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX serverpod_migrations_ids ON public.serverpod_migrations USING btree (module);


--
-- Name: serverpod_query_log_sessionLogId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON public.serverpod_query_log USING btree ("sessionLogId");


--
-- Name: serverpod_session_log_isopen_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_session_log_isopen_idx ON public.serverpod_session_log USING btree ("isOpen");


--
-- Name: serverpod_session_log_serverid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_session_log_serverid_idx ON public.serverpod_session_log USING btree ("serverId");


--
-- Name: serverpod_session_log_touched_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX serverpod_session_log_touched_idx ON public.serverpod_session_log USING btree (touched);


--
-- Name: sys_resource_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_resource_unique ON public.sys_resource USING btree (name, "parentId");


--
-- Name: sys_role_resource_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_role_resource_unique ON public.sys_role_resource USING btree ("roleId", "resourceId");


--
-- Name: sys_role_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_role_unique ON public.sys_role USING btree (name);


--
-- Name: sys_user_role_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_user_role_unique ON public.sys_user_role USING btree ("roleId", "userId");


--
-- Name: sys_user_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_user_unique ON public.sys_user USING btree (username);


--
-- Name: serverpod_log serverpod_log_fk_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_log
    ADD CONSTRAINT serverpod_log_fk_0 FOREIGN KEY ("sessionLogId") REFERENCES public.serverpod_session_log(id) ON DELETE CASCADE;


--
-- Name: serverpod_message_log serverpod_message_log_fk_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_message_log
    ADD CONSTRAINT serverpod_message_log_fk_0 FOREIGN KEY ("sessionLogId") REFERENCES public.serverpod_session_log(id) ON DELETE CASCADE;


--
-- Name: serverpod_query_log serverpod_query_log_fk_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverpod_query_log
    ADD CONSTRAINT serverpod_query_log_fk_0 FOREIGN KEY ("sessionLogId") REFERENCES public.serverpod_session_log(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

