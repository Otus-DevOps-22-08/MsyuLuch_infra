# MsyuLuch_infra
MsyuLuch Infra repository

# Выполнено ДЗ № 3

 - [+] Основное ДЗ
 - [+] Задание со *

## В процессе сделано:
 1. Генерируем ключь для пользователя appuser

    ```
    ssh-keygen -t rsa -f ~/.ssh/appuser -C appuser -P ""

    ```

 2. Создаем 2 ВМ (bastion, someinternalhost)

    для подключения с локальной машины на bastion:
    ```
    $ ssh -i ~/.ssh/appuser appuser@51.250.13.237
    ```

    для подключения к someinternalhost настроим SSH Forwarding и
    добавим приватный ключ в ssh агент авторизации:
    ```
    $ ssh-add -L
    $ ssh-add ~/.ssh/appuser
    $ ssh -i ~/.ssh/appuser -A appuser@51.250.13.237

    appuser@bastion:~$ ssh 10.128.0.28
    ```
    подключения к someinternalhost в одну команду с локальной машины (-J флаг для указания хоста, который будет выступать как прокси):

    ```
    $ ssh -i ~/.ssh/appuser -A -J appuser@51.250.13.237 appuser@10.128.0.28
    ```

    если список хостов перехода статический можно описать его с помощью конфигурационного файла:

    ```
    FILE ~/.ssh/configProxyJump Example
    ### First jump host. Directly reachable
    Host bastion
     User appuser
     HostName 51.250.13.237

    ### Host to jump to via bastion
    Host someinternalhost
     User appuser
     HostName 10.128.0.28
     ProxyJump  bastion
    ```

    и теперь можно напрямую обратиться к хосту someinternalhost

    ```
    $ ssh someinternalhost
    ```

3. Создаем VPN-сервер для серверов Yandex.Cloud

    Для этого развернем на ВМ докер и запустим контейнер с VPN-сервером Pritunl

    Конфигурационный файл для Pritunl доступен в репозитории

    Проверяем возможность подключения к someinternalhost с локального компьютера после подключения к VPN:

    ```
    $ ssh -i ~/.ssh/appuser appuser@10.128.0.28
    $ ssh -i ~/.ssh/appuser appuser@someinternalhost
    ```

## Как запустить проект:

    bastion_IP = 51.250.13.237
    someinternalhost_IP = 10.128.0.28

## Как проверить работоспособность:

   https://primsyu.tk/

## PR checklist
 - [+] Выставил label с темой домашнего задания
