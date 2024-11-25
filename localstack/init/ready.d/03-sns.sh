#!/bin/bash
# Note the arn are all derivable other than the subscription arn, since this is
# localstack
set -eo pipefail
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_REGION=us-east-1

set -x

AWS_REG_AC="us-east-1:000000000000"
ARN="arn:aws"
QUEUES='inbound outbound'

make_sns() {
  for q in $QUEUES;
  do
    topic="$q-sns"
    topicARN="$ARN:sns:$AWS_REG_AC:$topic"
    queueARN="$ARN:sqs:$AWS_REG_AC:$q"
    awslocal sqs create-queue --queue-name "$q"
    awslocal sns create-topic --name "$topic"
    awslocal sns subscribe --topic-arn "$topicARN" --protocol sqs --notification-endpoint "$queueARN"
    awslocal sns publish --topic-arn "$topicARN" --message "hello"
    awslocal sqs receive-message --queue-url "$q"
    awslocal sqs purge-queue --queue-url "$q"
  done

}

make_sns
set +x
