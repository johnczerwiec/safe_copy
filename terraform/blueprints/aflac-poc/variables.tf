#------------------------------------------------
# Variables
#------------------------------------------------

variable "env"            { default=""   description="e.g. prod" }
variable "vpc_name"       { default=""   description="e.g. Prod VPC" }
variable "cidr"           { default=""   description="e.g. 10.72.176.0/21" }
variable "region"         { default=""   description="e.g. eu-west-1" }
variable "ci_prefix"      { default=""   description="e.g. ccm43" }
variable "monitoring_tag" { default=""   description="e.g. datadog|not-required" }
variable "backup_tag"     { default=""   description="e.g. ccm_poc_daily" }
variable "s3_bucket"      { default=""   description="e.g. ccm-poc" }
variable "key_name"       { default=""   description="e.g. ccm-poc" }

#------------------------------------------------
# Autoscaling
#------------------------------------------------

variable "Web_autoscale_min_size"    { default=""   description="e.g. 1" }
variable "Web_autoscale_max_size"    { default=""   description="e.g. 3" }
variable "Web_autoscale_image_id"    { default=""   description="e.g. ami-4db9df3e" } 

