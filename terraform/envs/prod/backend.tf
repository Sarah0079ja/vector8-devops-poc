terraform {
  backend "s3" {
    bucket         = "vector8-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}
