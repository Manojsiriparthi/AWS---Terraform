resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "${var.bucket_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

