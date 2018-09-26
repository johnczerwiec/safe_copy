#-----------------------------------------------------------------
# IAM Roles
#-----------------------------------------------------------------

module iam_role_Web {
  source  = "../../modules/aws/iam_role"
  name    = "Web"
  policy  = "../../../blueprints/aflac-poc/files/iam_policies/basic_iam_policy"
}


