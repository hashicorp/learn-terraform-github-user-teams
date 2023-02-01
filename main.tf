# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "github" {}

# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}
