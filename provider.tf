terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "6.0.1"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}
