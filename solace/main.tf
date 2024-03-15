terraform {
  required_providers {
    solace = {
      source  = "telus-agcg/solace"
      version = "~> 0.8.0"
    }
  }
}

locals {
  namespace    = "zzlc"
  app_name     = "${local.namespace}/app"
  endpoints    = toset(["SampleQ1", "SampleQ2", "SampleQ3"])
  msg_vpn_name = "default"
}

provider "solace" {
  username = "admin"
  password = "admin"
  scheme   = "http"
  hostname = "localhost:18080"
}

resource "solace_queue" "queue_defs" {
  for_each        = local.endpoints
  queue_name      = "${local.app_name}/${each.value}"
  msg_vpn_name    = local.msg_vpn_name
  ingress_enabled = true
  egress_enabled  = true
  access_type     = "non-exclusive"
  permission      = "consume"
}

# Bind the queue to the a topic of the same name, so publish to topic, and consume from queue
resource "solace_queue_subscription" "app_topic_subscription" {
  for_each           = local.endpoints
  queue_name         = solace_queue.queue_defs[each.key].queue_name
  subscription_topic = solace_queue.queue_defs[each.key].queue_name
  msg_vpn_name       = local.msg_vpn_name
}
