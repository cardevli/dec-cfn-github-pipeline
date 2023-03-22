# GitLab backend
terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "dec-platform-terraform-state"
    key            = "template"                    # Change this
    dynamodb_table = "dec-platform-template-table" # Change this
    encrypt        = "true"
    role_arn       = "arn:aws:iam::<mgmt-acct-id>:role/svc_terraform_role" # Change this to the dec mgmt role
  }
}
