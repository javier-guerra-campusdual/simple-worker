resource "aws_instance" "bluengo_server" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.bluengo_sg.id]
  #iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable docker
              yum install -y docker
              service docker start
              usermod -aG docker ec2-user
              $(aws ecr get-login --no-include-email --region ${var.aws_region})
              docker pull 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-server
              docker pull 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-worker
              docker run -d -p 8080:8080 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-server
              docker run -d 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-worker
              EOF

  tags = {
    Name = "bluengo-server"
  }
}



/*
#!/bin/bash
              yum update -y
              amazon-linux-extras enable docker
              yum install -y docker
              service docker start
              usermod -aG docker ec2-user
              $(aws ecr get-login --no-include-email --region ${var.aws_region})
              docker pull 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-server
              docker pull 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-worker
              docker run -d -p 8080:8080 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-server
              docker run -d 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:bluengo-worker
              EOF
*/

/*

resource "aws_instance" "bluengo_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.bluengo_sg.id]

  # Instrucciones que se ejecutan al iniciar EC2
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo systemctl enable docker
    
    # Autenticarse en AWS ECR
    aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 248189943700.dkr.ecr.eu-west-1.amazonaws.com

    # Descargar la última imagen del contenedor
    docker pull 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:latest

    # Ejecutar el contenedor
    docker run -d -p 8080:8080 248189943700.dkr.ecr.eu-west-1.amazonaws.com/ecr-jgl-deploy:latest
  EOF

  tags = {
    Name = "bluengo-server"
  }
}
*/