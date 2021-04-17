variable "project" {
}

variable "region" {
  default = "asia-northeast1"
}

variable "db_name" {
  default = "test"
}

# bucket name for storing secret data
variable "bucket_name" {
}

variable "db_user" {
  default = "root"
}
