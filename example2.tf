terraform {
  required_providers {
    scp = {
      source = "registry.terraform.io/splunk/scp",
      version = "1.3.3"
    }
  }
}

variable "stack_name" {
  type = string
  description = "Splunk Cloud stack name"
}

variable "acs_server" {
  type = string
  description = "acs server: prod or staging"
}

variable "scp_username" {
  type = string
  description = "username for the Splunk Cloud stack"
}

variable "scp_password" {
  type = string
  description = "password for the Splunk Cloud stack"
}


variable "splunk_username" {
  type = string
  description = "username to authenticate into Splunkbase"
}


variable "splunk_password" {
  type = string
  description = "password to authenticate into Splunkbase"
}


provider "scp" {
  stack = var.stack_name
  server = var.acs_server
  username = var.scp_username
  password = var.scp_password
  splunk_username = var.splunk_username
  splunk_password = var.splunk_password
}

resource "scp_splunkbase_app" "github" {
  name              = "Splunk_TA_github"
  version           = "3.3.1"
  splunkbase_id     = "6254"
  acs_licensing_ack = "https://www.splunk.com/en_us/legal/splunk-general-terms.html"
}

