terraform {
  required_providers {
    scp = {
      source = "registry.terraform.io/splunk/scp",
    }
  }
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



provider "scp" {
  stack = "nervous-nyala-b9i"
  server = "https://staging.admin.splunk.com"
  username = var.scp_username
  password = var.scp_password
  splunk_username = var.splunk_username
}

resource "scp_indexes" "index-1" {
  name = "index-1"
}

