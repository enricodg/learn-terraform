data "google_compute_image" "debian" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}

data "template_file" "nginx" {
  template = file("${path.module}/template/install_nginx.tpl")

  vars = {
    ufw_allow_nginx = "Nginx HTTP"
  }
}

resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["http-server"]
  labels       = var.labels
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = data.template_file.nginx.rendered
}
