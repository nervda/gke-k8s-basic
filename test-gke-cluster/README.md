https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes

[ ] Provision GKE cluster in GCP [a]. Make note of outputs kubernetes_cluster_host and kubernetes_cluster_name.

[ ] Configure kubctl `cloud container clusters get-credentials hc-4e0a64c8b917486b8ad054b8c76-gke --region us-west1` [b]

[ ] K8s Dashboard `kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml` and then `kubectl proxy` [c]

[ ] Authenticate `kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-gke-cluster/main/kubernetes-dashboard-admin.rbac.yaml` and `kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')` [d]

[ ] GKE nodes and node pool `gcloud container clusters describe <kubernetes_cluster_name> --region <region> --format='default(locations)'`

---

[ ] Configure K8s provider [e]. I recommend reading the ways you can configure the Kubernetes provider here [f].

Test success by Scheduling a Deployment [g]. After terraform apply, execute kubectl get services as seen in the tutorial. Interestingly, I received Invalid attribute in provider configuration, 'host' is not a valid URL. However, this did not prevent deployment of scalable-nginx-example.

Please let me know if you what errors you get or if your deployment is successful.

[a] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes
[b] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#configure-kubectl
[c] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#deploy-and-access-kubernetes-dashboard
[d] https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#authenticate-to-kubernetes-dashboard
[e] https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider#configure-the-provider
[f] https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
[g] https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider#schedule-a-deployment
