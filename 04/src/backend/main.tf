# создание S3 бакета
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3_bucket" {
  source      = "git::https://github.com/terraform-yc-modules/terraform-yc-s3"
  bucket_name = "tfstate-${random_string.unique_id.result}"
  versioning = {
    enabled = true
  }
}

# создание сервисного аккаунта
resource "yandex_iam_service_account" "tfstate-storage-editor-sa" {
  name        = var.sa_name
  folder_id   = var.folder_id
  description = "service account to manage tfstate"
}

# добавление роли storage.editor для сервисного аккаунта
resource "yandex_storage_bucket_iam_binding" "bucket-iam" {
  bucket = module.s3_bucket.bucket_name
  role   = "storage.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.tfstate-storage-editor-sa.service_account_id}",
  ]
}

resource "yandex_storage_bucket_grant" "my_grant_1" {
  bucket = module.s3_bucket.bucket_name
  grant {
    id          = yandex_iam_service_account.tfstate-storage-editor-sa.service_account_id
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

}

# создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.tfstate-storage-editor-sa.service_account_id
  description        = "static access key for object storage"
}

# создание файла .aws/credentials
resource "local_file" "aws_credentials" {
  content = templatefile("${path.module}/credentials.tpl", {
    profile_name = var.profile_name
    access_key   = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key   = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket       = module.s3_bucket.bucket_name
  })
  filename = pathexpand("~/.aws/credentials")
}

# создание файла .aws/config
resource "local_file" "aws_config" {
  content = templatefile("${path.module}/config.tpl", {
    profile_name = var.profile_name
    bucket       = module.s3_bucket.bucket_name
  })
  filename = pathexpand("~/.aws/config")
}
