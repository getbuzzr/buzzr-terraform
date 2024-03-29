resource "aws_s3_bucket" "default" {

  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "buzzr api"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.default.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "deploycicd",
            "Effect": "Allow",
            "Principal": {
                "AWS": ["arn:aws:iam::824611589741:role/cicd_role"
                        ]
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
          },
          {
            "Sid": "AddCannedAcl",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.read_role_arn}"
            },
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
POLICY
}