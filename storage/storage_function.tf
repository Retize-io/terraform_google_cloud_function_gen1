module "source_file" {
  source = "../_modules/arquive_file"

  function_path = var.function_path
  function_name = var.function_name
  bucket_name   = var.source_bucket_name
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

  source_archive_bucket = var.source_bucket_name
  source_archive_object = module.source_file.function_zip_source_name

  labels = {
    output_sha = module.source_file.output_sha
    deploy     = "terraform"
  }



  environment_variables = var.environment_variables

  event_trigger {
    event_type = var.bucket_action
    resource   = var.bucket_name
  }
  service_account_email = var.service_account_email

  lifecycle {
    replace_triggered_by = [module.source_file.arquive]
  }
}

output "function_name" {
  value = var.function_name
}

