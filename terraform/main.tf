resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_site" {
  bucket = substr("${var.bucket_name}-${random_id.suffix.hex}", 0, 39)
} 