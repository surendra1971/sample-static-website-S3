#Create the S3 bucket

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

#Bucket ownership access 
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#making s3 bucket as public access 

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# making bucket as public
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}


resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
  
}


resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  acl    = "public-read"
  content_type = "text/html"
  
}

resource "aws_s3_object" "picture" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "picture.png"
  source = "picture.png"
  acl    = "public-read"
  
}

