terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

data "template_file" "user_data" {
    template = file("cloud-config.cfg")
}

resource "aws_instance" "app_server" {
  ami           = "ami-05c13eab67c5d8861"
  instance_type = "t2.micro"
  user_data     = data.template_file.user_data.rendered

  tags = {
    Name = "Terraform-Provisioned-VM"
  }
}
