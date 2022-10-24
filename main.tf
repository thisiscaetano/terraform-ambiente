terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = ">= 4.0"
  }
  backend "s3" {
    bucket = "admin-terraform-curso-state"
    key    = "terraform-ambiente.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile                  = "default"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = "us-east-1"
}

module "ec2" {
  source    = "git@github.com:thisiscaetano/terraform-aws-ec2.git"
  int_type  = "t2.micro"
  int_name  = "web"
  user_data = file("./files/userdata.sh")
  ami       = "ami-09d3b3274b6c5d4aa"
  subnet = module.vpc.public_subnets
}

module "vpc" {
  source    = "git@github.com:thisiscaetano/terraform-aws-vpc.git"
  vpc_name  = "dev"
  vpc_cidr  = "172.32.0.0/16"
  nat_count = 2

}
