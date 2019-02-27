#!/bin/bash
#
# Create DynamoDB for Terraform state file locking to prevent
# that being corrupted by simultaneous terraform applys

if [[ -z "$AWS_DEFAULT_PROFILE" ]]; then
  echo "Error: Please set AWS_DEFAULT_PROFILE variable to the centralized account where Jenkins is located."
  exit 1
fi

aws dynamodb create-table --table-name TerraformStateLock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

