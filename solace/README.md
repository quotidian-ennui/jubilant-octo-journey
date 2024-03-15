# README

Start a docker image using docker compose and use SEMP (create-queue.sh) or terraform (telus-agcg/solace provider) to create queues to bootstrap local fun times.

```bash
docker compose up -d
docker-health-check solace-single-node
tofu init
tofu apply --auto-approve
```

> You now have the queues zzlc/app/SampleQ1,zzlc/app/SampleQ2 & zzlc/app/SampleQ3 with bindings from the same topic names to the queue; publish to topic consume from queue.
