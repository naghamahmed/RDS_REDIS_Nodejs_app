terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-tf-app"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
