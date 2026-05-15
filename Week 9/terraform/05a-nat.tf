# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
# Iowa Router Nat
resource "google_compute_router_nat" "iowa_router_nat" {
  name   = "iowa-router-nat"
  router = google_compute_router.iowa_router.name
  region = var.region_a

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.iowa_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.iowa_nat.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
# Iowa Nat
resource "google_compute_address" "iowa_nat" {
  name         = "iowa-nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.region_a
}