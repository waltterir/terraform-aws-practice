resource "aws_s3_bucket" "waltteri_practise" {
  bucket = "waltteri-tf-test-bucket"

  tags = {
    Name        = "Waltteri bucket"
    Environment = "Dev"
  }
}

# pitää bucketin tiedostojen vanhat versiot tallessa
resource "aws_s3_bucket_versioning" "waltteri_practise" {
  bucket = aws_s3_bucket.waltteri_practise.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "waltteri_practise" {
  bucket = aws_s3_bucket.waltteri_practise.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
