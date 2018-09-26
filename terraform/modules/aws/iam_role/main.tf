#--------------------------------------------------------------------
# Ensono IAM role module
#
# Usage: 
#
# module iam_role_Web {
#  source             = "../../modules/aws/iam_role"
#  name               = "Web"
#  policy             = "../../modulename/files/iam_policies/basic_iam_policy"
# }
#
# Notes:
# 
# basic_iam_policy is a sample policy that allows access to s3 and ec2:describe
# You may want to create a policy doc for each role
# service is optional - typically ec2.amazonaws.com or ecs.amazonaws.com
#--------------------------------------------------------------------

resource "aws_iam_role" "Web" {
  name = "${var.name}"
  path = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "${var.service}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "profile" {
    name = "${var.name}"
    role = "${aws_iam_role.Web.name}"
}

resource "aws_iam_policy" "policy" {
    name = "${var.name}"
    path = "/"
    description = "${var.name} IAM policy"
    policy = "${file("${var.policy}")}"
}

resource "aws_iam_policy_attachment" "attachment" {
    name = "${var.name}"
    roles = [ "${var.name}" ]
    policy_arn = "${aws_iam_policy.policy.arn}"
}

