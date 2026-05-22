# output "vm_ips" {
#   value = [google_compute_instance.hw_vm.network_interface[0].network_ip, google_compute_instance.hw_vm.network_interface[0].access_config[0].nat_ip]
# }

# output "vm_url" {
#   value = "http://${google_compute_instance.hw_vm.network_interface[0].access_config[0].nat_ip}"
# }

# output "vm_name" {
#   value = google_compute_instance.hw_vm.name
# }

# output "vm_id" {
#   value = google_compute_instance.hw_vm.id
# }

# output "vm_self_link" {
#   value = google_compute_instance.hw_vm.self_link
# }