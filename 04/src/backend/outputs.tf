output "bucket_name" {
  value = module.s3_bucket.bucket_name
}
output "access_key" {
  value     = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  sensitive = true
}
output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}
output "backend_config_example" {
  description = "Пример конфигурации backend для основного проекта"
  value       = <<-EOT
    # Поместите этот блок в основной проект (main.tf или отдельный файл backend.tf).
    # Проверьте наличие файлов ~/.aws/credentials и ~/.aws/config

    terraform {
      backend "s3" {
        shared_credentials_files = ["~/.aws/credentials"]
        profile     = "${var.profile_name}"
        bucket     = "${module.s3_bucket.bucket_name}"
        key    = "terraform.tfstate"
        region                   = "ru-central1"
        endpoints                = { s3 = "https://storage.yandexcloud.net" }
        use_lockfile = true

        skip_region_validation      = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        skip_s3_checksum            = true

      }
    }
  EOT
}
