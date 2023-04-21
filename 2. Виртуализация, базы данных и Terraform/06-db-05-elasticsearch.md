- Задание 1
Докер манифест
```bash
FROM centos:7

EXPOSE 9200 9300

RUN export HOME="/var/lib/elasticsearch" && \
    yum -y install wget && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.0-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c elasticsearch-7.16.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.16.0-linux-x86_64.tar.gz && \
    rm -f elasticsearch-7.16.0-linux-x86_64.tar.gz* && \
    mv elasticsearch-7.16.0 ${HOME} && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${HOME} && \
    yum -y remove wget && \
    yum clean all
COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/

USER elasticsearch

ENV HOME="/var/lib/elasticsearch" \
    PATH_CONF="/var/lib/elasticsearch/config"
WORKDIR ${HOME}

CMD ["sh", "-c", "${HOME}/bin/elasticsearch"]
```

[Ссылка на образ](https://hub.docker.com/layers/northsilver/elasticsearch/ver1.0/images/sha256-b2fbaa0b816c9cd6aeadf5b1904cae151d633809ca3839a2b3c7480fd077eafe?context=repo)

Ответ от эластика
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X GET "localhost:9200/?pretty"
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "5AmUaEUjSVWhT-QmGcad_g",
  "version" : {
    "number" : "7.11.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "6fc81662312141fe7691d7c1c91b8658ac17aa0d",
    "build_date" : "2021-12-02T15:46:35.697268109Z",
    "build_snapshot" : false,
    "lucene_version" : "8.7.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

- Задание 2
Создание реплик и шардов по индексам
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT http://localhost:9200/ind-1 -H 'Content-Type: application/json' -d '
{
        "settings": {
                "index": {
                "number_of_replicas":0,
                "number_of_shards":1
        }
}
}
'
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT http://localhost:9200/ind-2 -H 'Content-Type: application/json' -d '
{
        "settings": {
                "index": {
                "number_of_replicas":1,
                "number_of_shards":2
        }
}
}
'
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT http://localhost:9200/ind-3 -H 'Content-Type: application/json' -d '
{
        "settings": {
                "index": {
                "number_of_replicas":2,
                "number_of_shards":4
        }
}
}
'
```
Итого
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl http://localhost:9200/_cat/indices?v=true
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases XBkYnJFMSN6ThyTTt1IxNQ   1   0         42            0     40.7mb         40.7mb
green  open   ind-1            cP52r3BOTvmksf_TEki0lw   1   0          0            0       226b           226b
yellow open   ind-3            noNPwQs2SVOYwPYkYEeMGA   4   2          0            0       904b           904b
yellow open   ind-2            mrQN5_QPQRSdh2bzyFDg7A   2   1          0            0       452b           452b
```
Состояние кластера
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$  curl -ss http://localhost:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 10,
  "active_shards" : 10,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
```
Как говорили в лекции т.к. при создании индексов мы указали кол-во реплик больше 1 и в кластере одна нода, поэтому статус желтый, реплицировать некуда.

Удаление
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -ss -XDELETE http://localhost:9200/ind-1
{"acknowledged":true}
vagrant@sysadm-fs:~/devOPS_tutorial$  curl -ss -XDELETE http://localhost:9200/ind-2
{"acknowledged":true}
vagrant@sysadm-fs:~/devOPS_tutorial$  curl -ss -XDELETE http://localhost:9200/ind-3
{"acknowledged":true}
```

- Задание 3

Добавил в конфигурационный файл настройку и сделал запрос на регистрацию снапшота
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/elasticsearch/snapshots",
    "compress": true
  }
}'
```
Ответ
```bash
{
  "acknowledged" : true
}
```
Создал test
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT http://localhost:9200/test -H 'Content-Type: application/json' -d '
{
        "settings": {
                "index": {
                "number_of_replicas":0,
                "number_of_shards":1
        }
}
}
'
vagrant@sysadm-fs:~/devOPS_tutorial$ curl http://localhost:9200/_cat/indices?v=true
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases QzBAmNWAS8WWY0oqSfNpBA   1   0         42            0     40.7mb         40.7mb
green  open   test             GamwDlYtSLSaSY5PDbvoJA   1   0          0            0       226b           226b
```
Создал снапшот
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT "localhost:9200/_snapshot/netology_backup/%3Cmy_snapshot_%7Bnow%2Fd%7D%3E?pretty&wait_for_completion=true"
{
  "snapshot" : {
    "snapshot" : "my_snapshot_2023.03.16",
    "uuid" : "3zKE2nvRToqBkgq_eXCxfw",
    "repository" : "netology_backup",
    "version_id" : 7110099,
    "version" : "7.11.0",
    "indices" : [
      ".ds-.logs-deprecation.elasticsearch-default-2023.03.16-000001",
      ".geoip_databases",
      "test",
      ".ds-ilm-history-5-2023.03.16-000001"
    ],
    "data_streams" : [
      "ilm-history-5",
      ".logs-deprecation.elasticsearch-default"
    ],
    "include_global_state" : true,
    "state" : "SUCCESS",
    "start_time" : "2023-03-16T16:50:44.943Z",
    "start_time_in_millis" : 1678985444943,
    "end_time" : "2023-03-16T16:50:46.143Z",
    "end_time_in_millis" : 1678985446143,
    "duration_in_millis" : 1200,
    "failures" : [ ],
    "shards" : {
      "total" : 4,
      "failed" : 0,
      "successful" : 4
    },
    "feature_states" : [
      {
        "feature_name" : "geoip",
        "indices" : [
          ".geoip_databases"
        ]
      }
    ]
  }
}
```
Список файлов в директории 
```bash
bash-4.2$ ls -la /var/lib/elasticsearch/snapshots/
total 40
drwxr-xr-x 3 elasticsearch elasticsearch 4096 Mar 16 16:50 .
drwxr-xr-x 1 elasticsearch elasticsearch 4096 Mar 16 16:39 ..
-rw-r--r-- 1 elasticsearch elasticsearch 1434 Mar 16 16:50 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 Mar 16 16:50 index.latest
drwxr-xr-x 6 elasticsearch elasticsearch 4096 Mar 16 16:50 indices
-rw-r--r-- 1 elasticsearch elasticsearch 9709 Mar 16 16:50 meta-3zKE2nvRToqBkgq_eXCxfw.dat
-rw-r--r-- 1 elasticsearch elasticsearch  459 Mar 16 16:50 snap-3zKE2nvRToqBkgq_eXCxfw.dat
```
Удалил test и создал test-2
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -ss -XDELETE http://localhost:9200/test
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X PUT http://localhost:9200/test-2 -H 'Content-Type: application/json' -d '
{
        "settings": {
                "index": {
                "number_of_replicas":0,
                "number_of_shards":1
        }
}
}
'
vagrant@sysadm-fs:~/devOPS_tutorial$ curl http://localhost:9200/_cat/indices?v=true
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases QzBAmNWAS8WWY0oqSfNpBA   1   0         42            0     40.7mb         40.7mb
green  open   test-2           eWXAwZNmTmG0qUQBojViiA   1   0          0            0       226b           226b
```
Запрос восстановления из снапшота
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl -X POST "localhost:9200/_snapshot/netology_backup/my_snapshot_2023.03.16/_restore?pretty" -H 'Content-Type: application/json' -d'
{
    "indices": "*",
    "include_global_state": false
}
'
{
  "accepted" : true
}
```
Список после восстановления
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$  curl http://localhost:9200/_cat/indices?v=true
health status index                       uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases            PD5XflgbSomHl2TKzFFm0Q   1   0         84            0     81.4mb         81.4mb
green  open   test                        JbZDZp26TvaeOu9mH_82Nw   1   0          0            0       226b           226b
```
