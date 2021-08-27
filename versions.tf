terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.13.0"
    }
  }

  required_version = "~> 1.0.5"
}