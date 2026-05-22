output "lb_static_ip" {
  value = "http://${google_compute_global_address.lb-ip.address}"
}