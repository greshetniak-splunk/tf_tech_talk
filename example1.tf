terraform {
  required_providers {
    scp = {
      source = "registry.terraform.io/splunk/scp",
      version = "1.3.3"
    }
  }
}

// don't do this in prod 
// don't do this anywhere in fact ;) 

provider "scp" {
  stack = "acmecorp"
  server = "staging"
  username = "greg"
  password = "password"
  splunk_username = "gregory"
  splunk_password = "totally_different_password"
}

resource "scp_splunkbase_app" "github" {
  name              = "Splunk_TA_github"
  version           = "3.3.1"
  splunkbase_id     = "6254"
  acs_licensing_ack = "https://www.splunk.com/en_us/legal/splunk-general-terms.html"
}
