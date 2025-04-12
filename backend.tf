terraform {
  backend "http" {
    address        = "https://ffddorf-terraform-backend.fly.dev/state/config-templates/default"
    lock_address   = "https://ffddorf-terraform-backend.fly.dev/state/config-templates/default"
    unlock_address = "https://ffddorf-terraform-backend.fly.dev/state/config-templates/default"
    username       = "github_pat"
  }
}
