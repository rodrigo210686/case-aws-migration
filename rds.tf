# Create RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "rds-subnet-group"
  }
}

# Create RDS MySQL Instance (Free Tier)
resource "aws_db_instance" "rds_instance" {
  identifier           = "rds-mysql-instance"
  allocated_storage    = 20                          # Free-tier allows up to 20 GB
  instance_class       = "db.t3.micro"               # Free-tier eligible instance
  engine               = "mysql"
  engine_version       = "8.0"
  username             = "admin"
  password             = "TuusiWsnfn##4$"            # Change to your password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.app_builder_sg.id]
  publicly_accessible  = false                       # Ensures it's in the private subnet
  skip_final_snapshot  = true                        # No snapshot during destroy
  multi_az             = false                       # Free tier does not support multi-AZ

  tags = {
    Name = "rds-mysql-instance"
  }
}

output "rds_instance_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_address" {
  value =   aws_db_instance.rds_instance.address
}
