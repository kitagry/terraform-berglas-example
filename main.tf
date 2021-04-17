provider "google" {
  project = var.project
  region = var.region
  version = "3.64.0"
}

resource "google_sql_database_instance" "master" {
  name = "master-instance"
  database_version = "MYSQL_5_7"
  region = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name = var.db_name
  instance = google_sql_database_instance.master.name
  charset = "utf8mb4"
  collation = "utf8mb4_bin"
}

resource "random_password" "db_password" {
  length = 10
  special = true
  override_special = "_%@"
}

resource "google_sql_user" "users" {
  name = "root"
  instance = google_sql_database_instance.master.name
  host = "%"
  password = random_password.db_password.result
}

resource "berglas_secret" "db_user" {
  bucket = var.bucket_name
  key = "projects/${var.project}/locations/global/keyRings/berglas/cryptoKeys/berglas-key"
  name = "DB_USER"
  plaintext = var.db_user
}

resource "berglas_secret" "db_pass" {
  bucket = var.bucket_name
  key = "projects/${var.project}/locations/global/keyRings/berglas/cryptoKeys/berglas-key"
  name = "DB_PASS"
  plaintext = random_password.db_password.result
}
