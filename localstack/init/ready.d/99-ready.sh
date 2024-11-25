#!/usr/bin/env bash
# Create a named queue last of all so that the health-check
# works
set -eo pipefail
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_REGION=us-east-1

set -x

awslocal sqs create-queue --queue-name "zz_ready"

set +x
