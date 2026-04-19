# Домашнее задание к занятию «Продвинутые методы работы с Terraform» - Муравский Артем

---

1.
![vms](img/screen1.png)

![yc web console1](img/screen2.png)

![yc web console2](img/screen3.png)

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
