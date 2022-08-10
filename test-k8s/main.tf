terraform {
    cloud {
    organization = "hashicorp-support-eng"
    
    workspaces {
      name = "julie-gke-k8s"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.31.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}


variable "cluster_endpoint_url" {}
variable "cluster_ca_cert" {}

# data "terraform_remote_state" "gke" {
#   backend = "local"

#   config = {
#     path = "../test-gke-cluster/terraform.tfstate"
#   }
# }

# Retrieve GKE cluster information
provider "google" {
  project = "hc-4e0a64c8b917486b8ad054b8c76"   #data.terraform_remote_state.gke.outputs.project_id
  region  = "us-west1"     #data.terraform_remote_state.gke.outputs.region
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {}

data "google_container_cluster" "my_cluster" {
  name     = "hc-4e0a64c8b917486b8ad054b8c76-gke"   #data.terraform_remote_state.gke.outputs.kubernetes_cluster_name
  location =  "us-west1"  #data.terraform_remote_state.gke.outputs.region
}

provider "kubernetes" {
  host  =  "https://${data.google_container_cluster.my_cluster.endpoint}" #var.cluster_endpoint_url
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate) #base64decode(var.cluster_ca_cert)
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "example"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
} 

resource "kubernetes_manifest" "test-configmap" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "name"      = "test-config"
      "namespace" = "default"
    }
    "data" = {
      "foo" = "bar"
    }
  }
}
