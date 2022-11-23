# MsyuLuch_infra
MsyuLuch Infra repository

Status of Last Deployment: <br>
<img src="https://github.com/Otus-DevOps-22-08/MsyuLuch_infra/actions/workflows/run-tests.yml/badge.svg"><br>

# Выполнено ДЗ № 11

 - [+] Основное ДЗ
 - [] Задание со *

## В процессе сделано:
 1. Опишем Vagrantfile, который создает 2 ВМ: первая для базы данных, вторая для приложения:

 ```
    config.vm.define "dbserver" do |db|
          db.vm.box = "ubuntu/xenial64"
          db.vm.hostname = "dbserver"
          db.vm.network :private_network, ip: "192.168.56.10"

          db.vm.provision "ansible" do |ansible|
            ansible.playbook = "playbooks/site.yml"
            ansible.groups = {
            "db" => ["dbserver"],
            "db:vars" => {"mongo_bind_ip" => "0.0.0.0"}
            }
          end
    end

    config.vm.define "appserver" do |app|
      app.vm.box = "ubuntu/xenial64"
      app.vm.hostname = "appserver"
      app.vm.network :private_network, ip: "192.168.56.20"

      app.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbooks/site.yml"
        ansible.groups = {
        "app" => ["appserver"],
        "app:vars" => { "db_host" => "192.168.56.10"}
        }
        ansible.extra_vars = {
          "deploy_user" => "vagrant",
          nginx_sites: {
            default: ["listen 80",
                      "server_name 'reddit'",
                      "location / {
                          proxy_pass http://127.0.0.1:9292;}"
                  ]
          }
        }
      end
    end
 ```

 Ansible playbook:

    - `ansible/roles/app` - роль для конфигурирования хоста приложения
    - `ansible/roles/db` - роль для конфигурирования хоста базы данных
    - `ansible/playbooks/site.yml` - основной плэйбук
    - `ansible/playbooks/base.yml` - устанавливает Python
    - `ansible/playbooks/deploy.yml` - устанавливает приложение
    - `ansible/playbooks/packer_db.yml` - вызывает роль db
    - `ansible/playbooks/packer_app.yml` - вызывает роль для установки Ruby && Bundler
    - `ansible/environment/(stage/prod)` - описание среды окружения для stage, prod контура
    - `ansible/environment/(stage/prod)/yc_compute.yml` - конфигурационный файл для создание динамического инвентори

 2. Доработаем роль db, разбив основной файл с задачами на несколько:

 ```
        ansible/roles/db/tasks/main.yml - основной файл с задачами, подключает вспомогательные
        ansible/roles/db/tasks/install_mongo.yml - устанавливает БД
        ansible/roles/db/tasks/config_mongo.yml - конфигурирует БД
 ```

 3. Доработаем роль app, разбив основной файл с задачами на несколько:

 ```
        ansible/roles/app/tasks/main.yml - основной файл с задачами, подключает вспомогательные
        ansible/roles/app/tasks/ruby.yml - устанавливает Ruby && Bundler
        ansible/roles/app/tasks/puma.yml - добавляет сервис puma
 ```

 4. Значения переменных зададим с помощью `ansible.extra_vars`:

    ```
            ansible.extra_vars = {
              "deploy_user" => "vagrant",
              nginx_sites: {
                default: ["listen 80",
                          "server_name 'reddit'",
                          "location / {
                              proxy_pass http://127.0.0.1:9292;}"
                      ]
              }
    ```

5. Для тестирования ролей установим Molecule (установку всех модулей рекомендуется выполнять в virtualenv среде)

    ```
      ##Инициализируем Molecule
      $molecule init scenario -r db -d vagrant

      ##Создадим инстанс для тестирования роли
      $molecule create

      ##Просмотреть список созданных инстансов
      $molecule list

      ##Применим роль к созданному инстансу
      $molecule converge

      ##Прогоним тесты
      $molecule verify
    ```

6. В файл `test_default.py` добавлен тест для проверки слушает ли БД на порту 27017:

```
    # check if MongoDB is listened on port 27017
    def test_mongo_port(host):
        socket = host.socket('tcp://0.0.0.0:27017')
        assert socket.is_listening
```

## Как запустить проект:

 1. Основные команды Vagrant

    ```
    vagrant up
    vagrant box list
    vagrant status
    vagrant ssh appserver (dbserver)
    vagrant provision appserver (dbserver)
    vagrant destroy -f

    ```

2. Основные команды для тестирования ролей

    ```
      ##Инициализируем Molecule
      $molecule init scenario -r db -d vagrant

      ##Создадим инстанс для тестирования роли
      $molecule create

      ##Просмотреть список созданных инстансов
      $molecule list

      ##Применим роль к созданному инстансу
      $molecule converge

      ##Прогоним тесты
      $molecule verify
    ```

## Как проверить работоспособность:

    http://158.160.42.117

## PR checklist
 - [+] Выставил label с темой домашнего задания
