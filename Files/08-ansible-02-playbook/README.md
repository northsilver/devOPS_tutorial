- Хендлер. Блок выполнение которого возможно только при явном его вызове. Он выполняется после всех tasks.
```text
- name: Install Clickhouse
    hosts: clickhouse
    handlers:
    - name: Start clickhouse service
```
- Здесь происходит перезагрузка серверной части сервиса Clickhouse
```text
become: true
  ansible.builtin.service:
  name: clickhouse-server
  state: restarted
```
- В блоке tasks создается структура "-block: ... rescue: ... always:". Суть структуры: если задачи из block завершаются с ошибкой, тогда не происходит остановки выполнения playbook, выполнение передается в блок rescue. После него выполнение задач переходит в блок always. Задачи из данного блока выполняются всегда.
```text
 tasks:
       - block:
       rescue:
       always:
```
- Задача получает из репозитория "noarch.rpm" пакеты. Пакеты нужны подбираются для серверной, клиентской и исполняемые файлы Clickhouse. Версия пакета и составные части берутся из файла переменных vars.yml. Название частей (клиент, сервер, исполняемые файлы) для которых производится подбор пакета, происходит в цикле
```text
name: Get clickhouse distrib (rpm noarch package)
 ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/{{ item }}-{{ clickhouse_version }}.noarch.rpm"
            dest: "./{{ item }}-{{ clickhouse_version }}.rpm"
          with_items: "{{ clickhouse_packages }}"
```
- Если в предыдущем блоке возникли ошибки, тогда пытаемся подобрать для исполняемой части x86_64.rpm нужной версии.
```text
 - name: Get clickhouse distrib (rpm package)
            ansible.builtin.get_url:
              url: https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-{{ clickhouse_version }}.x86_64.rpm
              dest: ./clickhouse-common-static-{{ clickhouse_version }}.rpm
```
- Устанавливаем скаченные пакеты
```text
become: true
            ansible.builtin.yum:
              name:
                - clickhouse-common-static-{{ clickhouse_version }}.rpm
                - clickhouse-client-{{ clickhouse_version }}.rpm
                - clickhouse-server-{{ clickhouse_version }}.rpm
```
- Строкой выше запускаем хендлер. Перезгружаем демон clickhouse-server.
```text
notify: Start clickhouse service
```
- Строкой ниже информируем о ходе процесса перезапуски демона
```text
- name: Flush handlers
            meta: flush_handlers
```
- Создание БД для принятия логов. ДБ создается выполнения поманды на настраиваемой ноде
```text
- name: Create database
            ansible.builtin.command: "clickhouse-client -q 'create database logs;'"
            register: create_db
            failed_when: create_db.rc != 0 and create_db.rc !=82
            changed_when: create_db.rc == 0
```
- По аналогии с предыдущими блоками - Установка, настройка, запуск Vector
```text
 - name: Install Vector
  hosts: vector
  handlers:
    - name: Start vector service
      become: true
      ansible.builtin.service:
        name: vector
        state: restarted
  tasks:
    - name: Get vector distrib
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/{{ vector_version }}/vector_{{ vector_version }}-1.x86_64.rpm"
        dest: "./vector-{{ vector_version }}.rpm"
    - name: Install vector packages
      become: true
      ansible.builtin.apt:
        deb: ./vector-{{ vector_version }}.rpm
      notify: Start vector service
```
