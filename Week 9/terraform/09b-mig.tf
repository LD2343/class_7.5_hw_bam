# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group
# Tokyo MIG
resource "google_compute_region_instance_group_manager" "tokyo-mig" {
  name               = "tokyo-mig"
  base_instance_name = "tokyo-instance"
  region             = var.region_b

  # Compute zones to be used for VM creation
  distribution_policy_zones = ["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"]

  # Instance Template argument for MIG
  version {
    instance_template = google_compute_instance_template.tokyo_it.id
  }

  # Target Size
  target_size = 3

  # Set a port to be used by backend service
  named_port {
    name = "http"
    port = 80
  }

  # Autohealing Config
  auto_healing_policies {
    health_check      = google_compute_region_health_check.tokyo-hc.id
    initial_delay_sec = 300
  }
}