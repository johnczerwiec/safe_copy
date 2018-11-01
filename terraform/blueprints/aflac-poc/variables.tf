#------------------------------------------------
# Variables
#------------------------------------------------

variable "env"            { default="aflac-poc"   		description="e.g. prod" }
variable "vpc_name"       { default="AFLACPOCVPC"   	description="e.g. Prod VPC" }
variable "cidr"           { default="10.42.36.0/25"   	description="e.g. 10.72.176.0/21" }
variable "region"         { default="us-east-2"   		description="e.g. eu-west-1" }
variable "ci_prefix"      { default="afl40"   			description="e.g. ccm43" }
variable "ci_suffix"      { default="poc"   			description="e.g. ccm43" }
variable "monitoring_tag" { default="not-required"   	description="e.g. datadog|not-required" }
variable "backup_tag"     { default="not-backup"   		description="e.g. ccm_poc_daily" }
variable "s3_bucket"      { default="aflac-poc-ens"   	description="e.g. ccm-poc" }
variable "key_name"       { default="aflac-poc"   		description="e.g. ccm-poc" }
variable "cidr_ensmgmt"   { default="" 					description="e.g. 10.72.192.0/21" }
variable "peer_owner_id"  { default="" 					description="e.g. Peer account number" }
variable "peer_vpc_id"    { default="" 					description="e.g. vpc-XXXXXXXX" }
variable "peer_region"    { default="" 					description="e.g. us-east-1" }
variable "private_subnet_list" {type="list"}				#list of private subnets

variable "gic_type"       {}
variable "gic_type_ami"   {}
variable "gic_count"      {}

variable "inst_type"       {}
variable "inst_ami"   {}
variable "inst_count"      {}

#------------------------------------------------
# Autoscaling
#------------------------------------------------

#variable "Web_autoscale_min_size"    { default=""   description="e.g. 1" }
#variable "Web_autoscale_max_size"    { default=""   description="e.g. 3" }
#variable "Web_autoscale_image_id"    { default=""   description="e.g. ami-4db9df3e" } 


#------------------------------------------------
# Client Solution Specific Variables
#------------------------------------------------
variable "ebs_opt_web" { default="True"    description="whether or not EBS optimisation is enabled on supported instances" }

