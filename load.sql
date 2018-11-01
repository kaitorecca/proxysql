INSERT INTO clickhouse_users (username,password) VALUES ('clicku','clickp');
INSERT INTO mysql_users(username,password) SELECT username, password FROM clickhouse_users;
INSERT INTO mysql_servers(hostname,port) VALUES ('127.0.0.1',6090);
UPDATE global_variables SET variable_value = 'clickhouse' WHERE variable_name = 'clickhouse-hostname';

LOAD CLICKHOUSE USERS TO RUNTIME;
LOAD CLICKHOUSE USERS TO MEMORY
SAVE CLICKHOUSE USERS TO DISK;
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;
SAVE MYSQL SERVERS TO DISK;
LOAD MYSQL SERVERS TO RUNTIME;
LOAD MYSQL VARIABLES TO RUNTIME;
LOAD ADMIN VARIABLES TO RUNTIME;
LOAD CLICKHOUSE VARIABLES TO RUNTIME;
