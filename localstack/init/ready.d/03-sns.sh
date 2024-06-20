#!/bin/bash
# Note the arn are all derivable other than the subscription arn, since this is
# localstack
set -x
AWS_REG_AC="us-east-1:000000000000"
ARN="arn:aws"
TOPIC="zzlc-sns"
TOPIC_ARN="$ARN:sns:$AWS_REG_AC:$TOPIC"
QUEUE="zzlc"
QUEUE_ARN="$ARN:sqs:$AWS_REG_AC:$QUEUE"

awslocal sns create-topic --name "$TOPIC"
awslocal sns subscribe --topic-arn "$TOPIC_ARN" --protocol sqs --notification-endpoint "$QUEUE_ARN"
awslocal sns publish --topic-arn "$TOPIC_ARN" --message "hello"
awslocal sqs receive-message --queue-url "$QUEUE"
awslocal sqs purge-queue --queue-url "$QUEUE"
set +x
