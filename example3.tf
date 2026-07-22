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

resource "scp_indexes" "my_scp_index" {   //this is a Terrafrom name
  name = "index1" //this will show up in Splunk 
}

resource "scp_hec_tokens" "my_scp_hectoken" {
  name = "hectoken_for_the_talk"
  allowed_indexes = ["index1"]
}

resource "scp_splunkbase_app" "github" {
  name              = "Splunk_TA_github"
  version           = "3.3.1"
  splunkbase_id     = "6254"
  acs_licensing_ack = "https://www.splunk.com/en_us/legal/splunk-general-terms.html"
}


resource "scp_users" "github_app_admin_user" {
  name                        = "github_app_admin"
  password                    = "somepassword"
  default_app                 = "Splunk_TA_github"
  roles                       = ["user"]
  federated_search_manage_ack = "Y"
  email                       = "tester@domain.com"
}


