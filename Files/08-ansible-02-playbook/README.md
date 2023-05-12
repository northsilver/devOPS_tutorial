# Playbook
Cодержит два плея: Install Clickhouse и Install Vector.
## Install Clickhouse.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml)
Определяют версию clickhouse и устанавливаемые пакеты.
### Tasks:
1. Get clickhouse distrib - скачивает дистрибутив нужной версии.
2. Install clickhouse packages - устанавливает полученный дистрибутив.
   Через handler (Start clickhouse service) запускает service clickhouse. 
3. Pause for 10 seconds - пауза 10 секунд для перезапуска  clickhouse.
4. Create database - создаёт базу данных `logs`.
## Install Vector.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-02-playbook/playbook/group_vars/vector/vars.yml)
Определяют версию vector.
### Tasks:
1. Get Vector version - проверяет установлен ли vector.
2. Create directory vector - создает директорию для установки.
3. Get vector distrib - скачивает требуемую версию vector.
4. Configuring service vector - настраивает работу vector в качестве сервиса и запускает его.

Для создания окружения использовался yandex cloud. 