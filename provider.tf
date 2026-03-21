terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "5.2.1"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}
