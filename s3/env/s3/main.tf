provider "aws" {
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket  = "vamsi-aws-provisioning"
    key     = "terraform/s3/state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
module "s3" {
  source                = "../../modules/s3"
  s3_bucket_name        = "vamsi-s3-aws-8977"
  all_roles             = "AWSServiceRoleForSupport"
}
