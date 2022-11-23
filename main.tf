terraform {
  backend "s3" {
    key    = "terraform"
    region = "eu-central-1"
  }
}
