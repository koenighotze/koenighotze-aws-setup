#!/usr/bin/env bash

# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

: "${AWS_DEFAULT_REGION?AWS_DEFAULT_REGION missing}"
: "${AWS_ACCESS_KEY_ID?AWS_ACCESS_KEY_ID}"
: "${AWS_SECRET_ACCESS_KEY?AWS_SECRET_ACCESS_KEY}"

gh secret set AWS_DEFAULT_REGION -R koenighotze/koenighotze-aws-setup -b "$AWS_DEFAULT_REGION"
gh secret set AWS_ACCESS_KEY_ID -R koenighotze/koenighotze-aws-setup -b "$AWS_ACCESS_KEY_ID"
gh secret set AWS_SECRET_ACCESS_KEY -R koenighotze/koenighotze-aws-setup -b "$AWS_SECRET_ACCESS_KEY"
