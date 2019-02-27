terraform {
        backend "s3" {
                dynamodb_table = "TerraformStateLock"
                region = "eu-west-1"
        }
}

