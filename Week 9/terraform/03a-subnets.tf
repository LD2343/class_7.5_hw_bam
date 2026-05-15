# Iowa Subnet
resource "google_compute_subnetwork" "iowa_subnet" {
  name                     = "iowa-subnet"
  ip_cidr_range            = "10.130.1.0/24"
  region                   = var.region_a
  network                  = google_compute_network.hw_vpc.id
  private_ip_google_access = true

  depends_on = [
    google_compute_network.hw_vpc
  ]
}