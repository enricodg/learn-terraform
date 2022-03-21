zone_list    = ["asia-southeast2-a"]
network_name = "gke-network"
subnets = [{
  description           = "private subnet"
  subnet_flow_logs      = false
  subnet_ip             = "10.0.0.0/16"
  subnet_name           = "subnet-01"
  subnet_private_access = true
  subnet_region         = "asia-southeast2"
}]
network_routes = []
subnet_secondary_ranges = {
  "subnet-01" = [
    {
      range_name    = "subnet-01-secondary-01-pods"
      ip_cidr_range = "192.168.0.0/24"
    },
    {
      range_name    = "subnet-01-secondary-01-services"
      ip_cidr_range = "192.168.1.0/24"
    }
  ]
}
k8s_cluster_name = "cluster-01"
