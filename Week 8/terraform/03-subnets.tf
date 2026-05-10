
resource "google_compute_subnetwork" "hw_subnet" {
  name                     = "hw-subnet"
  ip_cidr_range            = "10.130.1.0/24"
  region                   = var.region
  network                  = google_compute_network.hw_vpc.id
  private_ip_google_access = true

  depends_on = [
    google_compute_network.hw_vpc
  ]
}