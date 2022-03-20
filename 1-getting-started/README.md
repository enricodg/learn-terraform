# 1. Getting Started
This playbook is to give an overview of how to write Terraform code.  

## Step to Execute
1. Execute `$ terraform init`
2. If you wish to see the plan, use `$ terraform plan`
3. Execute `$ terraform apply`
4. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.

## Explanation
The `terraform` block is an optional block which is used to let Terraform knows which provider version will be used. `~>` is to state that the version used is at least or greater than 4.14.0.
```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}
```

The `provider` block is to let Terraform knows which provider that will interact with Terraform (in this case Google). Get the project-id from your GCP console and register it to the `project` attribute.  
You can take a look of full complete region & zone list in [here](https://cloud.google.com/compute/docs/regions-zones).
```
provider "google" {
    project = "enrico-labs"
    region  = "asia-southeast2"
    zone    = "asia-southeast2-a"
}
```

The `resource` block is to state which GCP services that you want Terraform to provide you (in this case a vpc network, a subnet and a single compute instance). Please find the full documentation regarding Google provider [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs). You can also see how easy it is to access data between resources (as seen in `network` attribute under subnetwork).
```
resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-southeast2"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "my-secondary-range"
    ip_cidr_range = "192.168.10.0/24"
  }
  depends_on = [
    resource.google_compute_network.vpc_network
  ]
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
    }
  }
}
```