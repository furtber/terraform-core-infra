terraform {
        backend "s3" {
                lock_table = "TerraformStateLock"
                ###bucket = DEFINED IN TERRAFORM INIT
                key = "core-infra"
                region = "${AWS_REGION}"
        }
}

