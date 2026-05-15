# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group

resource "google_compute_region_instance_group_manager" "iowa-mig" {
  name               = "iowa-mig"
  base_instance_name = "iowa-instance"
  region             = var.region_a

  # Compute zones to be used for VM creation
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

  # Instance Template argument for MIG
  version {
    instance_template = google_compute_instance_template.iowa_it.id
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
    health_check      = google_compute_region_health_check.iowa-hc.id
    initial_delay_sec = 300
  }
}