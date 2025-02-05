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
218	default	2025-02-05 05:29:00	0	0	0	1
219	default	2025-02-05 05:30:00	0	0	0	1
220	default	2025-02-05 05:31:00	0	0	0	1
221	default	2025-02-05 05:32:00	0	0	0	1
222	default	2025-02-05 05:33:00	0	0	0	1
223	default	2025-02-05 05:34:00	0	0	0	1
224	default	2025-02-05 05:35:00	0	0	0	1
225	default	2025-02-05 05:36:00	0	0	0	1
226	default	2025-02-05 05:37:00	0	0	0	1
227	default	2025-02-05 05:38:00	0	0	0	1
228	default	2025-02-05 05:39:00	0	0	0	1
229	default	2025-02-05 05:40:00	0	0	0	1
230	default	2025-02-05 05:41:00	0	0	0	1
231	default	2025-02-05 05:42:00	0	0	0	1
232	default	2025-02-05 05:43:00	0	0	0	1
233	default	2025-02-05 05:44:00	0	0	0	1
234	default	2025-02-05 05:45:00	0	0	0	1
235	default	2025-02-05 05:46:00	0	0	0	1
236	default	2025-02-05 05:47:00	0	0	0	1
237	default	2025-02-05 05:48:00	0	0	0	1
238	default	2025-02-05 05:49:00	0	0	0	1
239	default	2025-02-05 05:50:00	0	0	0	1
240	default	2025-02-05 05:51:00	0	0	0	1
241	default	2025-02-05 05:52:00	0	0	0	1
242	default	2025-02-05 05:53:00	0	0	0	1
243	default	2025-02-05 05:54:00	0	0	0	1
244	default	2025-02-05 05:55:00	0	0	0	1
245	default	2025-02-05 05:56:00	0	0	0	1
246	default	2025-02-05 05:57:00	0	0	0	1
247	default	2025-02-05 05:58:00	0	0	0	1
248	default	2025-02-05 05:59:00	0	0	0	1
249	default	2025-02-05 06:00:00	0	0	0	1
250	default	2025-02-05 06:01:00	0	0	0	1
251	default	2025-02-05 06:02:00	0	0	0	1
252	default	2025-02-05 06:03:00	0	0	0	1
253	default	2025-02-05 06:04:00	0	0	0	1
254	default	2025-02-05 06:05:00	0	0	0	1
255	default	2025-02-05 06:06:00	0	0	0	1
256	default	2025-02-05 06:07:00	0	0	0	1
257	default	2025-02-05 06:08:00	0	0	0	1
258	default	2025-02-05 06:09:00	0	0	0	1
259	default	2025-02-05 06:10:00	0	0	0	1
260	default	2025-02-05 06:11:00	0	0	0	1
261	default	2025-02-05 06:12:00	0	0	0	1
262	default	2025-02-05 06:13:00	0	0	0	1
263	default	2025-02-05 06:14:00	0	0	0	1
264	default	2025-02-05 06:15:00	0	0	0	1
265	default	2025-02-05 06:16:00	0	0	0	1
266	default	2025-02-05 06:17:00	0	0	0	1
267	default	2025-02-05 06:18:00	0	0	0	1
268	default	2025-02-05 06:19:00	0	0	0	1
269	default	2025-02-05 06:20:00	0	0	0	1
270	default	2025-02-05 06:21:00	0	0	0	1
271	default	2025-02-05 06:22:00	0	0	0	1
272	default	2025-02-05 06:23:00	0	0	0	1
273	default	2025-02-05 06:24:00	0	0	0	1
274	default	2025-02-05 06:25:00	0	0	0	1
275	default	2025-02-05 06:26:00	0	0	0	1
276	default	2025-02-05 06:27:00	0	0	0	1
277	default	2025-02-05 06:28:00	0	0	0	1
278	default	2025-02-05 06:29:00	0	0	0	1
279	default	2025-02-05 06:30:00	0	0	0	1
280	default	2025-02-05 06:31:00	0	0	0	1
281	default	2025-02-05 06:32:00	0	0	0	1
282	default	2025-02-05 06:33:00	0	0	0	1
283	default	2025-02-05 06:34:00	0	0	0	1
284	default	2025-02-05 06:35:00	0	0	0	1
285	default	2025-02-05 06:36:00	0	0	0	1
286	default	2025-02-05 06:37:00	0	0	0	1
287	default	2025-02-05 06:38:00	0	0	0	1
288	default	2025-02-05 06:39:00	0	0	0	1
289	default	2025-02-05 06:40:00	0	0	0	1
290	default	2025-02-05 06:41:00	0	0	0	1
291	default	2025-02-05 06:42:00	0	0	0	1
292	default	2025-02-05 06:43:00	0	0	0	1
293	default	2025-02-05 06:44:00	0	0	0	1
294	default	2025-02-05 06:45:00	0	0	0	1
295	default	2025-02-05 06:46:00	0	0	0	1
296	default	2025-02-05 06:47:00	0	0	0	1
297	default	2025-02-05 06:48:00	0	0	0	1
298	default	2025-02-05 06:49:00	0	0	0	1
299	default	2025-02-05 06:50:00	0	0	0	1
300	default	2025-02-05 06:51:00	0	0	0	1
301	default	2025-02-05 06:52:00	0	0	0	1
302	default	2025-02-05 06:53:00	0	0	0	1
303	default	2025-02-05 06:54:00	0	0	0	1
304	default	2025-02-05 06:55:00	0	0	0	1
305	default	2025-02-05 06:56:00	0	0	0	1
306	default	2025-02-05 06:57:00	0	0	0	1
307	default	2025-02-05 06:58:00	0	0	0	1
308	default	2025-02-05 06:59:00	0	0	0	1
309	default	2025-02-05 07:00:00	0	0	0	1
310	default	2025-02-05 07:01:00	0	0	0	1
311	default	2025-02-05 07:02:00	0	0	0	1
312	default	2025-02-05 07:03:00	0	0	0	1
313	default	2025-02-05 07:04:00	0	0	0	1
314	default	2025-02-05 07:05:00	0	0	0	1
315	default	2025-02-05 07:06:00	0	0	0	1
316	default	2025-02-05 07:07:00	0	0	0	1
317	default	2025-02-05 07:08:00	0	0	0	1
318	default	2025-02-05 07:09:00	0	0	0	1
319	default	2025-02-05 07:10:00	0	0	0	1
320	default	2025-02-05 07:11:00	0	0	0	1
321	default	2025-02-05 07:12:00	0	0	0	1
322	default	2025-02-05 07:13:00	0	0	0	1
323	default	2025-02-05 07:14:00	0	0	0	1
324	default	2025-02-05 07:15:00	0	0	0	1
325	default	2025-02-05 07:16:00	0	0	0	1
326	default	2025-02-05 07:17:00	0	0	0	1
327	default	2025-02-05 07:18:00	0	0	0	1
328	default	2025-02-05 07:19:00	0	0	0	1
329	default	2025-02-05 07:20:00	0	0	0	1
330	default	2025-02-05 07:21:00	0	0	0	1
331	default	2025-02-05 07:22:00	0	0	0	1
332	default	2025-02-05 07:23:00	0	0	0	1
333	default	2025-02-05 07:24:00	0	0	0	1
334	default	2025-02-05 07:25:00	0	0	0	1
335	default	2025-02-05 07:26:00	0	0	0	1
336	default	2025-02-05 07:27:00	0	0	0	1
337	default	2025-02-05 07:28:00	0	0	0	1
338	default	2025-02-05 07:29:00	0	0	0	1
339	default	2025-02-05 07:30:00	0	0	0	1
340	default	2025-02-05 07:31:00	0	0	0	1
341	default	2025-02-05 07:32:00	0	0	0	1
342	default	2025-02-05 07:33:00	0	0	0	1
343	default	2025-02-05 07:34:00	0	0	0	1
344	default	2025-02-05 07:35:00	0	0	0	1
345	default	2025-02-05 07:36:00	0	0	0	1
346	default	2025-02-05 07:37:00	0	0	0	1
347	default	2025-02-05 07:38:00	0	0	0	1
348	default	2025-02-05 07:39:00	0	0	0	1
349	default	2025-02-05 07:40:00	0	0	0	1
350	default	2025-02-05 07:41:00	0	0	0	1
351	default	2025-02-05 07:42:00	0	0	0	1
352	default	2025-02-05 07:43:00	0	0	0	1
353	default	2025-02-05 07:44:00	0	0	0	1
354	default	2025-02-05 07:45:00	0	0	0	1
355	default	2025-02-05 07:46:00	0	0	0	1
356	default	2025-02-05 07:47:00	0	0	0	1
357	default	2025-02-05 07:48:00	0	0	0	1
358	default	2025-02-05 07:49:00	0	0	0	1
359	default	2025-02-05 07:50:00	0	0	0	1
360	default	2025-02-05 07:51:00	0	0	0	1
361	default	2025-02-05 07:52:00	0	0	0	1
362	default	2025-02-05 07:53:00	0	0	0	1
363	default	2025-02-05 07:54:00	0	0	0	1
364	default	2025-02-05 07:55:00	0	0	0	1
365	default	2025-02-05 07:56:00	0	0	0	1
366	default	2025-02-05 07:57:00	0	0	0	1
367	default	2025-02-05 07:58:00	0	0	0	1
368	default	2025-02-05 07:59:00	0	0	0	1
369	default	2025-02-05 08:00:00	0	0	0	1
370	default	2025-02-05 08:01:00	0	0	0	1
371	default	2025-02-05 08:02:00	0	0	0	1
372	default	2025-02-05 08:03:00	0	0	0	1
373	default	2025-02-05 08:04:00	0	0	0	1
374	default	2025-02-05 08:05:00	0	0	0	1
375	default	2025-02-05 08:06:00	0	0	0	1
376	default	2025-02-05 08:07:00	0	0	0	1
377	default	2025-02-05 08:08:00	0	0	0	1
378	default	2025-02-05 08:09:00	0	0	0	1
379	default	2025-02-05 08:10:00	0	0	0	1
380	default	2025-02-05 08:11:00	0	0	0	1
381	default	2025-02-05 08:12:00	0	0	0	1
382	default	2025-02-05 08:13:00	0	0	0	1
383	default	2025-02-05 08:14:00	0	0	0	1
384	default	2025-02-05 08:15:00	0	0	0	1
385	default	2025-02-05 08:16:00	0	0	0	1
386	default	2025-02-05 08:17:00	0	0	0	1
387	default	2025-02-05 08:18:00	0	0	0	1
388	default	2025-02-05 08:19:00	0	0	0	1
389	default	2025-02-05 08:20:00	0	0	0	1
390	default	2025-02-05 08:21:00	0	0	0	1
391	default	2025-02-05 08:22:00	0	0	0	1
392	default	2025-02-05 08:23:00	0	0	0	1
393	default	2025-02-05 08:24:00	0	0	0	1
394	default	2025-02-05 08:25:00	0	0	0	1
395	default	2025-02-05 08:26:00	0	0	0	1
396	default	2025-02-05 08:27:00	0	0	0	1
397	default	2025-02-05 08:28:00	0	0	0	1
398	default	2025-02-05 08:29:00	0	0	0	1
399	default	2025-02-05 08:30:00	0	0	0	1
400	default	2025-02-05 08:31:00	0	0	0	1
401	default	2025-02-05 08:32:00	0	0	0	1
402	default	2025-02-05 08:40:00	0	0	0	1
403	default	2025-02-05 08:41:00	0	0	0	1
404	default	2025-02-05 08:42:00	0	0	0	1
405	default	2025-02-05 08:43:00	0	0	0	1
406	default	2025-02-05 08:44:00	0	0	0	1
407	default	2025-02-05 08:45:00	0	0	0	1
408	default	2025-02-05 08:46:00	0	0	0	1
409	default	2025-02-05 08:47:00	0	0	0	1
410	default	2025-02-05 08:48:00	0	0	0	1
411	default	2025-02-05 08:49:00	0	0	0	1
412	default	2025-02-05 08:50:00	0	0	0	1
413	default	2025-02-05 08:51:00	0	0	0	1
414	default	2025-02-05 08:52:00	0	0	0	1
415	default	2025-02-05 08:53:00	0	0	0	1
416	default	2025-02-05 08:54:00	0	0	0	1
417	default	2025-02-05 08:55:00	0	0	0	1
418	default	2025-02-05 08:56:00	0	0	0	1
419	default	2025-02-05 08:57:00	0	0	0	1
420	default	2025-02-05 08:58:00	0	0	0	1
421	default	2025-02-05 08:59:00	0	0	0	1
422	default	2025-02-05 09:00:00	0	0	0	1
423	default	2025-02-05 09:01:00	0	0	0	1
424	default	2025-02-05 09:02:00	0	0	0	1
425	default	2025-02-05 09:03:00	0	0	0	1
426	default	2025-02-05 09:04:00	0	0	0	1
427	default	2025-02-05 09:05:00	0	0	0	1
428	default	2025-02-05 09:06:00	0	0	0	1
429	default	2025-02-05 09:07:00	0	0	0	1
430	default	2025-02-05 09:08:00	0	0	0	1
431	default	2025-02-05 09:09:00	0	0	0	1
432	default	2025-02-05 09:10:00	0	0	0	1
433	default	2025-02-05 09:11:00	0	0	0	1
434	default	2025-02-05 09:12:00	0	0	0	1
435	default	2025-02-05 09:13:00	0	0	0	1
436	default	2025-02-05 09:14:00	0	0	0	1
437	default	2025-02-05 09:15:00	0	0	0	1
438	default	2025-02-05 09:16:00	0	0	0	1
439	default	2025-02-05 09:17:00	0	0	0	1
440	default	2025-02-05 09:18:00	0	0	0	1
441	default	2025-02-05 09:19:00	0	0	0	1
442	default	2025-02-05 09:20:00	0	0	0	1
443	default	2025-02-05 09:21:00	0	0	0	1
444	default	2025-02-05 09:22:00	0	0	0	1
445	default	2025-02-05 09:23:00	0	0	0	1
446	default	2025-02-05 09:24:00	0	0	0	1
447	default	2025-02-05 09:25:00	0	0	0	1
448	default	2025-02-05 09:26:00	0	0	0	1
449	default	2025-02-05 09:27:00	0	0	0	1
450	default	2025-02-05 09:28:00	0	0	0	1
451	default	2025-02-05 09:29:00	0	0	0	1
452	default	2025-02-05 09:30:00	0	0	0	1
453	default	2025-02-05 09:31:00	0	0	0	1
454	default	2025-02-05 09:32:00	0	0	0	1
455	default	2025-02-05 09:33:00	0	0	0	1
456	default	2025-02-05 09:34:00	0	0	0	1
457	default	2025-02-05 09:35:00	0	0	0	1
458	default	2025-02-05 09:36:00	0	0	0	1
459	default	2025-02-05 09:37:00	0	0	0	1
460	default	2025-02-05 09:38:00	0	0	0	1
461	default	2025-02-05 09:39:00	0	0	0	1
462	default	2025-02-05 09:40:00	0	0	0	1
463	default	2025-02-05 09:41:00	0	0	0	1
464	default	2025-02-05 09:42:00	0	0	0	1
465	default	2025-02-05 09:43:00	0	0	0	1
466	default	2025-02-05 09:44:00	0	0	0	1
467	default	2025-02-05 09:45:00	0	0	0	1
468	default	2025-02-05 09:46:00	0	0	0	1
469	default	2025-02-05 09:47:00	0	0	0	1
470	default	2025-02-05 09:48:00	0	0	0	1
471	default	2025-02-05 09:49:00	0	0	0	1
472	default	2025-02-05 09:50:00	0	0	0	1
473	default	2025-02-05 09:51:00	0	0	0	1
474	default	2025-02-05 09:52:00	0	0	0	1
475	default	2025-02-05 09:53:00	0	0	0	1
476	default	2025-02-05 09:54:00	0	0	0	1
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
221	serverpod_database	default	2025-02-05 05:29:00	t	0.001108	1
222	serverpod_database	default	2025-02-05 05:30:00	t	0.003671	1
223	serverpod_database	default	2025-02-05 05:31:00	t	0.004789	1
224	serverpod_database	default	2025-02-05 05:32:00	t	0.004545	1
225	serverpod_database	default	2025-02-05 05:33:00	t	0.004723	1
226	serverpod_database	default	2025-02-05 05:34:00	t	0.005161	1
227	serverpod_database	default	2025-02-05 05:35:00	t	0.0049	1
228	serverpod_database	default	2025-02-05 05:36:00	t	0.00368	1
229	serverpod_database	default	2025-02-05 05:37:00	t	0.004501	1
230	serverpod_database	default	2025-02-05 05:38:00	t	0.005599	1
231	serverpod_database	default	2025-02-05 05:39:00	t	0.003625	1
232	serverpod_database	default	2025-02-05 05:40:00	t	0.005046	1
233	serverpod_database	default	2025-02-05 05:41:00	t	0.004992	1
234	serverpod_database	default	2025-02-05 05:42:00	t	0.003953	1
235	serverpod_database	default	2025-02-05 05:43:00	t	0.005228	1
236	serverpod_database	default	2025-02-05 05:44:00	t	0.004613	1
237	serverpod_database	default	2025-02-05 05:45:00	t	0.005514	1
238	serverpod_database	default	2025-02-05 05:46:00	t	0.004957	1
239	serverpod_database	default	2025-02-05 05:47:00	t	0.004595	1
240	serverpod_database	default	2025-02-05 05:48:00	t	0.004186	1
242	serverpod_database	default	2025-02-05 05:49:00	t	0.002299	1
243	serverpod_database	default	2025-02-05 05:50:00	t	0.004031	1
244	serverpod_database	default	2025-02-05 05:51:00	t	0.004767	1
245	serverpod_database	default	2025-02-05 05:52:00	t	0.003324	1
246	serverpod_database	default	2025-02-05 05:53:00	t	0.004567	1
247	serverpod_database	default	2025-02-05 05:54:00	t	0.00311	1
248	serverpod_database	default	2025-02-05 05:55:00	t	0.004463	1
249	serverpod_database	default	2025-02-05 05:56:00	t	0.004041	1
250	serverpod_database	default	2025-02-05 05:57:00	t	0.00339	1
251	serverpod_database	default	2025-02-05 05:58:00	t	0.004867	1
252	serverpod_database	default	2025-02-05 05:59:00	t	0.004807	1
253	serverpod_database	default	2025-02-05 06:00:00	t	0.004263	1
254	serverpod_database	default	2025-02-05 06:01:00	t	0.004624	1
255	serverpod_database	default	2025-02-05 06:02:00	t	0.004777	1
256	serverpod_database	default	2025-02-05 06:03:00	t	0.005582	1
257	serverpod_database	default	2025-02-05 06:04:00	t	0.004881	1
258	serverpod_database	default	2025-02-05 06:05:00	t	0.003599	1
259	serverpod_database	default	2025-02-05 06:06:00	t	0.002232	1
260	serverpod_database	default	2025-02-05 06:07:00	t	0.004635	1
261	serverpod_database	default	2025-02-05 06:08:00	t	0.003425	1
262	serverpod_database	default	2025-02-05 06:09:00	t	0.004918	1
263	serverpod_database	default	2025-02-05 06:10:00	t	0.004841	1
264	serverpod_database	default	2025-02-05 06:11:00	t	0.004127	1
265	serverpod_database	default	2025-02-05 06:12:00	t	0.003274	1
266	serverpod_database	default	2025-02-05 06:13:00	t	0.00337	1
267	serverpod_database	default	2025-02-05 06:14:00	t	0.005162	1
268	serverpod_database	default	2025-02-05 06:15:00	t	0.005283	1
269	serverpod_database	default	2025-02-05 06:16:00	t	0.004461	1
270	serverpod_database	default	2025-02-05 06:17:00	t	0.004016	1
271	serverpod_database	default	2025-02-05 06:18:00	t	0.004801	1
272	serverpod_database	default	2025-02-05 06:19:00	t	0.004252	1
273	serverpod_database	default	2025-02-05 06:20:00	t	0.004589	1
274	serverpod_database	default	2025-02-05 06:21:00	t	0.005098	1
275	serverpod_database	default	2025-02-05 06:22:00	t	0.003349	1
276	serverpod_database	default	2025-02-05 06:23:00	t	0.003047	1
277	serverpod_database	default	2025-02-05 06:24:00	t	0.005007	1
278	serverpod_database	default	2025-02-05 06:25:00	t	0.002319	1
279	serverpod_database	default	2025-02-05 06:26:00	t	0.003909	1
280	serverpod_database	default	2025-02-05 06:27:00	t	0.004243	1
281	serverpod_database	default	2025-02-05 06:28:00	t	0.006205	1
282	serverpod_database	default	2025-02-05 06:29:00	t	0.00337	1
283	serverpod_database	default	2025-02-05 06:30:00	t	0.004596	1
284	serverpod_database	default	2025-02-05 06:31:00	t	0.004588	1
285	serverpod_database	default	2025-02-05 06:32:00	t	0.005278	1
286	serverpod_database	default	2025-02-05 06:33:00	t	0.00451	1
287	serverpod_database	default	2025-02-05 06:34:00	t	0.003628	1
288	serverpod_database	default	2025-02-05 06:35:00	t	0.004011	1
289	serverpod_database	default	2025-02-05 06:36:00	t	0.003843	1
290	serverpod_database	default	2025-02-05 06:37:00	t	0.005106	1
291	serverpod_database	default	2025-02-05 06:38:00	t	0.005483	1
292	serverpod_database	default	2025-02-05 06:39:00	t	0.00463	1
293	serverpod_database	default	2025-02-05 06:40:00	t	0.004541	1
294	serverpod_database	default	2025-02-05 06:41:00	t	0.003969	1
295	serverpod_database	default	2025-02-05 06:42:00	t	0.004745	1
296	serverpod_database	default	2025-02-05 06:43:00	t	0.005267	1
297	serverpod_database	default	2025-02-05 06:44:00	t	0.003942	1
298	serverpod_database	default	2025-02-05 06:45:00	t	0.003315	1
299	serverpod_database	default	2025-02-05 06:46:00	t	0.003124	1
300	serverpod_database	default	2025-02-05 06:47:00	t	0.004988	1
301	serverpod_database	default	2025-02-05 06:48:00	t	0.005153	1
302	serverpod_database	default	2025-02-05 06:49:00	t	0.004032	1
303	serverpod_database	default	2025-02-05 06:50:00	t	0.005474	1
304	serverpod_database	default	2025-02-05 06:51:00	t	0.003038	1
305	serverpod_database	default	2025-02-05 06:52:00	t	0.004749	1
306	serverpod_database	default	2025-02-05 06:53:00	t	0.005754	1
307	serverpod_database	default	2025-02-05 06:54:00	t	0.004211	1
308	serverpod_database	default	2025-02-05 06:55:00	t	0.00422	1
309	serverpod_database	default	2025-02-05 06:56:00	t	0.004437	1
310	serverpod_database	default	2025-02-05 06:57:00	t	0.005947	1
311	serverpod_database	default	2025-02-05 06:58:00	t	0.004039	1
312	serverpod_database	default	2025-02-05 06:59:00	t	0.003818	1
313	serverpod_database	default	2025-02-05 07:00:00	t	0.004596	1
314	serverpod_database	default	2025-02-05 07:01:00	t	0.004662	1
315	serverpod_database	default	2025-02-05 07:02:00	t	0.004954	1
316	serverpod_database	default	2025-02-05 07:03:00	t	0.004644	1
317	serverpod_database	default	2025-02-05 07:04:00	t	0.0047	1
318	serverpod_database	default	2025-02-05 07:05:00	t	0.004136	1
319	serverpod_database	default	2025-02-05 07:06:00	t	0.005951	1
320	serverpod_database	default	2025-02-05 07:07:00	t	0.005162	1
321	serverpod_database	default	2025-02-05 07:08:00	t	0.002165	1
322	serverpod_database	default	2025-02-05 07:09:00	t	0.004934	1
323	serverpod_database	default	2025-02-05 07:10:00	t	0.005793	1
324	serverpod_database	default	2025-02-05 07:11:00	t	0.003269	1
325	serverpod_database	default	2025-02-05 07:12:00	t	0.003254	1
326	serverpod_database	default	2025-02-05 07:13:00	t	0.00501	1
327	serverpod_database	default	2025-02-05 07:14:00	t	0.004116	1
328	serverpod_database	default	2025-02-05 07:15:00	t	0.004547	1
329	serverpod_database	default	2025-02-05 07:16:00	t	0.004625	1
330	serverpod_database	default	2025-02-05 07:17:00	t	0.005069	1
331	serverpod_database	default	2025-02-05 07:18:00	t	0.005856	1
332	serverpod_database	default	2025-02-05 07:19:00	t	0.002534	1
333	serverpod_database	default	2025-02-05 07:20:00	t	0.003639	1
334	serverpod_database	default	2025-02-05 07:21:00	t	0.004387	1
335	serverpod_database	default	2025-02-05 07:22:00	t	0.005303	1
336	serverpod_database	default	2025-02-05 07:23:00	t	0.006343	1
337	serverpod_database	default	2025-02-05 07:24:00	t	0.006044	1
338	serverpod_database	default	2025-02-05 07:25:00	t	0.004642	1
339	serverpod_database	default	2025-02-05 07:26:00	t	0.001792	1
340	serverpod_database	default	2025-02-05 07:27:00	t	0.005917	1
341	serverpod_database	default	2025-02-05 07:28:00	t	0.004734	1
342	serverpod_database	default	2025-02-05 07:29:00	t	0.00417	1
343	serverpod_database	default	2025-02-05 07:30:00	t	0.004727	1
344	serverpod_database	default	2025-02-05 07:31:00	t	0.004008	1
345	serverpod_database	default	2025-02-05 07:32:00	t	0.003693	1
346	serverpod_database	default	2025-02-05 07:33:00	t	0.004253	1
347	serverpod_database	default	2025-02-05 07:34:00	t	0.003022	1
348	serverpod_database	default	2025-02-05 07:35:00	t	0.001849	1
349	serverpod_database	default	2025-02-05 07:36:00	t	0.001892	1
350	serverpod_database	default	2025-02-05 07:37:00	t	0.002081	1
351	serverpod_database	default	2025-02-05 07:38:00	t	0.002193	1
352	serverpod_database	default	2025-02-05 07:39:00	t	0.003429	1
353	serverpod_database	default	2025-02-05 07:40:00	t	0.002307	1
354	serverpod_database	default	2025-02-05 07:41:00	t	0.002092	1
355	serverpod_database	default	2025-02-05 07:42:00	t	0.002741	1
356	serverpod_database	default	2025-02-05 07:43:00	t	0.00678	1
357	serverpod_database	default	2025-02-05 07:44:00	t	0.003453	1
358	serverpod_database	default	2025-02-05 07:45:00	t	0.003983	1
359	serverpod_database	default	2025-02-05 07:46:00	t	0.003574	1
360	serverpod_database	default	2025-02-05 07:47:00	t	0.003737	1
361	serverpod_database	default	2025-02-05 07:48:00	t	0.005793	1
362	serverpod_database	default	2025-02-05 07:49:00	t	0.004701	1
363	serverpod_database	default	2025-02-05 07:50:00	t	0.005098	1
364	serverpod_database	default	2025-02-05 07:51:00	t	0.00456	1
365	serverpod_database	default	2025-02-05 07:52:00	t	0.005826	1
367	serverpod_database	default	2025-02-05 07:53:00	t	0.005923	1
368	serverpod_database	default	2025-02-05 07:54:00	t	0.004654	1
369	serverpod_database	default	2025-02-05 07:55:00	t	0.004019	1
370	serverpod_database	default	2025-02-05 07:56:00	t	0.004074	1
371	serverpod_database	default	2025-02-05 07:57:00	t	0.005466	1
372	serverpod_database	default	2025-02-05 07:58:00	t	0.00562	1
373	serverpod_database	default	2025-02-05 07:59:00	t	0.00459	1
374	serverpod_database	default	2025-02-05 08:00:00	t	0.003348	1
375	serverpod_database	default	2025-02-05 08:01:00	t	0.004657	1
376	serverpod_database	default	2025-02-05 08:02:00	t	0.004189	1
377	serverpod_database	default	2025-02-05 08:03:00	t	0.005704	1
378	serverpod_database	default	2025-02-05 08:04:00	t	0.004642	1
379	serverpod_database	default	2025-02-05 08:05:00	t	0.004493	1
380	serverpod_database	default	2025-02-05 08:06:00	t	0.00433	1
381	serverpod_database	default	2025-02-05 08:07:00	t	0.001532	1
383	serverpod_database	default	2025-02-05 08:08:00	t	0.00535	1
384	serverpod_database	default	2025-02-05 08:09:00	t	0.004635	1
385	serverpod_database	default	2025-02-05 08:10:00	t	0.001091	1
386	serverpod_database	default	2025-02-05 08:11:00	t	0.002983	1
387	serverpod_database	default	2025-02-05 08:12:00	t	0.004542	1
388	serverpod_database	default	2025-02-05 08:13:00	t	0.002271	1
389	serverpod_database	default	2025-02-05 08:14:00	t	0.004441	1
390	serverpod_database	default	2025-02-05 08:15:00	t	0.00327	1
391	serverpod_database	default	2025-02-05 08:16:00	t	0.002652	1
392	serverpod_database	default	2025-02-05 08:17:00	t	0.004625	1
393	serverpod_database	default	2025-02-05 08:18:00	t	0.005341	1
394	serverpod_database	default	2025-02-05 08:19:00	t	0.004858	1
395	serverpod_database	default	2025-02-05 08:20:00	t	0.004826	1
396	serverpod_database	default	2025-02-05 08:21:00	t	0.004663	1
397	serverpod_database	default	2025-02-05 08:22:00	t	0.003408	1
398	serverpod_database	default	2025-02-05 08:23:00	t	0.00507	1
399	serverpod_database	default	2025-02-05 08:24:00	t	0.004989	1
400	serverpod_database	default	2025-02-05 08:25:00	t	0.004442	1
401	serverpod_database	default	2025-02-05 08:26:00	t	0.004854	1
402	serverpod_database	default	2025-02-05 08:27:00	t	0.005217	1
403	serverpod_database	default	2025-02-05 08:28:00	t	0.005332	1
404	serverpod_database	default	2025-02-05 08:29:00	t	0.004187	1
405	serverpod_database	default	2025-02-05 08:30:00	t	0.004818	1
406	serverpod_database	default	2025-02-05 08:31:00	t	0.004592	1
407	serverpod_database	default	2025-02-05 08:32:00	t	0.00432	1
408	serverpod_database	default	2025-02-05 08:40:00	t	0.007772	1
410	serverpod_database	default	2025-02-05 08:41:00	t	0.005784	1
411	serverpod_database	default	2025-02-05 08:42:00	t	0.003461	1
412	serverpod_database	default	2025-02-05 08:43:00	t	0.004856	1
413	serverpod_database	default	2025-02-05 08:44:00	t	0.004626	1
414	serverpod_database	default	2025-02-05 08:45:00	t	0.004552	1
415	serverpod_database	default	2025-02-05 08:46:00	t	0.004372	1
416	serverpod_database	default	2025-02-05 08:47:00	t	0.004554	1
417	serverpod_database	default	2025-02-05 08:48:00	t	0.004666	1
418	serverpod_database	default	2025-02-05 08:49:00	t	0.004679	1
419	serverpod_database	default	2025-02-05 08:50:00	t	0.005424	1
420	serverpod_database	default	2025-02-05 08:51:00	t	0.004679	1
421	serverpod_database	default	2025-02-05 08:52:00	t	0.004977	1
422	serverpod_database	default	2025-02-05 08:53:00	t	0.00442	1
423	serverpod_database	default	2025-02-05 08:54:00	t	0.003869	1
424	serverpod_database	default	2025-02-05 08:55:00	t	0.00486	1
425	serverpod_database	default	2025-02-05 08:56:00	t	0.004764	1
426	serverpod_database	default	2025-02-05 08:57:00	t	0.00365	1
427	serverpod_database	default	2025-02-05 08:58:00	t	0.004251	1
428	serverpod_database	default	2025-02-05 08:59:00	t	0.00347	1
429	serverpod_database	default	2025-02-05 09:00:00	t	0.004382	1
430	serverpod_database	default	2025-02-05 09:01:00	t	0.003419	1
431	serverpod_database	default	2025-02-05 09:02:00	t	0.003761	1
432	serverpod_database	default	2025-02-05 09:03:00	t	0.003531	1
433	serverpod_database	default	2025-02-05 09:04:00	t	0.004897	1
434	serverpod_database	default	2025-02-05 09:05:00	t	0.005051	1
435	serverpod_database	default	2025-02-05 09:06:00	t	0.005234	1
436	serverpod_database	default	2025-02-05 09:07:00	t	0.003587	1
437	serverpod_database	default	2025-02-05 09:08:00	t	0.004062	1
438	serverpod_database	default	2025-02-05 09:09:00	t	0.005526	1
439	serverpod_database	default	2025-02-05 09:10:00	t	0.003583	1
440	serverpod_database	default	2025-02-05 09:11:00	t	0.004394	1
441	serverpod_database	default	2025-02-05 09:12:00	t	0.004116	1
442	serverpod_database	default	2025-02-05 09:13:00	t	0.004589	1
443	serverpod_database	default	2025-02-05 09:14:00	t	0.004411	1
444	serverpod_database	default	2025-02-05 09:15:00	t	0.00476	1
445	serverpod_database	default	2025-02-05 09:16:00	t	0.004116	1
446	serverpod_database	default	2025-02-05 09:17:00	t	0.004514	1
447	serverpod_database	default	2025-02-05 09:18:00	t	0.004513	1
448	serverpod_database	default	2025-02-05 09:19:00	t	0.005166	1
449	serverpod_database	default	2025-02-05 09:20:00	t	0.003034	1
450	serverpod_database	default	2025-02-05 09:21:00	t	0.003131	1
451	serverpod_database	default	2025-02-05 09:22:00	t	0.003333	1
452	serverpod_database	default	2025-02-05 09:23:00	t	0.00357	1
453	serverpod_database	default	2025-02-05 09:24:00	t	0.005527	1
454	serverpod_database	default	2025-02-05 09:25:00	t	0.002857	1
455	serverpod_database	default	2025-02-05 09:26:00	t	0.003037	1
456	serverpod_database	default	2025-02-05 09:27:00	t	0.002789	1
457	serverpod_database	default	2025-02-05 09:28:00	t	0.004543	1
458	serverpod_database	default	2025-02-05 09:29:00	t	0.00328	1
459	serverpod_database	default	2025-02-05 09:30:00	t	0.004443	1
460	serverpod_database	default	2025-02-05 09:31:00	t	0.002188	1
461	serverpod_database	default	2025-02-05 09:32:00	t	0.004792	1
462	serverpod_database	default	2025-02-05 09:33:00	t	0.004511	1
463	serverpod_database	default	2025-02-05 09:34:00	t	0.004725	1
464	serverpod_database	default	2025-02-05 09:35:00	t	0.005171	1
465	serverpod_database	default	2025-02-05 09:36:00	t	0.004828	1
466	serverpod_database	default	2025-02-05 09:37:00	t	0.004786	1
467	serverpod_database	default	2025-02-05 09:38:00	t	0.004721	1
468	serverpod_database	default	2025-02-05 09:39:00	t	0.004457	1
469	serverpod_database	default	2025-02-05 09:40:00	t	0.004944	1
470	serverpod_database	default	2025-02-05 09:41:00	t	0.006375	1
471	serverpod_database	default	2025-02-05 09:42:00	t	0.003947	1
472	serverpod_database	default	2025-02-05 09:43:00	t	0.005086	1
473	serverpod_database	default	2025-02-05 09:44:00	t	0.003925	1
474	serverpod_database	default	2025-02-05 09:45:00	t	0.004808	1
475	serverpod_database	default	2025-02-05 09:46:00	t	0.004394	1
476	serverpod_database	default	2025-02-05 09:47:00	t	0.004088	1
477	serverpod_database	default	2025-02-05 09:48:00	t	0.00501	1
478	serverpod_database	default	2025-02-05 09:49:00	t	0.005122	1
479	serverpod_database	default	2025-02-05 09:50:00	t	0.005065	1
480	serverpod_database	default	2025-02-05 09:51:00	t	0.003603	1
481	serverpod_database	default	2025-02-05 09:52:00	t	0.003657	1
482	serverpod_database	default	2025-02-05 09:53:00	t	0.003902	1
483	serverpod_database	default	2025-02-05 09:54:00	t	0.003731	1
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
221	886866
222	660266
223	869473
224	415880
225	491343
226	397989
227	215928
228	856501
229	457332
230	453155
231	607626
232	363350
233	857747
234	575366
235	610335
236	332854
237	696539
238	91375
239	393467
240	359888
241	573682
242	549457
243	334100
244	67724
245	558561
246	272399
247	234897
248	907610
249	605100
250	835613
251	59466
252	999601
253	380829
254	789040
255	110181
256	122203
257	925425
258	578814
259	611121
260	163203
261	860644
262	512640
263	392647
264	669003
265	476549
266	862198
267	584245
268	937256
269	365500
270	654628
271	360255
272	661061
273	984930
274	195054
275	757657
276	279491
277	654374
278	761170
279	33857
280	84676
281	73620
282	311686
283	413672
284	648019
285	490361
286	802728
287	822505
288	251423
289	139379
290	605125
291	750440
292	913701
293	395213
294	631428
295	609516
296	691143
297	742028
298	922122
299	327696
300	506553
301	597641
302	572395
303	797634
304	164586
305	509937
306	648940
307	283431
308	225107
309	390505
310	737837
311	921221
312	962836
313	406776
314	627984
315	679079
316	780556
317	689524
318	534376
319	219630
320	7457
321	209023
322	793663
323	23380
324	323639
325	627711
326	806218
327	533527
328	923684
329	408195
330	590384
331	33736
332	691294
333	644438
334	787392
335	340324
336	670699
337	583800
338	628135
339	619915
340	172130
341	4580
342	120810
343	982745
344	248806
345	34562
346	91468
347	961038
348	225416
349	948288
350	514794
351	362007
352	938906
353	652691
354	983817
355	342669
356	632210
357	651128
358	845150
359	989536
360	644881
361	752827
362	67910
363	737491
364	814853
365	337686
366	373676
367	136896
368	829465
369	750167
370	974101
371	468854
372	194582
373	593514
374	903749
375	251907
376	424375
377	702796
378	675075
379	795523
380	954143
381	689802
382	257764
383	807008
384	880973
385	975559
386	251996
387	831528
388	538760
389	770217
390	337824
391	654959
392	368123
393	433292
394	360967
395	363796
396	995371
397	899103
398	776352
399	487056
400	587666
401	376096
402	290702
403	971524
404	363205
405	459065
406	37622
407	175815
408	137132
409	893175
410	977062
411	404827
412	761219
413	692591
414	301737
415	208090
416	206646
417	504519
418	505707
419	846460
420	320
421	45484
422	655805
423	56710
424	552852
425	445617
426	726381
427	624273
428	15828
429	105315
430	274734
431	599207
432	464172
433	437628
434	752030
435	917533
436	48719
437	167217
438	367985
439	648534
440	781290
441	375044
442	999906
443	818289
444	241988
445	893681
446	40643
447	147703
448	963005
449	898967
450	234690
451	47234
452	174641
453	385231
454	973804
455	796830
456	633667
457	823377
458	630154
459	316149
460	665940
461	497307
462	490551
463	717872
464	642029
465	71665
466	572026
467	864501
468	964871
469	145547
470	28327
471	889950
472	226944
473	146113
474	900036
475	728068
476	621990
477	733834
478	798433
479	740054
480	56633
481	951120
482	505166
483	375697
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

SELECT pg_catalog.setval('public.serverpod_health_connection_info_id_seq', 476, true);


--
-- Name: serverpod_health_metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serverpod_health_metric_id_seq', 483, true);


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

SELECT pg_catalog.setval('public.serverpod_readwrite_test_id_seq', 483, true);


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

