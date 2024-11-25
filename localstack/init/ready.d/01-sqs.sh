#!/bin/bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_REGION=us-east-1

set -x
awslocal sqs create-queue --queue-name "zzlc"
awslocal sqs create-queue --queue-name "zzlc-dlq"
set +x
