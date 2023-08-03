#Create the S3 bucket

resource "aws_s3_bucket" "example" {
  bucket = var.bucketname
}