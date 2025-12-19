terraform {
  backend "s3" {
    bucket         = "vector8-terraform-state-vintage007"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}
