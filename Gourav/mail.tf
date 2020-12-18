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

module "mod" {
  source = "/home/gouravatreya/Gourav/module"
}

resource "google_compute_instance" "cluster" {
  count        = 1
  machine_type = "n1-standard-1"
  name         = "test"

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
  # ...
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = join(",", google_compute_instance.cluster.*.id)
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = element(google_compute_instance.cluster.*.public_ip, 0)
  }
  #provisioner "remote-exec" {
  # Bootstrap script called with private_ip of each node in the cluster
  # inline = [
  #  "bootstrap-cluster.sh ${join(" ", google_compute_instance.cluster.*.private_ip)}",
  #]
  #}
}

#resource "google_sql_database_instance" "Database" {
# provider = "google-beta"
#name             = "database-master1"
#region           = "europe-west1"
#database_version = "MYSQL_5_7"
#settings {
# tier              = "db-f1-micro"
#disk_size         = "221"
#availability_type = "ZONAL"
#disk_autoresize   = "true"
# }
#}
