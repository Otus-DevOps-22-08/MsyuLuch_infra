# MsyuLuch_infra
MsyuLuch Infra repository

# Выполнено ДЗ № 8

 - [+] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
 1. Создана директория `Ansible`:
    - `inventory`, `inventory.yml` - описание инстансов, которыми будем управлять
    - `ansible.cfg` - конфигурационный файл, в котором указаны основные, общие параметры для подключения к инстансам
    - `clone.yml` - ansible playbook клонирует удаленный репозоторий в домашнюю директорию пользователя

 2. Основные команды:

 ```
        $ ansible app -m ping
        $ ansible app -m command -a 'ruby -v'
        $ ansible app -m shell -a 'ruby -v; bundler -v'

        $ ansible db -m command -a 'systemctl status mongod'
        $ ansible db -m shell -a 'systemctl status mongod'
        $ ansible db -m service -a name=mongod

        $ ansible app -m git -a \
            'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit'
        $ ansible app -m command -a \
            'git clone https://github.com/express42/reddit.git /home/appuser/reddit'

        $ ansible-playbook clone.yml
 ```

 3. Запустим ansible playbook

    ```
        $ ansible-playbook clone.yml
    ```
    Результатом работы будет клонирование удаленного репозитория в папку пользователя. Затем выполним команду:

    ```
        $ ansible app -m command -a 'rm -rf ~/reddit'
    ```
    В результате папка с репозиторием будет удалена из директории пользователя

    Если теперь повторно запустить команду:
    ```
        $ ansible-playbook clone.yml
        PLAY [Clone] ***********************************************************************************
        TASK [Gathering Facts]**************************************************************************
        ok: [appserver]
        TASK [Clone repo]*******************************************************************************
        changed: [appserver]
        PLAY RECAP *************************************************************************************
        appserver: ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    ```

    Ansible скачает удаленный репозиторий повторно.
    Ansible не хранит текущего сосотояния после выполнения команд. Каждая команда будет отработана повторно.

## Как запустить проект:

    - Установить Ansible 2.4 и выше
    - Установить Python 2.7 и выше

## Как проверить работоспособность:

    ```
            $ ansible app -m ping
            $ ansible app -m command -a 'ruby -v'
            $ ansible app -m shell -a 'ruby -v; bundler -v'

            $ ansible db -m command -a 'systemctl status mongod'
            $ ansible db -m shell -a 'systemctl status mongod'
            $ ansible db -m service -a name=mongod

            $ ansible app -m git -a \
                'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit'
            $ ansible app -m command -a \
                'git clone https://github.com/express42/reddit.git /home/appuser/reddit'

            $ ansible-playbook clone.yml
    ```

## PR checklist
 - [+] Выставил label с темой домашнего задания
