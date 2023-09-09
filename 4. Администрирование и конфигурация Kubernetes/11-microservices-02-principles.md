### Задание 1


| API Gateway                                              | Маршрутизация запросов | Аутентификация в запросах | HTTPS |
|:---------------------------------------------------------|:----------------------:|:-------------------------:|:-----:|
| [NGINX](https://www.nginx.com)                           |           +            |             +             |   +   |
| [HAProxy](https://www.haproxy.com/)                      |           +            |             +             |   +   |
| [KrakenD](https://www.krakend.io)                        |           +            |             +             |   +   |
| [Gravitee.io](https://www.gravitee.io/)                  |           +            |             +             |   +   |
| [Kong Gateway](https://konghq.com/products/kong-gateway) |           +            |             +             |   +   |
| [Apache APISIX](https://apisix.apache.org/)              |           +            |             +             |   +   |
| [Apigee](https://cloud.google.com/apigee)                |           +            |             +             |   +   |
| [Tyk](https://tyk.io/open-source-api-gateway/)           |           +            |             +             |   +   |
| [WSO2 API Manager](https://wso2.com/api-manager/)        |           +            |             +             |   +   |

- Многие API Gateway обеспечивают необходимые в задании требования
- Более популярным, распространенным и сочетающим в себе еще и другие функции я бы выбрал NGINX или HAProxy.

### Задание 2

| Брокер                                                                     | Поддержка кластера | Хранение сообщений на диске | Высокая скорость работы | Форматы | Распределение прав | Простота использования |    
|:---------------------------------------------------------------------------|:------------------:|:---------------------------:|:-----------------------:|:-------:|:------------------:|:----------------------:|
| [RabbitMQ](https://www.rabbitmq.com)                                       |         +          |              +              |         4K-10K          |    +    |         +          |           +            |
| [Apache Kafka](https://kafka.apache.org/)                                  |         +          |              +              |        2 million        |    +    |         +          |          +/-           |
| [Apache ActiveMQ Artemis](https://activemq.apache.org/components/artemis/) |         +          |              +              |         10K-40K         |    +    |         +          |           +            |
| [Memphis](https://github.com/memphisdev/memphis)                           |         +          |              +              |     300K + (queue)      |    +    |         +          |           +            |
| [ZeroMQ](https://zeromq.org/)                                              |         -          |              -              |         66K-70K         |    +    |         -          |           -            |

- по предъявляемым требованиям подойдет в порядке убывания: Memphis, Apache Kafka, Apache ActiveMQ