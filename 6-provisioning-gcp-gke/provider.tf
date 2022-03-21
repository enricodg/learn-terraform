provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${module.kubernetes_engine.endpoint}"
  cluster_ca_certificate = base64decode(module.kubernetes_engine.ca_certificate)
  token                  = data.google_client_config.provider.access_token
}
