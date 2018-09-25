#-------------------------------------------------------
# File defining module outputs to be used in blueprints
# Outputs specified with the followig declaration
# "${module.[module_name].[output_name]}"
# e.g. "${module.iam_role_Web.iam_instance_profile}"
#-------------------------------------------------------

# IAM profile name used with instance resource 

output "iam_instance_profile" {
    value = "${aws_iam_instance_profile.profile.name}"
}

# IAM role used with some service resources e.g. ECS

output "iam_role" {
    value = "${aws_iam_role.role.arn}"
}

