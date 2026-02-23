terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "tf-state-bucket-springapp-statefile"
    key    = "springapp/terraform.tfstate"
    region = "ap-south-1"
  }
  
}
