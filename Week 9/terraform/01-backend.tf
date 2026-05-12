# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "class75-bucket"
    prefix = "terraform/state"
  }
}