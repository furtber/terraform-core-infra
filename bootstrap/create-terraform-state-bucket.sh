#!/bin/bash
#
# This script is used to set up resources for terraform in new AWS account.
# S3 bucket for storing state and DynamoDB table for locking are created.
#

if [[ -z "$AWS_DEFAULT_PROFILE" ]]; then
  echo "Error: Please set AWS_DEFAULT_PROFILE variable to the centralized account where Jenkins is located."
  exit 1
fi

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)

S3_BUCKET="terraform-tfstate-$AWS_ACCOUNT_ID"

echo "Creating S3 bucket: $S3_BUCKET"
aws s3api create-bucket --bucket $S3_BUCKET --create-bucket-configuration LocationConstraint="eu-west-1"

echo "Waiting until the bucket is ready..."
aws s3api wait bucket-exists --bucket $S3_BUCKET

echo "Enabling versioning for the bucket"
aws s3api put-bucket-versioning --bucket $S3_BUCKET --versioning-configuration Status=Enabled

echo "Putting tags to bucket"
aws s3api put-bucket-tagging --bucket $S3_BUCKET --tagging "TagSet=[{Key=environment,Value=$ENVIRONMENT},{Key=cost_center,Value=123},{Key=service,Value=foo},{Key=business_unit,Value=foo},{Key=role,Value=Terraform}]"

echo "Put S3 bucket policy"
TIMESTAMP=$(date +%Y%m%d%H%M)
POLICY=$(cat<<EOF
{
    "Version": "2012-10-17",
    "Id": "s3-enforce-encryption-$TIMESTAMP",
    "Statement": [{
        "Sid": "DenyIncorrectEncryptionHeader-$TIMESTAMP",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::$S3_BUCKET/*",
        "Condition": {
            "StringNotEquals": {
                "s3:x-amz-server-side-encryption": "AES256"
            }
        }
    }, {
        "Sid": "DenyUnEncryptedObjectUploads-$TIMESTAMP",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::$S3_BUCKET/*",
        "Condition": {
            "Null": {
                "s3:x-amz-server-side-encryption": "true"
            }
        }
    }]
}
EOF
)
aws s3api put-bucket-policy --bucket $S3_BUCKET --policy "$POLICY"

echo "Creating prefix: workspace"
aws s3api put-object --bucket $S3_BUCKET --key workspace/ --server-side-encryption AES256

