terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


#service role for CodeDeploy 
resource "aws_iam_role" "codeDeploy_service_role" {
  name = "CodeDeploy_service_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole", ]
}

#Role for EC2 instance 
resource "aws_iam_role" "EC2_Codedeploy_role" {
  name = "EC2_CodeDeploy_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "EC2_codedeploy_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:Get*",
            "s3:list"
          ]
          Effect   = "Allow"
          Resource = "*"

        },
      ]
    })
  }
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess", ]

}

#security group for EC2

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_security_group" "codeDeploy_ec2_sg" {
  name   = "sg_codeDeploy_ec2"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress  {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
}

#instance Profile for EC2 instance
resource "aws_iam_instance_profile" "CodeDeploy_EC2_profile" {
  name = "CodeDeploy_EC2_profile"
  role = aws_iam_role.EC2_Codedeploy_role.name
}
#creating an EC2 instance

resource "aws_instance" "CodeDeploy_EC2" {
  ami                  = "ami-02e136e904f3da870"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.CodeDeploy_EC2_profile.id
  tags = {
    Name = "codeDeploy"
  }
  vpc_security_group_ids = [aws_security_group.codeDeploy_ec2_sg.id]
  key_name = "Ec2_2021"
}

resource "aws_s3_bucket" "codeDeploy_bucket" {
  bucket = "codedeploy-gsingh"
}

#deploy the app now!


resource "aws_codedeploy_app" "WordPressApp" {
  compute_platform = "Server"
  name             = "WordPress_App"

}

resource "aws_codedeploy_deployment_group" "WordPress_deploy_group" {

  app_name              = aws_codedeploy_app.WordPressApp.name
  deployment_group_name = "WordPress_app_codedeploy_group"
  service_role_arn      = aws_iam_role.codeDeploy_service_role.arn
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
  deployment_style {
    deployment_type = "IN_PLACE"
  }
  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "codeDeploy"
  }

}
resource "aws_codedeploy_deployment_config" "WordPress_deploy_group_config" {

  deployment_config_name = "WordPress_deploy_group_config"
  compute_platform = "Server"
  minimum_healthy_hosts {
    
    type = "HOST_COUNT"
    value = 2
  }
}


