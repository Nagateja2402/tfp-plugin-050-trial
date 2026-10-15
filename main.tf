terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 6.0" }
  }
}
provider "aws" { region = "us-east-1" }

resource "aws_s3_bucket" "tagged" {
  bucket_prefix = "tfp050-tagged-"
  tags          = { Owner = "nagateja", Env = "test" }
}

resource "aws_s3_bucket" "untagged" {
  bucket_prefix = "tfp050-untagged-"
}

resource "aws_security_group" "open" {
  name_prefix = "tfp050-"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
