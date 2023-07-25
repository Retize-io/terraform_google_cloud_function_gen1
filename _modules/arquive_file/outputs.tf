output "function_zip_source_id" {
  value = google_storage_bucket_object.archive.id
}

output "function_zip_source_name" {
  value = google_storage_bucket_object.archive.name
}

output "output_sha" {
  value = data.archive_file.zip.output_sha
}

output "function_archive" {
  value = google_storage_bucket_object.archive
}
