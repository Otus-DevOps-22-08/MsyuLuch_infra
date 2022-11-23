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


# MsyuLuch_infra
MsyuLuch Infra repository

Status of Last Deployment: <br>
<img src="https://github.com/Otus-DevOps-22-08/MsyuLuch_infra/actions/workflows/run-tests.yml/badge.svg"><br>

# Выполнено ДЗ № 10

 - [+] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
 1. Ansible playbook сделанные в предыдущих заданиях разнесены в соответствующие директории,
 структура папок сделана командой `ansible-galaxy init app/db`:

    - `ansible/roles/app` - роль для конфигурирования хоста приложения
    - `ansible/roles/db` - роль для конфигурирования хоста базы данных
    - `ansible/playbooks/` - основные плэйбуки
    - `ansible/environment/(stage/prod)` - описание среды окружения для stage, prod контура
    - `ansible/environment/(stage/prod)/yc_compute.yml` - конфигурационный файл для создание динамического инвентори

 2. Запустим ansible playbook

 ```
        $ ansible-playbook --check site.yml
        $ ansible-playbook site.yml
 ```

 3. Установим коммьюнити-роли с портала Ansible Galaxy `jdauphant.nginx`, роль устанавливает и настраивает NGINX. Добавим её запуск к ansible playbook `app.yml`.

 4. Для безопасной работы с приватными данными (пароли, приватные ключи и т.д.) используем механизм Ansible Vault:

    - файл `vault.key` хранит произвольную строку ключа для шифрования данных
    - в файл `ansible.cfg` добавим ссылку на файл ключа

    - `credentials.yml` - хранит зашифрованные данные пользователей

5. Опишем роль для создания пользователей на хостах `users.yml`


6. Пересоздадим инфраструктуру с помощью `terraform apply` и запустим `ansible-playbook site.yml` (stage)

    Доступность прилождения проверим http://51.250.71.102/

7. В файл `.github/.pre-commit-config.yaml` добавлены проверки

```
## Проверки файлов terraform
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: v1.76.0
  hooks:
    - id: terraform_fmt
    - id: terraform_validate
    - id: terraform_tflint

## Проверки файлов ansible playbook
- repo: https://github.com/ansible-community/ansible-lint.git
  rev: v6.8.6
  hooks:
    - id: ansible-lint

## Проверки файлов packer
- repo: https://github.com/cisagov/pre-commit-packer
  rev: v0.0.2
  hooks:
    - id: packer_validate
```

## Как запустить проект:

        ```
        ...terraform apply

        ...ansible-playbook site.yml
        ```

## Как проверить работоспособность:

    http://51.250.71.102/

## PR checklist
 - [+] Выставил label с темой домашнего задания
