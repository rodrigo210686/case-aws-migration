resource "aws_security_group" "app_builder_sg" {
  name        = "app-builder-sg"
  description = "App Builder Security Group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
  # Add more ingress rules as needed
}




resource "aws_instance" "builder-app" {
    ami = "ami-0e54eba7c51c234f6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.app_builder_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo -i
              #cd /root
              ###Instalar o docker
              yum update
              yum search docker
              yum info docker
              yum install docker  -y
              yum install git -y
              systemctl start docker.service
              git clone https://github.com/rodrigo210686/simple-app.git /tmp/simple-app
              cd /tmp/simple-app
              sudo chmod +x /tmp/simple-app/build.sh
              sudo /tmp/simple-app/build.sh
              ###

              EOF
  iam_instance_profile = aws_iam_role.ssm_role2.name
  tags = {
     Name = "builder-app"
     type = "ec2"
  }
}
