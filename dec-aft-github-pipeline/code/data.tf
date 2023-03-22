########################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
# Version: v1.0.0
########################################################################

# Retrieves the current region
data "aws_region" "current" {}
# Retrieves the current AWS partition
data "aws_partition" "current" {}
# Retrieves effective Account ID
data "aws_caller_identity" "current" {}
