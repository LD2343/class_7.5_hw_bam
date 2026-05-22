# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.hw_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["ssh"]
}


resource "google_compute_firewall" "http" {
  name    = "http"
  network = google_compute_network.hw_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["http"]
}

# Lizzo's ping FW rule
resource "google_compute_firewall" "ping" {
  name    = "ping"
  network = google_compute_network.hw_vpc.name

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["icmp"]
}