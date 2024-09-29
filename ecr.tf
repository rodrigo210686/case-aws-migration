resource "aws_ecr_repository" "survey_app_repo" {
  name                 = "survey-app-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.survey_app_repo.repository_url
}

