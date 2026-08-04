terraform {
  required_version = "1.15.8"
  required_providers {
    scp = {
      source = "registry.terraform.io/splunk/scp",
      version = "1.3.3"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  cloud {
    
    organization = "splunktest"

    workspaces {
      name = "splunk_apps_staging"
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

variable "github_token" {
  type = string
  description = "token for Github organisation"
}


provider "scp" {
  stack = var.stack_name
  server = var.acs_server
  username = var.scp_username
  password = var.scp_password
  splunk_username = var.splunk_username
  splunk_password = var.splunk_password
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "some_repo" {
  name         = "tf_managed_repository"
  description  = "This is a TF managed repository"
}

resource "scp_indexes" "my_scp_index" {
  name = "index1" 
}

resource "scp_hec_tokens" "my_scp_hectoken" {
  name = "hectoken_for_the_talk"
  allowed_indexes = ["index1"]
}

locals {
  ta_prefix = "Splunk_TA"
  gh_app_name = "${local.ta_prefix}_github"
  aws_app_name = "${local.ta_prefix}_aws"
}

resource "scp_splunkbase_app" "github" {
  name              = local.gh_app_name
  version           = "3.3.1"
  splunkbase_id     = "6254"
  acs_licensing_ack = "https://www.splunk.com/en_us/legal/splunk-general-terms.html"
}

resource "scp_users" "github_app_admin_user" {
  name                        = "github_app_admin_user"
  password                    = "somepassword"
  default_app                 = local.gh_app_name
  roles                       = ["user"]
  federated_search_manage_ack = "Y"
  email                       = "tester@domain.com"

  // Now we need to be explicit about the dependency.
  depends_on = [
    scp_splunkbase_app.github
  ]
}

