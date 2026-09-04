terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "5.8.0"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}
