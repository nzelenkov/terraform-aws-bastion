provider "aws" {
    version    = "~> 2.7"
    region     = var.region
}
resource "aws_key_pair" "aws-key" {
    key_name = "aws-key"
    public_key = file(var.pub_key)
}
resource "aws_default_vpc" "default" {
  enable_dns_hostnames = true
}
resource "aws_subnet" "subnet-frontend" {
    cidr_block = "172.31.16.0/20"
    vpc_id = aws_default_vpc.default.id
    map_public_ip_on_launch = true
    tags = {
        Name = "frontend subnet"
    }
}
resource "aws_subnet" "subnet-backend" {
    cidr_block = "172.31.32.0/20"
    vpc_id = aws_default_vpc.default.id
    map_public_ip_on_launch = false
    tags = {
        Name = "backend subnet"
    }
}
resource "aws_security_group" "allow_ssh_https" {
    name        = "allow_ssh_https"
    description = "Allow inbound traffic on ports 22(internal subnet), 80 and 443 (public); Allow outbount to all"
    vpc_id = aws_default_vpc.default.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["172.31.0.0/16"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "Allow ssh & http/https"
    }
}