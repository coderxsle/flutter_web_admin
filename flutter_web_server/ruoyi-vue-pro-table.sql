DROP TABLE IF EXISTS system_menu;
CREATE TABLE system_menu
(
    id             int8         NOT NULL,
    name           varchar(50)  NOT NULL,
    permission     varchar(100) NOT NULL DEFAULT '',
    type           int2         NOT NULL,
    sort           int4         NOT NULL DEFAULT 0,
    parent_id      int8         NOT NULL DEFAULT 0,
    path           varchar(200) NULL     DEFAULT '',
    icon           varchar(100) NULL     DEFAULT '#',
    component      varchar(255) NULL     DEFAULT NULL,
    component_name varchar(255) NULL     DEFAULT NULL,
    status         int2         NOT NULL DEFAULT 0,
    visible        bool         NOT NULL DEFAULT '1',
    keep_alive     bool         NOT NULL DEFAULT '1',
    always_show    bool         NOT NULL DEFAULT '1',
    creator        varchar(64)  NULL     DEFAULT '',
    create_time    timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater        varchar(64)  NULL     DEFAULT '',
    update_time    timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted        int2         NOT NULL DEFAULT 0
);
ALTER TABLE system_menu
    ADD CONSTRAINT pk_system_menu PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_role_menu;
CREATE TABLE system_role_menu
(
    id          int8        NOT NULL,
    role_id     int8        NOT NULL,
    menu_id     int8        NOT NULL,
    creator     varchar(64) NULL     DEFAULT '',
    create_time timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater     varchar(64) NULL     DEFAULT '',
    update_time timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted     int2        NOT NULL DEFAULT 0,
    tenant_id   int8        NOT NULL DEFAULT 0
);
ALTER TABLE system_role_menu
    ADD CONSTRAINT pk_system_role_menu PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_users;
CREATE TABLE system_users
(
    id          int8         NOT NULL,
    username    varchar(30)  NOT NULL,
    password    varchar(100) NOT NULL DEFAULT '',
    nickname    varchar(30)  NOT NULL,
    remark      varchar(500) NULL     DEFAULT NULL,
    dept_id     int8         NULL     DEFAULT NULL,
    post_ids    varchar(255) NULL     DEFAULT NULL,
    email       varchar(50)  NULL     DEFAULT '',
    mobile      varchar(11)  NULL     DEFAULT '',
    sex         int2         NULL     DEFAULT 0,
    avatar      varchar(512) NULL     DEFAULT '',
    status      int2         NOT NULL DEFAULT 0,
    login_ip    varchar(50)  NULL     DEFAULT '',
    login_date  timestamp    NULL     DEFAULT NULL,
    creator     varchar(64)  NULL     DEFAULT '',
    create_time timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater     varchar(64)  NULL     DEFAULT '',
    update_time timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted     int2         NOT NULL DEFAULT 0,
    tenant_id   int8         NOT NULL DEFAULT 0
);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_role;
CREATE TABLE system_role
(
    id                  int8         NOT NULL,
    name                varchar(30)  NOT NULL,
    code                varchar(100) NOT NULL,
    sort                int4         NOT NULL,
    data_scope          int2         NOT NULL DEFAULT 1,
    data_scope_dept_ids varchar(500) NOT NULL DEFAULT '',
    status              int2         NOT NULL,
    type                int2         NOT NULL,
    remark              varchar(500) NULL     DEFAULT NULL,
    creator             varchar(64)  NULL     DEFAULT '',
    create_time         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater             varchar(64)  NULL     DEFAULT '',
    update_time         timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted             int2         NOT NULL DEFAULT 0,
    tenant_id           int8         NOT NULL DEFAULT 0
);
ALTER TABLE system_role
    ADD CONSTRAINT pk_system_role PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_user_role;
CREATE TABLE system_user_role
(
    id          int8        NOT NULL,
    user_id     int8        NOT NULL,
    role_id     int8        NOT NULL,
    creator     varchar(64) NULL     DEFAULT '',
    create_time timestamp   NULL     DEFAULT CURRENT_TIMESTAMP,
    updater     varchar(64) NULL     DEFAULT '',
    update_time timestamp   NULL     DEFAULT CURRENT_TIMESTAMP,
    deleted     int2        NOT NULL DEFAULT 0,
    tenant_id   int8        NOT NULL DEFAULT 0
);

ALTER TABLE system_user_role
    ADD CONSTRAINT pk_system_user_role PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_dept;
CREATE TABLE system_dept
(
    id             int8        NOT NULL,
    name           varchar(30) NOT NULL DEFAULT '',
    parent_id      int8        NOT NULL DEFAULT 0,
    sort           int4        NOT NULL DEFAULT 0,
    leader_user_id int8        NULL     DEFAULT NULL,
    phone          varchar(11) NULL     DEFAULT NULL,
    email          varchar(50) NULL     DEFAULT NULL,
    status         int2        NOT NULL,
    creator        varchar(64) NULL     DEFAULT '',
    create_time    timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater        varchar(64) NULL     DEFAULT '',
    update_time    timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted        int2        NOT NULL DEFAULT 0,
    tenant_id      int8        NOT NULL DEFAULT 0
);
ALTER TABLE system_dept
    ADD CONSTRAINT pk_system_dept PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_post;
CREATE TABLE system_post
(
    id          int8         NOT NULL,
    code        varchar(64)  NOT NULL,
    name        varchar(50)  NOT NULL,
    sort        int4         NOT NULL,
    status      int2         NOT NULL,
    remark      varchar(500) NULL     DEFAULT NULL,
    creator     varchar(64)  NULL     DEFAULT '',
    create_time timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater     varchar(64)  NULL     DEFAULT '',
    update_time timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted     int2         NOT NULL DEFAULT 0,
    tenant_id   int8         NOT NULL DEFAULT 0
);
ALTER TABLE system_post
    ADD CONSTRAINT pk_system_post PRIMARY KEY (id);

-- ***************************************************************************************
DROP TABLE IF EXISTS system_user_post;
CREATE TABLE system_user_post
(
    id          int8        NOT NULL,
    user_id     int8        NOT NULL DEFAULT 0,
    post_id     int8        NOT NULL DEFAULT 0,
    creator     varchar(64) NULL     DEFAULT '',
    create_time timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater     varchar(64) NULL     DEFAULT '',
    update_time timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted     int2        NOT NULL DEFAULT 0,
    tenant_id   int8        NOT NULL DEFAULT 0
);

ALTER TABLE system_user_post
    ADD CONSTRAINT pk_system_user_post PRIMARY KEY (id);








