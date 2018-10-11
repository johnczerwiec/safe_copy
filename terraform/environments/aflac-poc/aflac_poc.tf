module environment {
  source = "../../blueprints/aflac-poc"

  env                = "aflac-poc"                          # e.g. prod
  vpc_name           = "AFLACPOCVPC"                        # e.g. Prod VPC
  cidr               = "10.42.36.0/25"                      # e.g. 10.72.192.0.21
  region             = "us-east-2"                          # e.g. eu-west-1
  ci_prefix          = "afl40"                              # e.g. ccm43
  ci_suffix          = "poc"                                # e.g. ccm43
  monitoring_tag     = "not-required"                       # e.g. datadog|not-required
  backup_tag         = "no-backup"                          # e.g. ccm_poc_daily - make sure to use _ not -
  key_name           = "aflac-poc"                          # e.g. ccm-poc 
  s3_bucket          = "aflac-poc-ens"                      # e.g. ccm-poc
  cidr_ensmgmt       = "10.96.0.0/24"                       # e.g. 10.72.192.0/21
  peer_owner_id      = "695622663364"                       #e.g. Peer account number
  peer_vpc_id	     = "vpc-85e11ce3"                       #e.g. vpc-XXXXXXXX
  peer_region	     = "us-east-1"                          #e.g. vpc-XXXXXXXX

}

 data "terraform_remote_state" "selfvpc" {
  backend = "s3"
  config {
    bucket = "aflac-poc-tfstate"
    key = "aflac-poc.terraform.tfstate"
    region  = "us-east-2"
  }
 }

 terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "aflac-poc-tfstate"
    key     = "aflac-poc.terraform.tfstate"
    encrypt = true
  }
 }