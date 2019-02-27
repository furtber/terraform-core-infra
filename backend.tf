terraform {
    backend "s3" {
        bucket = "terraform-tfstate-825265825471"
        workspace_key_prefix = "workspace"
        key = "core-infra.tfstate"
        region = "eu-west-1"
        dynamodb_table = "TerraformStateLock"
        encrypt = "1"
        acl = "private"
    }
}

