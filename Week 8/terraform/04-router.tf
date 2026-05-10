# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
resource "google_compute_router" "hw_router" {
  name    = "hw-router"
  region  = var.region
  network = google_compute_network.hw_vpc.id
}