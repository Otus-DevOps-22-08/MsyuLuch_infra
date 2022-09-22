# MsyuLuch_infra
MsyuLuch Infra repository

# Выполнено ДЗ № 4

 - [+] Основное ДЗ
 - [+] Задание со *

## В процессе сделано:
 1. Устанавливаем и настраиваем YC CLI

    ```
    $ yc config list
    $ yc config profile list

    ```

 2. Создаем инстанс `reddit-app`

    ```
    yc compute instance create \
        --name reddit-app \
        --hostname reddit-app \
        --memory=4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --metadata serial-port-enable=1 \
        --ssh-key ~/.ssh/appuser.pub
    ```

    Для того, чтобы развернуть приложение на созданной ВМ, необходимо подключиться к ВМ, перенести на нее скрипты и запустить их:

    ```
    $ssh yc-user@51.250.91.225

    $sh install_ruby.sh
    $sh install_mongodb.sh
    $sh deploy.sh
    ```

    Для автоматического развертывания приложения на вновь созданной ВМ, указываем при создании файл `metadata.yaml`, в котором прописываем все действия по установке приложения:

    ```
    $ yc compute instance create \
        --name reddit-app \
        --hostname reddit-app \
        --memory=4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --metadata serial-port-enable=1 \
        --metadata-from-file user-data=metadata.yaml
    ```

## Как запустить проект:

    testapp_IP = 51.250.91.225
    testapp_port = 9292

## Как проверить работоспособность:

    http://51.250.91.225:9292/

## PR checklist
 - [+] Выставил label с темой домашнего задания
