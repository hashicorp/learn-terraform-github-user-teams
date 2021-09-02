provider "github" {}

# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}
