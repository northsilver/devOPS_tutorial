- Задание 1
```text
В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
replication - запускается столько экземпляров приложения сколько будет указано, это кол-во может быть рапределено или присуствовать только на одной ноде из нескольких.
global - запускается один экземпляр на одну ноду.
Какой алгоритм выбора лидера используется в Docker Swarm кластере?
Raft - он поддерживает согласованность между нодами, кол-во нод manager должно быть от 3х, но не более 7.
Что такое Overlay Network?
Тип сети, когда поверх существующей может быть образована еще одна. по сути L2 VPN.
```
- Задание 2

![Screenshot from 2023-02-21 22-21-13.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-22%2012-34-08.png?raw=true)

- Задание 3

![Screenshot from 2023-02-21 22-21-13.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-22%2013-18-54.png?raw=true)
