INSERT INTO clickhouse_users (username,password) VALUES ('clicku','clickp');
INSERT INTO mysql_users(username,password) SELECT username, password FROM clickhouse_users;
INSERT INTO mysql_servers(hostname,port) VALUES ('127.0.0.1',6090);