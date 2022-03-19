variable "database_user" {
  description = "DB user name"
  type        = string
}

variable "database_name" {
  description = "DB user name"
  type        = string
  default     = "test_db"
}

variable "project_id" {
  description = "Google Cloud Platform (GCP) Project ID."
  type        = string
}

variable "zone" {
  description = "GCP zone name."
  type        = string
}

variable "region" {
  description = "GCP region name."
  type        = string
}

variable "database_instance_name" {
  description = "DB instance name"
  type        = string
}
