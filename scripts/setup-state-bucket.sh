#!/usr/bin/env bash

# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

: "${STATE_BUCKET_NAME:=koenighotze-aws-terraform}"

aws s3 mb "s3://$STATE_BUCKET_NAME" --region eu-central-1
aws s3api put-public-access-block --bucket "$STATE_BUCKET_NAME" --public-access-block-configuration BlockPublicAcls=True,IgnorePublicAcls=True,BlockPublicPolicy=True,RestrictPublicBuckets=True
aws s3api put-bucket-policy --bucket "$STATE_BUCKET_NAME" --policy file://policy.json
aws s3api put-bucket-encryption --bucket "$STATE_BUCKET_NAME" --server-side-encryption-configuration '{
    "Rules": [
        {
            "ApplyServerSideEncryptionByDefault": {
                "SSEAlgorithm": "AES256"
            }
        }
    ]
}'

gh secret set TERRAFORM_STATE_BUCKET -R koenighotze/koenighotze-aws-setup -b "$STATE_BUCKET_NAME"
