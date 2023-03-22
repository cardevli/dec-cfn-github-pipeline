########################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
# Version: v1.0.2
########################################################################

# Parameter for name of IAM User to be used for service account
variable "p_pipeline_iam_role" {
  description = "Role name for pipeline IAM role"
  type        = string
  default     = "aft-pipeline-role"
  # Name of users must be unique within the account and must be alphanumeric, including the following specific special characters +=,.@_-
  validation {
    condition     = length(var.p_pipeline_iam_role) >= 1 && length(var.p_pipeline_iam_role) <= 128
    error_message = "IAM role names must be between 1 and 128 characters"
  }
  validation {
    condition     = can(regex("^[0-9A-Za-z+=,.@_-]+$", var.p_pipeline_iam_role))
    error_message = "IAM role names must be alphanumeric including the following specific special characters +=,.@_-"
  }
}

variable "p_github_org" {
  description = "Name of GitHub Org"
  type        = string
  default     = "github-org"
  # Name of users must be unique within the account and must be alphanumeric, including the following specific special characters +=,.@_-
  validation {
    condition     = length(var.p_github_org) >= 1 && length(var.p_github_org) <= 128
    error_message = "GitHub Org Names must be between 1 and 128 characters"
  }
  validation {
    condition     = can(regex("^[0-9A-Za-z+=,.@_-]+$", var.p_github_org))
    error_message = "GitHub Org names must be alphanumeric including the following specific special characters +=,.@_-"
  }
}

variable "p_github_repo_name" {
  description = "Name of GitHub Org"
  type        = string
  default     = "github-org"
  # Name of users must be unique within the account and must be alphanumeric, including the following specific special characters +=,.@_-
  validation {
    condition     = length(var.p_github_repo_name) >= 1 && length(var.p_github_repo_name) <= 128
    error_message = "GitHub Repo Names must be between 1 and 128 characters"
  }
  validation {
    condition     = can(regex("^[0-9A-Za-z+=,.@_-]+$", var.p_github_repo_name))
    error_message = "GitHub Repo names must be alphanumeric including the following specific special characters +=,.@_-"
  }
}

# optional parameters for tags
# parameter for Tag 1 Key
variable "p_tag1_key" {
  description = "Key for user defined Tag 1"
  type        = string
  # Must match the allowable values for a Tag Key. This must NOT begin with "aws:" and can only contain alphanumeric characters or specific special characters _.:/=+-@ up to 128 characters
  validation {
    condition     = length(var.p_tag1_key) <= 128
    error_message = "Tag Key is too long. Must be less than 128 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag1_key))
    error_message = "Value NOT begin with \"aws:\" and can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 1 Value
variable "p_tag1_value" {
  description = "Value for user defined Tag 1"
  type        = string
  # Must match the allowable values for a Tag Value. This must NOT begin with "aws:" and can only contain alphanumeric characters or special characters _.:/=+-@ up to 256 characters
  validation {
    condition     = length(var.p_tag1_value) <= 256
    error_message = "Tag Value is too long. Must be less than 256 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag1_value))
    error_message = "Value can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 2 Key
variable "p_tag2_key" {
  description = "Key for user defined Tag 2"
  type        = string
  # Must match the allowable values for a Tag Key. This must NOT begin with "aws:" and can only contain alphanumeric characters or specific special characters _.:/=+-@ up to 128 characters
  validation {
    condition     = length(var.p_tag2_key) <= 128
    error_message = "Tag Key is too long. Must be less than 128 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag2_key))
    error_message = "Value NOT begin with \"aws:\" and can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 2 Value
variable "p_tag2_value" {
  description = "Value for user defined Tag 2"
  type        = string
  # Must match the allowable values for a Tag Value. This must NOT begin with "aws:" and can only contain alphanumeric characters or special characters _.:/=+-@ up to 256 characters
  validation {
    condition     = length(var.p_tag2_value) <= 256
    error_message = "Tag Value is too long. Must be less than 256 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag2_value))
    error_message = "Value can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 3 Key
variable "p_tag3_key" {
  description = "Key for user defined Tag 3"
  type        = string
  # Must match the allowable values for a Tag Key. This must NOT begin with "aws:" and can only contain alphanumeric characters or specific special characters _.:/=+-@ up to 128 characters
  validation {
    condition     = length(var.p_tag3_key) <= 128
    error_message = "Tag Key is too long. Must be less than 128 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag3_key))
    error_message = "Value NOT begin with \"aws:\" and can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 3 Value
variable "p_tag3_value" {
  description = "Value for user defined Tag 3"
  type        = string
  # Must match the allowable values for a Tag Value. This must NOT begin with "aws:" and can only contain alphanumeric characters or special characters _.:/=+-@ up to 256 characters
  validation {
    condition     = length(var.p_tag3_value) <= 256
    error_message = "Tag Value is too long. Must be less than 256 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag3_value))
    error_message = "Value can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# parameter for Tag 4 Key
variable "p_tag4_key" {
  description = "Key for user defined Tag 4"
  type        = string
  # Must match the allowable values for a Tag Key. This must NOT begin with "aws:" and can only contain alphanumeric characters or specific special characters _.:/=+-@ up to 128 characters
  validation {
    condition     = length(var.p_tag4_key) <= 128
    error_message = "Tag Key is too long. Must be less than 128 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag4_key))
    error_message = "Value NOT begin with \"aws:\" and can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# paremeter for Tag 4 Value
variable "p_tag4_value" {
  description = "Value for user defined Tag 4"
  type        = string
  # Must match the allowable values for a Tag Value. This must NOT begin with "aws:" and can only contain alphanumeric characters or special characters _.:/=+-@ up to 256 characters
  validation {
    condition     = length(var.p_tag4_value) <= 256
    error_message = "Tag Value is too long. Must be less than 256 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag4_value))
    error_message = "Value can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# paremeter for Tag 5 Key
variable "p_tag5_key" {
  description = "Key for user defined Tag 5"
  type        = string
  # Must match the allowable values for a Tag Key. This must NOT begin with "aws:" and can only contain alphanumeric characters or specific special characters _.:/=+-@ up to 128 characters
  validation {
    condition     = length(var.p_tag5_key) <= 128
    error_message = "Tag Key is too long. Must be less than 128 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag5_key))
    error_message = "Value NOT begin with \"aws:\" and can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}

# paremeter for Tag 5 Value
variable "p_tag5_value" {
  description = "Value for user defined Tag 5"
  type        = string
  # Must match the allowable values for a Tag Value. This must NOT begin with "aws:" and can only contain alphanumeric characters or special characters _.:/=+-@ up to 256 characters
  validation {
    condition     = length(var.p_tag5_value) <= 256
    error_message = "Tag Value is too long. Must be less than 256 characters."
  }
  validation {
    condition     = can(regex("^$|^[0-9A-Za-z+=,.@_-]+$", var.p_tag5_value))
    error_message = "Value can only contain alphanumeric characters or special characters _.:/=+-@"
  }
}
