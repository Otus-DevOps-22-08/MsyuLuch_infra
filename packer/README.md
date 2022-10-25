# MsyuLuch_infra
MsyuLuch Infra repository

# Выполнено ДЗ № 5

 - [+] Основное ДЗ
 - [+] Задание со *

## В процессе сделано:
 1. Создаем файл-шаблон для Packer в формате *.json, *.hcl

    ```
    $ packer validate ./ubuntu16.json
    $ packer hcl2_upgrade ubuntu16.json
    $ packer validate ./ubuntu16.pkr.hcl
    ```

2. Запускаем сборку образа. Для проверки образа приложение нужно установить вручную

    ```
    $ packer build -var-file=variables.json ubuntu16.json
    $ packer build -var-file=variables.hcl ubuntu16.pkr.hcl
    ```

3. Описываем шаблон для Immutable образа с предустановленным приложением

    ```
    $ packer build -var-file=variables.hcl immutable.pkr.hcl

    $ yc compute image list
    ```

    Для автоматического создания ВМ с предустановленным приложением запускаем

    ```
    $ yc compute instance create \
        --name reddit-app \
        --hostname reddit-app \
        --memory=4 \
        --create-boot-disk image-folder-id=b1g6q04gp8vhlg95vctg,image-family=reddit-full,size=10GB \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --metadata serial-port-enable=1 \
        --ssh-key ~/.ssh/appuser.pub
    ```

## Как запустить проект:

    testapp_IP = 84.252.129.67
    testapp_port = 9292

    1. Команда создания образа `packer build -var-file=variables.hcl ubuntu16.pkr.hcl`
    2. Команда создания immutable образа `packer build -var-file=variables.hcl immutable.pkr.hcl`
    3. Скрипт создания ВМ из immutable образа `config-scripts/create-reddit-vm.sh`

## Как проверить работоспособность:

    http://84.252.129.67:9292/

## PR checklist
 - [+] Выставил label с темой домашнего задания
