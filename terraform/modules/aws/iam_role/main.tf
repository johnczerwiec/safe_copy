#--------------------------------------------------------------------
# Ensono IAM role module
#
# Usage: 

 module iam_role_Web {
  source             = "../../modules/aws/iam_role"
  name               = "Web"
  policy             = "../../modulename/files/iam_policies/basic_iam_policy"
 }

