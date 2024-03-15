#!/usr/bin/env bash
# This is if you can't be bothered to use terraform
# ./create-queue.sh "my-queue-name"


set -eo pipefail
# SO SECURE, but based on the associated docker-file

BASIC_AUTH="admin:admin"
CONTENT_TYPE_HEADER="Content-Type: application/json"
SOLACE_SEMP_MSGVPN="http://localhost:18080/SEMP/v2/config/msgVpns/default"

if [[ "$1" == "" ]]; then
  echo "Chicken mode, needs a queue"
  exit 255
fi

queueName=$1
queueJson=$( jq -n --arg qn "$queueName" \
          '{queueName: $qn, accessType :"non-exclusive", permission:"modify-topic", ingressEnabled :true, egressEnabled :true }' )
subscriptionsUri=$(curl -sf -XPOST -u"$BASIC_AUTH" -H"$CONTENT_TYPE_HEADER" "$SOLACE_SEMP_MSGVPN/queues" -d "$queueJson" | jq -r ".links.subscriptionsUri" )
subscriptionJson=$( jq -n --arg qn "$queueName" '{subscriptionTopic: $qn }' )
curl -sf -XPOST -u"$BASIC_AUTH" -H"$CONTENT_TYPE_HEADER" "$subscriptionsUri" -d "$subscriptionJson"

