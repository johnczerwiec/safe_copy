module environment {
  source = "../../terraform/blueprints/aflac-poc"

  env                = "poc"                                # e.g. prod
  vpc_name           = "WDSPOCVPC"                          # e.g. Prod VPC
  cidr               = "10.42.36.0/27"                      # e.g. 10.72.192.0.21
  region             = "us-east-2"                          # e.g. eu-west-1
  ci_prefix          = "afl40"                              # e.g. ccm43
  monitoring_tag     = "not-required"                       # e.g. datadog|not-required
  backup_tag         = "no-backup"                          # e.g. ccm_poc_daily - make sure to use _ not -
  key_name           = "aflac-poc"                          # e.g. ccm-poc 
  s3_bucket          = "aflac-poc"                          # e.g. ccm-poc

}