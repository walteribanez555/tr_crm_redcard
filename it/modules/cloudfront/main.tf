
locals{
    s3_origin_id = "myS3Originwribanez"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.website_domain
    origin_id = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront Distribution"
  default_cache_behavior {
    target_origin_id   = local.s3_origin_id
    viewer_protocol_policy = "allow-all"
    allowed_methods     = ["GET", "HEAD", "OPTIONS"]
    cached_methods      = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
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
    Name = "crm_redcard"
  }
  
}

