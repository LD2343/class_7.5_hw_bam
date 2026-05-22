# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check
# Global LB Health Check
resource "google_compute_health_check" "lb-health-check" {
  name = "lb-health-check"

  # How often in seconds the HC checks and waits for failure/success
  check_interval_sec = 5
  timeout_sec        = 5

  # Consecutive success and failure required to determine health
  healthy_threshold   = 2
  unhealthy_threshold = 3

  # Set health check to type HTTP and set endpoint to test
  http_health_check {
    request_path = "/index.html"
    port         = 80
  }
}

# ...
# Backend
resource "google_compute_backend_service" "lb-backend" {
  name                  = "lb-backend"
  health_checks         = [google_compute_health_check.lb-health-check.id]
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  load_balancing_scheme = "EXTERNAL_MANAGED"

  depends_on = [
    google_compute_health_check.lb-health-check,
    google_compute_region_instance_group_manager.iowa-mig,
    google_compute_region_instance_group_manager.tokyo-mig
  ]

  # Iowa Backend
  backend {
    group                 = google_compute_region_instance_group_manager.iowa-mig.instance_group
    capacity_scaler       = 1.0
    balancing_mode        = "RATE"
    max_rate_per_instance = 10
  }

  # Toyko Backend
  backend {
    group                 = google_compute_region_instance_group_manager.tokyo-mig.instance_group
    capacity_scaler       = 1.0
    balancing_mode        = "RATE"
    max_rate_per_instance = 10
  }


}