- Задание 1

![Данные подключены](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-18%2020-09-57.png)

- Задание 2

![Добавил по заданию](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-18%2021-01-30.png)

```json
100 - avg by(instance) (irate(node_cpu_seconds_total{job="nodeexporter", mode="idle"}[$__interval])) * 100
avg by (instance)(rate(node_load1{}[$__rate_interval]))
avg by (instance)(rate(node_load5{}[$__rate_interval]))
avg by (instance)(rate(node_load15{}[$__rate_interval]))
avg(node_memory_MemFree_bytes{instance="nodeexporter:9100", job="nodeexporter"})/(1024^2)
```

- Задание 3

![Алерты](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-18%2021-28-09.png)

- Задание 4

[Dashboard](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/10-monitoring-03-grafana/help/grafana.json)