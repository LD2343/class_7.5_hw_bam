# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
# Tokyo Router
resource "google_compute_router" "tokyo_router" {
  name    = "tokyo-router"
  region  = var.region_b
  network = google_compute_network.hw_vpc.id
}