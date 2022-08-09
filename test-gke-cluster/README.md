https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes

Provision GKE cluster in GCP [a]. Make note of outputs kubernetes_cluster_host and kubernetes_cluster_name.

Configure kubctl [b]

K8s Dashboard [c]

Authenticate [d]

Configure K8s provider [e]. I recommend reading the ways you can configure the Kubernetes provider here [f].

Test success by Scheduling a Deployment [g]. After terraform apply, execute kubectl get services as seen in the tutorial. Interestingly, I received Invalid attribute in provider configuration, 'host' is not a valid URL. However, this did not prevent deployment of scalable-nginx-example.

Please let me know if you what errors you get or if your deployment is successful.

[a] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes
[b] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#configure-kubectl
[c] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#deploy-and-access-kubernetes-dashboard
[d] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#authenticate-to-kubernetes-dashboard
[e] https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider#configure-the-provider
[f] https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
[g] https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider#schedule-a-deployment

---

kubernetes_cluster_host = ""
kubernetes_cluster_name = ""
project_id = ""
region = "us-west1"

gcloud container clusters describe <kubernetes_cluster_name> --region <region> --format='default(locations)'


