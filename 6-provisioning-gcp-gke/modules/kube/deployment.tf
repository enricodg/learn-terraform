resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.deployment_name
    namespace = var.namespace_name
    labels = {
      app = "test"
    }
  }

  spec {

    selector {
      match_labels = {
        app = "test"
      }
    }
    template {
      metadata {
        name      = var.deployment_name
        namespace = var.namespace_name
        labels = {
          app = "test"
        }
      }

      spec {
        container {
          image = var.image
          name  = var.deployment_name

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
