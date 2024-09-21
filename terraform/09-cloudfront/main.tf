resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    # S3 Origin with OAC
    domain_name = var.bucket_regional_domain_name
    origin_id   = "s3-origin"

    # OAC linked to S3 origin
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

  }


  origin {
    domain_name = var.nlb_dns_name  # Use NLB's DNS name
    origin_id   = "my-nlb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"  # Ensures traffic to NLB is secured
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "my-nlb-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "CloudFront-to-NLB"
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name            = "my-oac"
  description     = "CloudFront Origin Access Control for my S3 bucket"
  origin_access_control_origin_type     = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"  # Use SigV4 for security
}