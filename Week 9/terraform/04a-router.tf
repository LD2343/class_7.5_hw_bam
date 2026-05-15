# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
# Iowa Router
resource "google_compute_router" "iowa_router" {
  name    = "iowa-router"
  region  = var.region_a
  network = google_compute_network.hw_vpc.id
}