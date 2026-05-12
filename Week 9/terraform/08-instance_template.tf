# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template

resource "google_compute_instance_template" "lab_it" {
  name = "lab_it"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-12"
  }
}