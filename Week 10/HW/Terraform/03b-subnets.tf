# Toyko Subnet
resource "google_compute_subnetwork" "tokyo_subnet" {
  name                     = "tokyo-subnet"
  ip_cidr_range            = "10.130.2.0/24"
  region                   = var.region_b
  network                  = google_compute_network.hw_vpc.id
  private_ip_google_access = true

  depends_on = [
    google_compute_network.hw_vpc
  ]
}