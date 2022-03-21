# 6. Provisioning GCP GKE

This playbook demonstrates how to provision kubernetes cluster in Google Cloud Platform. It includes 1 cluster, 1 node, 1 service, 1 pod. Before going through this playbook, you may want to understand [Kubernetes](https://kubernetes.io/) and [GKE](https://cloud.google.com/kubernetes-engine).  
Please take a note since this is just demo, [modules/kube](modules/kube) configurations are mostly hard-coded in the code, in practice please make it into variables.

## Step to Execute
1. Execute `$ terraform init`
2. If you wish to see the plan, use `$ terraform plan`
3. Execute `$ terraform apply`
4. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.  

## Explaination

Since we're using kubernetes, don't forget to declare the `kubernetes` provider in [provider.tf](provider.tf). We'll need to provide cluster host, certificate, and service account token by getting the data from the cluster that we defined.
Take a look at [gke_cluster.tf](gke_cluster.tf) where we use provided module by Google to create a Kubernetes cluster. For full configuration, please take a look at the [module](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest) itself.  

In [modules/kube](modules/kube) you can see that it's just a normal Kubernetes deployment but instead of creating `.yaml` files to define the deployment/namespace/service, here we can easily state the metadata, spec, probe, and other Kubernetes properties throughout the Terraform resource block.  

To checkout whether the NGINX is succfessfully deployed, go through your web browser and open the IP address from `$ terraform apply` output or by taking a look at your GCP console.  

For practice purposes, you can try to create Kubernetes deployment with multiple cluster, configuring load balancer, and auto-scaler. Please remember to always read the documentation from the [registry](https://registry.terraform.io/) which is very helpful to guide you about everything.