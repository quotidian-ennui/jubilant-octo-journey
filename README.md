# jubilant-octo-journey

Some things I run locally via docker-compose.

| dir | purpose |
|----|----|
|generatedata| Generate random names & addresses |
|localstack|Run localstack well, locally, with some bootstrapping|
|md2pdf| use `dillinger` to convert markdown to PDF|
|plantuml| Run a local plantuml server because we do markdown |
|pulsar| Apache Pulsar |
|rabbitmq| RabbitMQ with additional JMS bindings|
|solace| Solace Event Broker with some TF shenanigans|
|superset| Apache superset |

# Quickstart (won't be quick)

- You probably want `direnv` in play because of the `.envrc` files.
- If you're authenticated to github via ghcli then `gh auth token` shows you your personal access token. Dangerous sure, but if someone already has access to your terminal then you have a different set of problems.
- There's reference to `image-tags`, which is basically this (make of it what you will); put it in a script in your path as `image-tags` or (as I have) add it as a bash function that's exported.
  - note the use of `$GITHUB_USER`

```bash

docker-tags() {
  local project=$1
  project=${project:="lewinc/activemq"}
  local token_uri="https://auth.docker.io/token"
  local list_uri="https://registry-1.docker.io/v2/$project/tags/list"
  local scope="scope=repository:${project}:pull"
  local token=$( curl -Ss "${token_uri}?service=registry.docker.io&${scope}" | jq -r .token )
  curl -s -H "Accept: application/json" -H "Authorization: Bearer $token" "${list_uri}" | jq -r  ".tags[]"
}

ghcr-tags() {
  local project=$1
  project=${project:="quotidian-ennui/docker-activemq"}
  local ghcr_token=$(curl -s -u"$GITHUB_USER:$(gh auth token)" "https://ghcr.io/token?scope=\"repository:$project:pull\"" | jq --raw-output ".token")
  curl -s -H "Authorization: Bearer $ghcr_token" "https://ghcr.io/v2/$project/tags/list" | jq --raw-output ".tags[]"
}

image-tags() {
  local containerRegistry=$1
  local repository=$2

  case "$containerRegistry" in
    quay.io)
      curl -s "https://quay.io/api/v1/repository/$repository/tag/" | jq -r ".tags[].name"
      ;;
    ghcr.io )
      ghcr-tags $repository
      ;;
    * )
      docker-tags $repository
      ;;
  esac
}

```

- For bonus points you can do this as a docker-health-check for a given container

```bash

docker-health-check() {
  local container_id=$1
  local state=$(docker inspect -f {{.State.Health.Status}} $container_id)
  while [ "$state" != "healthy" ]; do
    echo Waiting for ${container_id} to reach 'healthy'
    sleep 5
    state=$(docker inspect -f {{.State.Health.Status}} $container_id)
  done
  echo ${container_id} is 'healthy'
}
```