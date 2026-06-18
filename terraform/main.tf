resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_site" {
  bucket = substr("${var.bucket_name}-${random_id.suffix.hex}", 0, 39)
} 

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "static_site_access" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false 
  ignore_public_acls      = false 
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2026-06-18"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

  depends_on = [ aws_s3_bucket_public_access_block.static_site_access ]
}