# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler#nested_autoscaling_policy_cpu_utilization
# Tokyo Regional MIG Autoscaling

resource "google_compute_region_autoscaler" "tokyo-autoscaling" {
  name   = "tokyo-autoscaling"
  region = var.region_b
  target = google_compute_region_instance_group_manager.tokyo-mig.id

  autoscaling_policy {
    max_replicas    = 6
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}
