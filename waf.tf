# Create WAFv2 Web ACL
resource "aws_wafv2_web_acl" "app_waf_acl" {
  name        = "app-waf-acl"
  description = "WAF ACL for ALB"
  scope       = "REGIONAL"  # Use "REGIONAL" for ALBs, "CLOUDFRONT" for CloudFront
  default_action {
    allow {}
  }
  
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "app-waf-acl"
    sampled_requests_enabled   = true
  }

  # Basic WAF rules, you can add more
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesCommonRuleSet"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

# Associate WAF ACL with ALB
resource "aws_wafv2_web_acl_association" "app_waf_assoc" {
  resource_arn = aws_lb.app_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.app_waf_acl.arn
}
