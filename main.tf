provider "google" {
  credentials = file("/home/gouravatreya/key1.json")
  project     = "norse-quest-291706"
  region      = "us-central1"
  zone        = "us-central1-a"
}

provider "google-beta" {
  credentials = file("/home/gouravatreya/key1.json")
  project     = "norse-quest-291706"
  region      = "us-central1"
  zone        = "us-central1-a"
}
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
