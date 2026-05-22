# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
# # Client -> Static IP -> Fwd Rule -> HTTP Proxy -> URL Map (URL Map chooses backend service)

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
# Reserve Static IP Address
resource "google_compute_global_address" "lb-ip" {
  name = "alb-static-ip"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# Global URL Map
# Maps incoming HTTP request URLs to backend services.
resource "google_compute_url_map" "lb-url-map" {
  name            = "lb-url-map"
  default_service = google_compute_backend_service.lb-backend.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
# Global HTTP Proxy
# Acts as the HTTP frontend proxy that uses the URL map to decide where to send traffic.
resource "google_compute_target_http_proxy" "lb-http-proxy" {
  name    = "lb-http-proxy"
  url_map = google_compute_url_map.lb-url-map.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
# Global Forwarding Rule
# Defines how incoming traffic is forwarded to the load balancer proxy based on port and protocol
resource "google_compute_global_forwarding_rule" "lb-forwarding-rule" {
  name   = "lb-forwarding-rule"
  target = google_compute_target_http_proxy.lb-http-proxy.id

  port_range            = "80"
  ip_protocol           = "TCP"
  ip_address            = google_compute_global_address.lb-ip.address
  load_balancing_scheme = "EXTERNAL_MANAGED"
}
