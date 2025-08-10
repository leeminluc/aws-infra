terraform {
  backend "s3" {
    bucket         = "leeminluc-terraform-state-bucket"
    key            = "flux-k3s/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "leeminluc-terraform-state-bucket"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}