variable "project" {
  type = string
}
variable "function_name" {
  type = string
}
variable "description" {
  type = string
}
variable "runtime" {
  default = "nodejs18"
  type    = string
}
variable "entry_point" {
  type = string

}
variable "timeout" {
  type    = number
  default = "60"
}
variable "available_memory_mb" {
  type    = number
  default = "128"
}
variable "environment_variables" {
  type = map(string)
}
variable "region" {
  type    = string
  default = "us-central1"
}
variable "source_bucket_name" {
  type = string
}
variable "service_account_email" {
  type = string
}

variable "function_path" {
  type = string
}

variable "bucket_action" {
  type = string
}
variable "bucket_name" {
  type = string
}