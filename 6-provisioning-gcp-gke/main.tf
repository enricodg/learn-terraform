terraform {
  backend "gcs" {
    bucket = "tf-state-testing-123123"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8.0"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 2.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.1"
    }
  }
}
