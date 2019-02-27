variable "workspace_iam_roles" {
  default = {
    staging = "arn:aws:iam::200562504897:role/Jenkins"
    production = "arn:aws:iam::980331777790:role/Jenkins"
  }
}

provider "aws" {
  # No credentials explicitly set here because they come from either the
  # environment or the global credentials file.

  assume_role {
      role_arn = "${var.workspace_iam_roles[terraform.workspace]}"
  }

  region = "eu-west-1"
}

