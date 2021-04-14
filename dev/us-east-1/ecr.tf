resource "aws_ecr_repository" "buzzr_dev_api" {
  name                 = "buzzr_dev_api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "buzzr_dev_api_policy" {
  repository = aws_ecr_repository.buzzr_dev_api.name

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


resource "aws_ecr_repository" "buzzr_dev_admin" {
  name                 = "buzzr_dev_admin"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "buzzr_dev_admin_policy" {
  repository = aws_ecr_repository.buzzr_dev_admin.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 8 images",
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
