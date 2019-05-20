# proxysql-sandbox

ProxySql docker recipes for mysql query logging

The goal of this repo is to document the steps required to setup/configure
[ProxySql](https://github.com/sysown/proxysql) for the simple use case of
logging and analysing a subset of queries/users to a specific MySQL instance.

This example is built on top of the excellent
[severalnines ProxySql Image](https://hub.docker.com/r/severalnines/proxysql),
which also documentation for some more complicated use cases.

The included mysql/Dockerfile is solely there as an example to create a sample
table with some data.

The below steps will create a network with a mysql and a proxymysql container.
The logging is then configure with the ProxySql Admin interface.

## create a network

```bash
docker network create --driver=bridge tst-net
```

## connect a mysql instance

```bash
docker run -d --name=tst-mysql \
--network=tst-net \
-p 33101:3306 \
-e MYSQL_ROOT_PASSWORD=secret \
-e MYSQL_DATABASE=mysqldb \
-e MYSQL_USER=mysql1usr \
-e MYSQL_PASSWORD=mysql1pwd \
krislamote/mysql:0.1.0
```

## connect a proxysql instance

```bash
docker run -d --name=tst-proxysql \
--network=tst-net \
--publish 6032:6032 \
--publish 6033:6033 \
--publish 6080:6080 \
--restart=unless-stopped \
severalnines/proxysql:latest
```

## configure proxyslq

docker exec -it tst-proxysql mysql -uadmin -padmin -h127.0.0.1 -P6032 --prompt='Admin> '

```sql
INSERT INTO mysql_servers (hostgroup_id, hostname) VALUES (100, 'tst-mysql');
INSERT INTO mysql_query_rules (rule_id, active, match_digest, log, apply) VALUES (1,1,'.',1,0);
INSERT INTO mysql_users(username, password, default_hostgroup, default_schema) VALUES ('mysql1usr', 'mysql1pwd', 100, 'mysqldb');
SET mysql-eventslog_filename='/var/lib/proxysql/queries.log';

LOAD MYSQL SERVERS TO RUNTIME;
LOAD MYSQL USERS TO RUNTIME;
LOAD MYSQL QUERY RULES TO RUNTIME;
LOAD MYSQL VARIABLES TO RUNTIME;
LOAD ADMIN VARIABLES TO RUNTIME;

SAVE MYSQL SERVERS TO DISK;
SAVE MYSQL USERS TO DISK;
SAVE MYSQL QUERY RULES TO DISK;
SAVE MYSQL VARIABLES TO DISK;
SAVE ADMIN VARIABLES TO DISK;
```

## next steps

- use image that can use the queries.log
- convert the above sql statements to a config/settings file
- covert this to docker-compose file
