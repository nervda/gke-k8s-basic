terraform {
  cloud {
    organization = "hashicorp-support-eng"
    
    workspaces {
      name = "julie-just-gke"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.31.0"
    }
  }
}
