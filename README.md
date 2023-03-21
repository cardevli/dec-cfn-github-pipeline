# Multiple AWS Organizations GitHub Deployment Pipeline

#### Module version: 2.0.0

## Solution Overview

This solution deploys an AWS Identity and Access Management (IAM) service account for use by a GitHub Continuous Integration/Continuous Deployment (CI/CD) pipeline to upload Customization for Control Tower (CfCT) config files into a Multiple AWS Organizations environment.

This pattern can be used to test a Control Tower customization in a development Control Tower environment before promoting those changes to a production Control Tower environment.

The IAM role for the service account is granted permissions to upload and encrypt the config file through an inline policy.

The solution is deployed via a CloudFormation Stack. A sample GitHub CI/CD pipeline template is also included.

## Solution Details

**Main Technology** - AWS Identity and Access Management

**Additional Technologies**

- AWS CloudFormation

**Environment** - Production

## Architecture Overview

There are multiple ways to setup the CfCT multi-org pipeline depending on the choice of source control management (SCM) and CI/CD tools. This solution covers setup using GitHub CI/CD Pipelines.

The `pipeline-iam-role.yaml` CloudFormation Stack creates the below resources in the Deployment Region:

1. An IAM Role with inline read/write permissions for Amazon Simple Storage Service (S3) and AWS Key Management Service (KMS) encryption for the `pCfCTConfigBucket` parameter. It also has permissions to allow the specified GitHub repository to assume this role through AWS Security Token Service (STS). This is required for the service account to upload and encrypt CFCT config files to the bucket used by the CI/CD pipeline.

The `sample-github-ci.yaml` GitHub CI/CD pipeline template file will upload your CfCT configuration files to either your development or production Control Tower environment, depending on the repository that received a new commit.

### Services Utilized

- AWS Identity and Access Management
- Amazon Simple Storage Service (S3)
- AWS Key Management Service (KMS)
- AWS Security Token Service (STS)
- AWS CloudFormation

### Target Technology Stack

**IaC Code** - AWS CloudFormation

**Automation Code** - None

**Configuration File Code** - YAML

### Architecture Diagram

![Architecture Diagram](./documentation/cfct-multi-org-gitlab.jpeg)
<div align="center">Multi-org CfCT deployment pipeline using GitHub</div>

### Automation Code Overview

No automation code

### Automation and Scale

This pattern could be applied to any other multi-organization setup that requires CfCT deployments to a separate Control Tower environment from a CI/CD pipeline.

## Best Practices

- This solution should be deployed in the Management account of **two (2) separate Control Tower environments**.
- The management accounts should have the prerequisite capabilites setup prior to solution deployment (see [Prerequisites and Requirements](#prerequisites-and-requirements) section).

### Anti-Patterns

- This solution should not be deployed to two Control Tower environments that have different Organizational Unit (OU) structures.

### Prerequisites and Requirements

- **Two AWS Management accounts**

- **AWS Control Tower deployed in each Management account with the same high-level OU structure**

- **Customizations for Control Tower deployed in each Control Tower environment**

- **A GitHub project to be used as a code repository to store the customization modules.**

### Limitations

- This pattern provides pipeline for deploying customizations in multi-organization environment using GitHub CI/CD. Additional work will be required if you are using other CI/CD tools.
- Only 5 user-defined tags can be applied to the resources deployed by this solution
- Each user-defined tag "Key" must be unique
- Each user-defined tag "Value" must be a minimum legnth of 1 character.

## Deployment Summary

To use the GitHub pipeline for multi-org CfCT deployment, follow the below steps:

1. **Ensure Prerequsites are met** (see **[Prerequisites and Requirements](#prerequisites-and-requirements) section**)
   
2. **Create OIDC Provider in Development Control Tower management account**
    - This OIDC Provider will allow the specified GitHub repository to assume AWS credentials through the use of an IAM role, which is created using the CloudFormation template located in `code/pipeline-iam-role.yaml`. This IAM role depends on the creation of an OIDC Provider in order to assume a role through STS. 
    - Navigate to the AWS Management Console in the Development Control Tower management account and choose the IAM service. 
    - In the left menu pane, under 'Access Management', select 'Identity providers'.
    - Choose 'Add provider'
    - For 'Provider type': select 'OpenID Connect'
    - For 'Provider URL': use `https://token.actions.githubusercontent.com`
    - For 'Audience': use `sts.amazonaws.com`
    - Click 'Add provider'
    - Once the provider has been created, copy the provider ARN and paste it into the 'Default' field for `pOIDCProviderArn` in the CloudFormation template for the IAM role located in `code/pipeline-iam-role.yaml`

3. **Create IAM role in Development Control Tower management account**
    - This IAM role will serve as service account for GitHub pipeline to upload the CfCT customization config ZIP file. Use CloudFormation template located in `code/pipeline-iam-role.yaml` to create this user.
    - As part of the CloudFormation deployment, input the account ID of the Control Tower management account as the `pCfCTAccountId` parameter, the S3 bucket name of the CfCT config bucket as the `pCfCTConfigBucket`, a name for the IAM role (unique within the account) as the `pGitHubCredentialsIAMRole` parameter, the name of the GitHub Organization for the GitHub project as the `pGitHubOrg` parameter, the name of the GitHub repository for the GitHub project as the `pGitHubRepoName` parameter, and the OIDC Provider ARN which was copied from the previous step as the `pOIDCProviderArn` parameter. 
    - (Optional) Input values for `pUserDefinedTagKeyx` and `pUserDefinedTagValuex` during CloudFormation template deployment.

        Notes :
        - Tags are only created if both `pUserDefinedTagKeyx` and `pUserDefinedTagValuex` are specified.
        - Tag Values (`pUserDefinedTagValue1` through `pUserDefinedValue5`) must be equal to a string with a minimum length of 1 character.
        - Tag Keys (`pUserDefinedTagKey1` through `pUserDefinedTagKey5`) must be unique.

4. **After the IAM role is created, update the KMS key policy**
    - Update the Key policy for KMS key used for encrypting customization ZIP in CfCT configuration S3 bucket to allow the IAM role you created in step 3, permissions to encrypt. See below for reference policy.

    ![kms policy example](./documentation/kms-policy-example.png)

5. **Repeat the steps 2-4 for your Main Control Tower environment.**

6. **(Optional) Deploy the sample GitHub CI/CD pipeline file.**
    1. Download the `sample-github-ci.yaml` file and open in a text editor.
    2. Edit the `env` section to match your AWS environment and ensure that the file paths that are called out match your GitHub repo file paths.
    3. Push the file to the `.github/workflows` folder. The GitHub CI/CD pipeline should now be enabled.

## Troubleshooting

- **Tags specified in the pUserDefinedTagKeyx and pUserDefinedTagValuex parameters are not being created** - Validate that `pUserDefinedTagKeyx`, and `pUserDefinedTagValuex` are non-empty strings.

- **Resource tag creation fails** - Validate that the value specified for each instance of `pUserDefinedTagKeyx` is unique.

## Related Resources

### APG Patterns, Guides, Strategies

**APG Pattern Link - DEC LZ: Foundations - Multi-Org Control Tower customizations deployment pipeline** - <https://apg-library.amazonaws.com/content/c2921621-f78d-4622-aff3-1e4aa6340917>

### Related Documentation and Tooling

**Using CfCT across multiple landing zones AWS Blog post** - <https://aws.amazon.com/blogs/mt/developing-versioning-testing-and-deploying-landing-zone-changes-using-cfct-across-multiple-landing-zones/>

**AWS IAM Roles** - <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html>

**AWS Resource Tags** - <https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html>

## Additional Details

### Parameters

The below list all parameters that the template will accept.

**Control Tower Management Account ID** - `pCfCTAccountId` parameter should be the account ID of the Control Tower Management account where the IAM role should be created and the customizations should be deployed in.

**CfCT Config Bucket** - `pCfCTConfigBucket` parameter should point to the S3 bucket where Customizations for Control Tower config files are placed.

**IAM Role name** `pGitHubCredentialsIAMRole` a name for the IAM role for the service account should be entered for this parameter. The name must be unique within the account.

**GitHub Organization** - `pGitHubOrg` parameter should be the name of the GitHub Organization that the GitHub project is using

**GitHub Repository name** - `pGitHubRepoName` parameter should be the name of the GitHub repository where the customizations and pipeline code are located

**OIDC Provider ARN** `pOIDCProviderArn` parameter should have the value of the ARN of the OIDC Provider that was created in Step 2 of the Deployment Summary

**Tagging** - the `pUserDefinedTagKeyx` and `pUserDefinedTagValuex` parameters are used to specify Key/Value pairs that will be used to tag the resources created in the solution.

- Each specified `pUserDefinedTagKeyx` must be unique.
- Each specified `pUserDefinedtagValuex` must be a string with a minimum length of one character.
- For a given pair of paraameters (e.g. `pUserDefinedTagKey1` & `pUserDefinedTagValue1`) - the a tag will only be created if both parameters are passed into the template.

| Parameter Name        | Description                                | Required |
| --------------------- | ------------------------------------------ | -------- |
| pCfCTAccountId        | Account ID of CT management account bucket | Yes      |
| pCfCTConfigBucket     | Name of CfCT config bucket                 | Yes      |
| pGitHubCredentialsIAMRole | Name for IAM role                      | Yes      |
| pGitHubOrg            | Name of GitHub Organization                | Yes      |
| pGitHubRepoName       | Name of GitHub repository                  | Yes      |
| pOIDCProviderArn      | ARN of OIDC provider                       | Yes      |
| pUserDefinedTagKey1   | Key for first resource tag                 | No       |
| pUserDefinedTagValue1 | Value for first resource tag               | No       |
| pUserDefinedTagKey2   | Key for second resource tag                | No       |
| pUserDefinedTagValue2 | Value for second resource tag              | No       |
| pUserDefinedTagKey3   | Key for third resource tag                 | No       |
| pUserDefinedTagValue3 | Value for third resource tag               | No       |
| pUserDefinedTagKey4   | Key for fourth resource tag                | No       |
| pUserDefinedTagValue4 | Value for fourth resource tag              | No       |
| pUserDefinedTagKey5   | Key for fifth resource tag                 | No       |
| pUserDefinedTagValue5 | Value for fifth resource tag               | No       |

### Suppressed Checkov and cfn_nag rules

| Resource Logical Id |                                     Finding Description                                     | Suppressed CHK_OV | Suppressed CFN_NAG |                                 Suppression Reason                                  |
| :-----------------: | :-----------------------------------------------------------------------------------------: | :---------------: | :----------------: | :---------------------------------------------------------------------------------: |
|  rPipelineIAMUser   | IAM user should not have any inline policies.  Should be centralized Policy object on group |        N/A        |        F10         |         This is an IAM user for service account so using an inline policy.          |
|  rPipelineIAMUser   |                               User is not assigned to a group                               |        N/A        |       F2000        | This is an IAM user for service account so doesn't need to be part of an IAM Group. |
|  rPipelineIAMUser   |             Ensure IAM policies does not allow write access without constraints             |    CKV_AWS_111    |        N/A         |       Write access is constrained by Resource section to `pCfCTConfigBucket`        |

### Removal and Rollback

This solution can be rolled back by deleting the stack in CloudFormation which will remove the created IAM role.

## License

Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.  
SPDX-License-Identifier: MIT-0
