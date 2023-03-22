########################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
# Version: v1.0.0
########################################################################

# Creates IAM user for service account for use in GitLab CI/CD Pipeline to use with Codecommit
resource "aws_iam_role" "r_pipeline_iam_role" {
  name = var.p_pipeline_iam_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRoleWithWebIdentity"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Federated = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub": "repo:${var.p_github_org}/${var.p_github_repo_name}:*"
          }
        }
      }
    ]
  })
  #checkov:skip=CKV_AWS_273:The IAM user is a service account only for GitLab CI/CD Pipeline
  tags = {
    (var.p_tag1_key) = (var.p_tag1_value != "" ? var.p_tag1_value : null)
    (var.p_tag2_key) = (var.p_tag2_value != "" ? var.p_tag2_value : null)
    (var.p_tag3_key) = (var.p_tag3_value != "" ? var.p_tag3_value : null)
    (var.p_tag4_key) = (var.p_tag4_value != "" ? var.p_tag4_value : null)
    (var.p_tag5_key) = (var.p_tag5_value != "" ? var.p_tag5_value : null)
  }
}

# Creates policy to allow IAM service account that enables mirroring from AFT repositories in gitlab to AFT repositories in Codecommit
resource "aws_iam_role_policy" "r_pipeline_iam_role_policy" {
  name = "MinimumGitHubPushMirroringPermissions"
  #checkov:skip=CKV_AWS_40:IAM policy is meant to be an inline policy for service account use only
  role = aws_iam_role.r_pipeline_iam_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "codecommit:GitPull",
          "codecommit:GitPush"
        ]
        Effect = "Allow"
        Resource = [
          "arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:aft-account-request",
          "arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:aft-global-customizations",
          "arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:aft-account-customizations",
          "arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:aft-account-provisioning-customizations"
        ]
      }
    ]
  })
}
