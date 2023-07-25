locals {
  function_name = var.function_name
  root_dir      = abspath("../../")
}

resource "random_string" "random" {
  length  = 4
  special = false
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir  = "${local.root_dir}/src/functions/${var.function_path}"
  output_path = "${local.root_dir}/assets/${local.function_name}-${random_string.random.result}.zip"
  excludes    = ["node_modules"]
}

resource "google_storage_bucket_object" "archive" {
  name   = "functions/${var.function_name}-${random_string.random.result}.zip"
  bucket = var.bucket_name
  source = "${local.root_dir}/assets/${local.function_name}-${random_string.random.result}.zip"
}

resource "google_cloudfunctions_function" "http" {
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#argument-reference

  name                = var.function_name
  region              = var.region
  description         = var.description
  runtime             = var.runtime
  entry_point         = var.entry_point
  timeout             = var.timeout
  available_memory_mb = var.available_memory_mb

  source_archive_bucket = var.bucket_name
  source_archive_object = google_storage_bucket_object.archive.name

  labels = {
    output_sha = data.archive_file.zip.output_sha
    deploy     = "terraform"
  }



  environment_variables = var.environment_variables

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#event_type
  trigger_http          = true
  service_account_email = var.service_account_email

  lifecycle {
    replace_triggered_by = [google_storage_bucket_object.archive]
  }
}

output "function_name" {
  value = local.function_name
}

output "function_endpoint_url" {
  value = google_cloudfunctions_function.http.https_trigger_url
}
