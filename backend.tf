 terraform {
  backend "s3" {
   bucket         = "my-unique-bucket-name-siriparthi-2024"
   key            = "terraform.tfstate"
   region         = "us-east-1"
   dynamodb_table = "my-dynamodb-table"
   encrypt        = true
  }
}

