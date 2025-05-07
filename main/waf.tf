module "waf" {
  source  = "terraform-aws-modules/waf/aws"
  version = "~> 2.0"

  name = "smri-asnv2-waf"

  # WAF configuration
  managed_rule_group = {
    AWSManagedRulesCommonRuleSet = {
      priority = 10
      override_action = {
        type = "COUNT"
      }
    }
    AWSManagedRulesKnownBadInputsRuleSet = {
      priority = 20
      override_action = {
        type = "COUNT"
      }
    }
    AWSManagedRulesSQLiRuleSet = {
      priority = 30
      override_action = {
        type = "COUNT"
      }
    }
    AWSManagedRulesLinuxRuleSet = {
      priority = 40
      override_action = {
        type = "COUNT"
      }
    }
  }

  # Logging Configuration
  logging_configuration = {
    log_destination_configs = [""]
    redacted_fields = [
      {
        single_query_argument = {
          name = "password"
        }
      },
      {
        uri_path = {}
      }
    ]
  }

  # Scope of WAF
  scope = "CLOUDFRONT"

  # CloudFront distribution ARN
  cloudfront_arn = "arn:aws:cloudfront::111122223333:distribution/EDFDVBD6EXAMPLE"
}

