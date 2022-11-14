# MsyuLuch_infra
MsyuLuch Infra repository

# Выполнено ДЗ № 9

 - [+] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
 1. В директории `аnsible`:
    - `inventory`, `inventory.yml` - описание инстансов, которыми будем управлять
    - `ansible.cfg` - конфигурационный файл, в котором указаны основные, общие параметры для подключения к инстансам
    - `site.yml` - ansible playbook основной, подключает:
        - `db.yml` - ansible playbook изменяет конфигурацию БД
        - `app.yml` - ansible playbook настраивает хост приложения
        - `deploy.yml` - ansible playbook деплой приложения

 2. Запустим ansible playbook

 ```
        $ ansible-playbook --check site.yml
        $ ansible-playbook site.yml
 ```

 3. Изменим provision в Packer и заменим bash-скрипты на ansible playbook

    - `packer_app.yml` - устанавливает Ruby и Bundler
    - `packer_db.yml` - добавляет репозиторий MongoDB, устанавливает MongoDB и запускает сервис

    В директории `packer` изменим `app.pkr.hcl` и `db.pkr.hcl`:

    ```
        provisioner "ansible" {
            playbook_file = "ansible/packer_app.yml"
        }
    ........
        provisioner "ansible" {
            playbook_file = "ansible/packer_db.yml"
        }
    ```

    Пересоздадим инфраструктуру с помощью `terraform apply` и запустим `ansible-playbook site.yml`

    Доступность прилождения проверим http://51.250.72.52:9292/


## Как запустить проект:

        ```
        .../terraform/stage$ terraform apply

        .../ansible$ ansible-playbook site.yml
        ```

## Как проверить работоспособность:

    http://51.250.72.52:9292/

## PR checklist
 - [+] Выставил label с темой домашнего задания
