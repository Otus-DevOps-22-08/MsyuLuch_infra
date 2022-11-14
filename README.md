# MsyuLuch_infra
MsyuLuch Infra repository

Status of Last Deployment: <br>
<img src="https://github.com/Otus-DevOps-22-08/MsyuLuch_infra/actions/workflows/run-tests.yml/badge.svg?branch=master"><br>

# Выполнено ДЗ № 10

 - [+] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
 1. Ansible playbook сделанные в предыдущих заданиях разнесены в    соответствующие директории:

    - `roles/app` - роль для конфигурирования хоста приложения
    - `roles/db` - роль для конфигурирования хоста базы данных
    - `playbooks/` - основные плэйбуки
    - `environment/` - описание среды окружения для stage, prod контура
    - `environment/yc_compute.yml` - конфигурационный файл для     создание динамического инвентори

 2. Запустим ansible playbook

 ```
        $ ansible-playbook --check site.yml
        $ ansible-playbook site.yml
 ```

 3. Установим коммьюнити-роли с портала Ansible Galaxy `jdauphant.nginx`. Добавим её запуск к ansible playbook `app.yml`.

 4. Для безопасной работы с приватными данными (пароли,
приватные ключи и т.д.) используем механизм Ansible Vault:

    - файл `vault.key` хранит произвольную строку ключа для шифрования данных
    - в файл `ansible.cfg` добавим ссылку на файл ключа

    - `credentials.yml` - хранит зашифрованные данные пользователей

5. Опишем роль для создания пользователей на хостах `users.yml`


6. Пересоздадим инфраструктуру с помощью `terraform apply` и запустим `ansible-playbook site.yml` (stage)

    Доступность прилождения проверим http://51.250.71.102/


## Как запустить проект:

        ```
        ...terraform apply

        ...ansible-playbook site.yml
        ```

## Как проверить работоспособность:

    http://51.250.71.102/

## PR checklist
 - [+] Выставил label с темой домашнего задания
