provider "aws" {
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "vamsi-aws-provisioning"
    key    = "terraform/linux_ec2/state/terraform.tfstate"
    region = "us-east-1"
    encrypt        = true
  }
}
module "linux_ec2" {
  ec2_instance_name     = "ec2awsl"
  ec2_instance_count    = "1"
  instance_type         = "t2.micro"
  vpc_id                = "vpc-04455ebb614d65c23"
  subnet_ids            = ["subnet-03d56fcd682550ca0"]
  availability_zones    = ["us-east-1b"]
  source                = "../../modules/ec2_linux"
  key_name              = "vamsi_aws"
}