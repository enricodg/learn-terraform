variable "project_id" {
  default = "enrico-labs"
}

variable "region" {
  default = "asia-southeast2"
}

variable "zone" {
  default = "asia-southeast2-a"
}

variable "zone_list" {
  type = list(string)
}

variable "network_name" {

}

variable "routing_mode" {
  default = "REGIONAL"
}

variable "subnets" {
  type = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = bool
    subnet_flow_logs      = bool
    description           = string
  }))
}

variable "subnet_secondary_ranges" {
  type = map(any)
}

variable "network_routes" {
  type = list(map(string))
}

variable "k8s_cluster_name" {
  type = string
}
