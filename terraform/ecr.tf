data "aws_ecr_repository" "bluengo_ecr" {
  name = "ecr-jgl-deploy"
}

output "ecr_repository_url" {
  value = data.aws_ecr_repository.bluengo_ecr.repository_url
}




/*
resource "aws_ecr_repository" "bluengo_ecr" {
  name                 = "ecr-jgl-deploy"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
*/