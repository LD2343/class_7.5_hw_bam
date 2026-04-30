output "vpc_name" {
  value = google_compute_network.WaffleHouseVPC.name
  description = "vpc name"
}