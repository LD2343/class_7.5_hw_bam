# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance 

resource "google_compute_instance" "hw_vm" {
  name         = "hw-vm"
  machine_type = "n2-standard-2"

  # Zone argument required if default provider zone not set 
  zone = "us-central1-a"

  # Create persistent disk set as boot disk from the following image
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-10"
      size  = 100
    }
  }

  # Network configurations  
  network_interface {
    subnetwork = google_compute_subnetwork.hw_subnet.name
    access_config {
      // Ephemeral public IP 
    }
  }

  tags = ["http", "ssh", "icmp"]

  # Use file() to get shell script for startup script argument
  metadata_startup_script = file("./startup.sh")

}