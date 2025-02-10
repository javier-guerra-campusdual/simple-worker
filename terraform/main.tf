# VPC y Networking
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "bluengo-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "bluengo-public-subnet"
  }
}

# Security Group
resource "aws_security_group" "bluengo_sg" {
  name        = "bluengo-sg"
  description = "Security group for Bluengo application"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




/*
# EC2 Instance
resource "aws_instance" "bluengo_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  
  vpc_security_group_ids = [aws_security_group.bluengo_sg.id]
  
  user_data = file("../scripts/user_data.sh")

  tags = {
    Name = "bluengo-server"
  }
}
*/