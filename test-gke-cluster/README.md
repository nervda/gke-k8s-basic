https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes

kubernetes_cluster_host = ""
kubernetes_cluster_name = ""
project_id = ""
region = "us-west1"

gcloud container clusters describe <kubernetes_cluster_name> --region <region> --format='default(locations)'
