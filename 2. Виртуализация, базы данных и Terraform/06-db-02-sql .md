- Задание 1

```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ cat docker-compose.yaml 
version: '3.6'

volumes:
  data: {}
  backup: {}

services:

  postgres:
    image: postgres:12
    container_name: psql
    ports:
      - "0.0.0.0:5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/media/postgresql/backup
    environment:
      POSTGRES_USER: "test-admin-user"
      POSTGRES_PASSWORD: "admin"
      POSTGRES_DB: "test_db"
    restart: always
```

```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker-compose up -d
Creating network "devops_tutorial_default" with the default driver
Creating volume "devops_tutorial_data" with default driver
Creating volume "devops_tutorial_backup" with default driver
Pulling postgres (postgres:12)...
12: Pulling from library/postgres
bb263680fed1: Pull complete
75a54e59e691: Pull complete
3ce7f8df2b36: Pull complete
f30287ef02b9: Pull complete
dc1f0e9024d8: Pull complete
7f0a68628bce: Pull complete
32b11818cae3: Pull complete
48111fe612c1: Pull complete
f80b16d65234: Pull complete
f19fad3d1049: Pull complete
bf8102184052: Pull complete
a3b314ffacae: Pull complete
2ee35dbe1779: Pull complete
Digest: sha256:43b752e182ad5fd6b12d468f369853257fc88b3ab3494a55bacb60dc7af00c6d
Status: Downloaded newer image for postgres:12
Creating psql ... done
```

Для подключения понадобился еще клиент
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo apt install postgresql-client
vagrant@sysadm-fs:~/devOPS_tutorial$ export PGPASSWORD=admin && psql -h localhost -U test-admin-user test_db
psql (12.13 (Ubuntu 12.13-0ubuntu0.20.04.1), server 12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

test_db=# 
```

- Задание 2

Команды
```bash
CREATE TABLE orders(
   id INT PRIMARY KEY     NOT NULL,
   наименование           STR  ,
   цена            INT     NOT NULL
);

CREATE TABLE clients(
   id INT PRIMARY KEY     NOT NULL,
   фамилия           TEXT  ,
   "страна проживания" TEXT ,
   заказ            INT,
   FOREIGN KEY (заказ) REFERENCES orders (Id)
);

CREATE USER "test-simple-user" with password 'mypassword2';

GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO "test-simple-user";
GRANT SELECT, INSERT, UPDATE, DELETE ON clients TO "test-simple-user";
```
Результат
```bash
test_db=# \d orders
                  Table "public.orders"
    Column    |  Type   | Collation | Nullable | Default 
--------------+---------+-----------+----------+---------
 id           | integer |           | not null | 
 наименование | text    |           |          | 
 цена         | integer |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
````
```bash
test_db=# \d clients
                    Table "public.clients"
      Column       |  Type   | Collation | Nullable | Default 
-------------------+---------+-----------+----------+---------
 id                | integer |           | not null | 
 фамилия           | text    |           |          | 
 страна проживания | text    |           |          | 
 заказ             | integer |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```
```bash
     grantee      | table_name | privilege_type 
------------------+------------+----------------
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | TRIGGER
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | TRIGGER
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | UPDATE
 test-simple-user | clients    | DELETE
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | orders     | DELETE
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
(22 rows)
```
- Задание 3

```bash
test_db=# select * from clients;
 id |        фамилия        | страна проживания | заказ 
----+-----------------------+-------------------+-------
  1 | Иванов Иван Иванович  | USA               |      
  2 | Петров Петр Петрович  | Canada            |      
  3 |  Иоганн Себастьян Бах | Japan             |      
  4 | Ронни Джеймс Дио      | Russia            |      
  5 | Ritchie Blackmore     | Russia            |      
(5 rows)
```

```bash
test_db=# select * from orders;
 id | наименование | цена 
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)
```

```bash
test_db=# select count(*) from orders;
 count 
-------
     5
(1 row)

test_db=# select count(*) from clients;
 count 
-------
     5
(1 row)
```

- Задание 4

```bash
test_db=# update clients set заказ = (select id from orders where наименование = 'Книга') where фамилия = 'Иванов Иван Иванович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Монитор') where фамилия = 'Петров Петр Петрович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Гитара') where фамилия = ' Иоганн Себастьян Бах';
UPDATE 1
test_db=# select c.* from clients c join orders o on c.заказ = o.id;
 id |        фамилия        | страна проживания | заказ 
----+-----------------------+-------------------+-------
  1 | Иванов Иван Иванович  | USA               |     3
  2 | Петров Петр Петрович  | Canada            |     4
  3 |  Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```

- Задание 5

```bash
test_db=# explain select c.* from clients c join orders o on c.заказ = o.id;
                               QUERY PLAN                               
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)
```
```text
1) Будет прочитана таблица orders
2) Затем будет создан хэш по полю id, потом 
3) Будет прочитана таблица clients, для всех строк в поле заказ будет произведена проверка на соответсвие кэша в orders.
```
- Задание 6

Бэкап
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ export PGPASSWORD=admin && pg_dumpall -h localhost -U test-admin-user > /media/postgresql/backup/all_$(date --iso-8601=m | sed 's/://g; s/+/z/g').sql
```

Состояние после остановки и запуска нового
```bash
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS                    PORTS                  NAMES
e3c055fb9680   postgres:12   "docker-entrypoint.s…"   7 seconds ago   Up 7 seconds              5432/tcp               psql_new
be987077ac2d   postgres:12   "docker-entrypoint.s…"   2 hours ago     Exited (0) 7 minutes ago                         psql
```

Восстановление
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$  docker exec -it psql_new  bash
export PGPASSWORD=admin && psql -h localhost -U test-admin-user -f $(ls -1trh /media/postgresql/backup/all_*.sql) test_db
```