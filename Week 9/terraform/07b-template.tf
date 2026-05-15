# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template
# Tokyo Instance Template
resource "google_compute_instance_template" "tokyo_it" {
  name         = "tokyo-it"
  machine_type = "e2-medium"
  region       = var.region_b

  disk {
    source_image = "debian-cloud/debian-12"
    boot         = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tokyo_subnet.name
    access_config {
      // Ephemeral public IP 
    }
  }

  tags = ["http", "ssh", "icmp"]

  # Use file() to get shell script for startup script argument
  metadata_startup_script = file("./startup.sh")

}