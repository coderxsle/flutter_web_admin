# book_store_server

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres and Redis. It's easiest to do with Docker.

    docker compose up --build --detach

Then you can start the Serverpod server.

    dart bin/main.dart

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis.

    docker compose stop




// 用户和角色挂钩，角色与资源挂钩，设计成 5 张表。
//
// 用户表 sys_user
// 角色表 sys_role
// 资源表 sys_resource
// 用户角色表 sys_user_role
// 角色资源表 sys_role_resource