# Домашнее задание к занятию «Продвинутые методы работы с Terraform» - Муравский Артем

---

1. Скриншот страницы веб консоли Yandex Cloud с созданными ВМ с помощью remote-модуля

![vms](img/screen1.png)

Скриншоты вывода команды `module.analytics_vm` в `terraform console`

![terraform console1](img/screen2.png)

![terraform console2](img/screen3.png)

Скриншоты вывода команды `sudo nginx -t` в консоли ВМ

![vm console1](img/screen4.png)

![vm console2](img/screen5.png)

---

2. [Файл с документацией модуля vpc](src/vpc/DOC.md)

Скриншот вывода команды `module.project_vpc` в `terraform console`

![my module output](img/screen6.png)

---

3. Просмотр ресурсов, которые находятся в terraform state выполняется с помощью команды `terraform state list`

![terraform state list](img/screen7.png)

Удаление ресурсов в terraform state (но не самого ресурса в облаке!) выполняется с помощью команды `terraform rm '<resource>'`
Скриншот удаления ресурса `project_vpc` из terraform state

![terraform state rm vpc](img/screen8.png)

Скриншот удаления ресурсов `marketing_vm` и `analytics_vm` из terraform state

![terraform state rm vm](img/screen9.png)

Импорт ресурсов в terraform state выполняется с помощью команды `terraform import '<resource>' id`, значение `id` у ресурсов Yandex Cloud можно узнать в веб консоли

Скриншоты импорта ресурсов `module.project_vpc.yandex_vpc_network.my_vpc` и `module.project_vpc.yandex_vpc_subnet.my_subnet`

![terraform import vpc1](img/screen10.png)

![terraform import vpc2](img/screen11.png)

Скриншот импорта ресурсов `module.marketing_vm.yandex_compute_instance.vm[0]` и `module.analytics_vm.yandex_compute_instance.vm[0]`

![terraform import vms](img/screen12.png)

Скриншот выполнения команды `terraform plan` после импорта ресурсов

![terraform plan after imports](img/screen13.png)

---

4. [Модуль vpc](src/vpc)

Скриншот вывода команды `module.project_vpc` в `terraform console`

![my module output2](img/screen14.png)

Скриншот страницы веб консоли Yandex Cloud с подсетями созданных модулем vpc 

![subnets YC web console](img/screen15.png)

---

5. [Модуль создания MySQL кластера](src/db)

Скриншоты веб консоли Yandex Cloud с созданным MySQL кластером (не HA)

![cluster not ha 1](img/screen16.png)

![cluster not ha 2](img/screen19.png)

[Модуль создания базы данных и пользователя](src/create_db)

Скриншот веб консоли Yandex Cloud с созданной базой данных `test` в MySQL кластере

![bd](img/screen17.png)

Скриншот веб консоли Yandex Cloud с созданным пользователем `app` в MySQL кластере

![bd user](img/screen18.png)

Скриншоты веб консоли Yandex Cloud после установления флага `ha = true` (создан дополнительный хост в кластере)

![cluster ha](img/screen20.png)

---

6. Скриншот веб консоли Yandex Cloud с созданным S3 бакетом

![s3](img/screen21.png)

---

7. Скриншот вывода значения секрета из HashiCorp Vault (команда `nonsensitive(data.vault_generic_secret.vault_example.data.test)`, выполненная в `terraform console`)

![terraform console secret](img/screen22.png)

Скриншот значения секрета, записанного в HashiCorp Vault с помощью Terraform

![vault secret](img/screen23.png)

---

8. [VPC root-модуль](src/vpc), чтение из его `terraform.tfstate` выходных переменных в [main.tf](src/main.tf) строки 108-114 и далее использование этих переменных в модулях создания ВМ
