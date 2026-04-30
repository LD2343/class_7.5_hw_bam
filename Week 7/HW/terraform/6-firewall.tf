resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Lab only

  depends_on = [
    google_compute_network.main
  ]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.main
  ]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.main
  ]
}

# UDP 500 ESP
resource "google_compute_firewall" "allow_esp" {
  name    = "allow-esp"
  network = google_compute_network.main.name

  allow {
    protocol = "udp"
    ports    = ["500"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.main
  ]
}

# TCP 3389 RDP
resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.main
  ]
}