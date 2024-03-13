#!/bin/bash
set -x
awslocal sqs create-queue --queue-name "zzlc"
awslocal sqs create-queue --queue-name "zzlc-dlq"
set +x
