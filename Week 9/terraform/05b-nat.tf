# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
# Tokyo Router Nat
resource "google_compute_router_nat" "tokyo_router_nat" {
  name   = "tokyo-router-nat"
  router = google_compute_router.tokyo_router.name
  region = var.region_b

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.tokyo_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.tokyo_nat.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
# Tokyo Nat
resource "google_compute_address" "tokyo_nat" {
  name         = "tokyo-nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.region_b
}