resource "aws_ecr_repository" "buzzr_prod_api" {
  name                 = "buzzr_prod_api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "buzzr_prod_api_policy" {
  repository = aws_ecr_repository.buzzr_prod_api.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 8
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}