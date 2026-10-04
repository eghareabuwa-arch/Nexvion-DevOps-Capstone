terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "contractflow-terraform"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_security_group" "nexvion" {
  name        = "nexvion-capstone-sg"
  description = "Security group for Nexvion DevOps Capstone"

  ingress {
    description = "HTTP access to Nexvion"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access for capstone administration"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "nexvion-capstone-sg"
    Project = "Nexvion"
  }
}

resource "aws_instance" "nexvion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = "nexvion-capstone-key"
  vpc_security_group_ids = [aws_security_group.nexvion.id]

  user_data = <<-EOF2
    #!/bin/bash
    dnf update -y
    dnf install -y docker
    systemctl enable docker
    systemctl start docker

    docker run -d \
      --name nexvion \
      --restart unless-stopped \
      -p 80:80 \
      nginx:alpine

    cat > /tmp/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Nexvion AWS Deployment</title>
    </head>
    <body>
      <h1>Nexvion DevOps Capstone</h1>
      <h2>AWS EC2 Deployment Successful</h2>
      <p>Provisioned using Terraform and running with Docker.</p>
    </body>
    </html>
    HTML

    docker cp /tmp/index.html nexvion:/usr/share/nginx/html/index.html
  EOF2

  tags = {
    Name        = "nexvion-capstone"
    Project     = "Nexvion"
    Environment = "Capstone"
    ManagedBy   = "Terraform"
  }
}

resource "aws_eip" "nexvion" {
  instance = aws_instance.nexvion.id
  domain   = "vpc"

  tags = {
    Name    = "nexvion-capstone-eip"
    Project = "Nexvion"
  }
}
