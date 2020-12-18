resource "google_compute_instance" "hello" {
  count        = 1
  machine_type = "n1-standard-1"
  name         = "test1"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

