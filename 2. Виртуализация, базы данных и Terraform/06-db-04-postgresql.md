- Задание 1

```bash
- вывода списка БД,
  \l[+]   [PATTERN]      list databases
- подключения к БД,
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "test_database")
-вывода списка таблиц,
  \dt[S+] [PATTERN]      list tables
-вывода описания содержимого таблиц,
  \d[S+]  NAME           describe table, view, sequence, or index
-выхода из psql.
  \q                     quit psql
```

- Задание 2

```bash
test_database=# ANALYZE orders;
ANALYZE
test_database=# SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders' order by avg_width desc limit 1;
 attname | avg_width 
---------+-----------
 title   |        16
(1 row)
```

- Задание 3

```bash
test_database=# SELECT * from orders;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  2 | My little database   |   500
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  6 | WAL never lies       |   900
  7 | Me and my bash-pet   |   499
  8 | Dbiezdmin            |   501
(8 rows)

test_database=# alter table public.orders rename to orders_backup;
ALTER TABLE
test_database=# create table public.orders (
      like public.orders_backup
      including defaults
      including constraints
      including indexes
  );
CREATE TABLE
test_database=#  create table public.orders_1 (
      check (price>499)
  ) inherits (public.orders);
CREATE TABLE
test_database=#  create table public.orders_2 (
      check (price<=499)
  ) inherits (public.orders);
CREATE TABLE
test_database=#   ALTER TABLE public.orders_1 OWNER TO postgres;
ALTER TABLE
test_database=#   ALTER TABLE public.orders_2 OWNER TO postgres;
ALTER TABLE
test_database=#   create rule orders_adove_499 as on insert to public.orders
  where (price>499)
  do instead insert into public.orders_1 values(NEW.*);
CREATE RULE
test_database=# create rule orders_below_499 as on insert to public.orders
  where (price<=499)
  do instead insert into public.orders_2 values(NEW.*);
CREATE RULE
test_database=# insert into public.orders (id,title,price) select id,title,price from public.orders_backup;
INSERT 0 0
test_database=# alter table public.orders_backup alter id drop default;
ALTER TABLE
test_database=# ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
ALTER SEQUENCE
test_database=# drop table public.orders_backup;
DROP TABLE
test_database=# SELECT * from orders_1;
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# SELECT * from orders_2;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)
```

Да, можно избежать если изначально задать правила для таблиц.

- Задание 4

```bash
export PGPASSWORD=admin && pg_dump -h localhost -U postgres test_database > /media/postgresql/backup/test_database_$(date +%d-%m-%y).sql

[[vagrant@localhost backup]$ ls -la
total 8
drwxrwxr-x. 2 vagrant vagrant   61 Mar  5 15:56 .
drwx------. 6 vagrant vagrant  197 Mar  5 15:52 ..
-rw-r--r--. 1 root    root    4064 Mar  5 15:55 test_database_05-03-23.sql
-rw-rw-r--. 1 vagrant vagrant 2082 Mar  5 08:52 test_dump.sql
```
Если я правильно понял задание, то к примеру, добавил бы уникальный номер лицензии 
```bash
ALTER TABLE orders
ADD CONSTRAINT unique_goverment_license_id
UNIQUE(title);
```