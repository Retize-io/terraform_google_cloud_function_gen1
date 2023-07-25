resource "random_string" "random" {
  length  = 4
  special = false
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir  = var.function_path
  output_path = "/tmp/assets/${var.function_name}-${random_string.random.result}.zip"
  excludes    = ["node_modules"]
}

resource "google_storage_bucket_object" "archive" {
  name   = "functions/${var.function_name}-${random_string.random.result}.zip"
  bucket = var.bucket_name
  source = "/tmp/assets/${var.function_name}-${random_string.random.result}.zip"
}
