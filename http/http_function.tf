module "source_file" {
  source = "../_modules/arquive_file"

  function_path = var.function_path
  function_name = var.function_name
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
  source_archive_object = source_file.function_zip_source_name

  labels = {
    output_sha = source_file.output_sha
    deploy     = "terraform"
  }



  environment_variables = var.environment_variables

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#event_type
  trigger_http          = true
  service_account_email = var.service_account_email

  lifecycle {
    replace_triggered_by = [source_file.function_archive]
  }
}

output "function_name" {
  value = var.function_name
}

output "function_endpoint_url" {
  value = google_cloudfunctions_function.http.https_trigger_url
}
