### Create iam role intance profile
resource "aws_iam_role" "ssm_role2" {
  name = "ssm-instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm-instance"

  role = aws_iam_role.ssm_role2.name
}
### Atacch existent ssm core policie
resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore22" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role2.name
}

resource "aws_iam_role_policy_attachment" "s3permission" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" 
  role       = aws_iam_role.ssm_role2.name
}

resource "aws_iam_role_policy_attachment" "ecrpolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.ssm_role2.name
}

