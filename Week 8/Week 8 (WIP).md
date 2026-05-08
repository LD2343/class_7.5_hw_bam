
Questions
**

- Answer the following questions in a section called “Q & A”:
    
- Each bullet point can be between 1-5 sentences. You choose the amount of detail as long as I see that you understand it. 
    
	- What is the difference between high availability and fault tolerance? Which is best to strive for? 
		- High Availability focuses on minimizing service and app downtime/disruption. Goal is minimal downtime.
			- Load Balancers, Health Checks, Multi-Zone
		- Fault tolerance focuses on maintaining service availability during failure and recovery. Goal is zero downtime.
			- Auto-scaling w/ load balancer, Multi-Region
	    - Fault Tolerance is best to strive for if budget is available. Fault Tolerant design is more expensive than just High Availability.
	- 
	- Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem? 
		- Autoscaling is the ability to scale the number of VMs up or down based on incoming workload.
		- Elasticity is automation for dynamic vertical and/or horizontal scaling based on incoming workload.
		-  Vertical Autoscaling is scaling up in terms of increasing a servers capacity (increasing CPU/Memory/Storage)
		- Horizontal Autoscaling is scaling out in terms of adding more servers to sharing the workload (adding more VMs to the MIG)
		- Horizontal is better than vertical since it improves availability and fault tolerance.
		- Not feasible on prem, in terms of expanding past current capacity, since you need to scale up and down based on workload which would be difficult for physical servers.
	    
	- Explain what the difference between managed and unmanaged instance groups is.
		    - Managed Instance Groups: This is for managing multiple identical VMs in terms of scalability & high availability utilizing automated services like autoscaling or autohealing. Recommended by Google.
		    - Unmanaged Instance Groups: This is for user-managing load balancing across non-identical VMs. Doesn't included existing automated configuration for autoscaling or autohealing.
	- Explain the different use cases for health checks used by applications (in instance groups) and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same? 
		    - MIG Health Checks are used to check a VMs health and signal the need to delete and recreate instances
		    - Load Balancing Health Checks are used to direct traffic away from unhealthy VMs to healthy VMs
		    - Technically they can be the same but it is recommend they are different since the health check for a load balancer should be more aggressive because these checks route user traffic. The health checks for MIGs should be less aggressive since they are checking if autohealing is needed. Both have the same API calls.
	- Explain in a few sentences what the 3 tier architecture is and how it relates to what you are learning.
		- 3 Tier architecture is made up of 3 design levels
			- Web Tier - Application frontend that usually receives track from an external ALB to send the traffic to the frontend MIGs which will then send to the internal ALB
			- Application Tier - This is the internal MIGs that receive traffic from the internal ALB
			- Database Tier - This level has the databases that receive traffic from the internal MIGs
		- Relates to what we are learning since we are doing MIGs and Load balancers.
    
**

Runbook
	Goal of runbook
		- The goal of this runbook is to provide instruction on how to create a manage instance group (MIG) in GCP. 
		- This runbook will walkthrough the clickops process of setting this up with the proper configuration and autoscaling/autohealing.
		- This runbook is for stateless multi-zone MIG.
	Prerequisites
		GCP Account
		Instance Template
	Process Steps
		Create MIG
			- In GCP navigate to Instance Groups and click create Instance Group
			- ![[Pasted image 20260504191614.png]]
		MIG Name & Type
			- Select Stateless MIG
			- Give MIG a name, description, instance template, desired number of instances
			- ![[Pasted image 20260504191726.png]]
		Location
			- In location, select Multi-zones, select region and zones
			- Leave Target distribution as Balanced
			- ![[Pasted image 20260504192054.png]]
		Autoscaling
			- Click configure Autoscaling
			- Autoscaling mode = On: add and remove instances to the group
			- Select the number of minimum & maximum instances
			- Autoscaling signals
				- Set the Signal type and related settings
			- ![[Pasted image 20260507211122.png]]
		Autohealing
			- Add a Health check
				- Scope - Regional
				- Select region, protocol & port
				- Turn on logs
				- Set Health Criteria
				![[Pasted image 20260507213529.png]]
		Click create to create the MIG
		Verification MIG is working
			Navigate to the Instance Group and click on the MIG
			Review the Overview section to see the running instances
			![[Pasted image 20260507221327.png]]
Terraform VM Breakdown
	Required arguements for VM instance (google_compute_instance)
		name, boot_disk, machine_type
	Output internal and external IP addresses of provisioned VM
		How I figured this out
			The vm terraform resource registry page, the attributes section shows what can be exported (used for terraform outputs) - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#attributes-reference
			The gcp output hashicorp documentation - https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-outputs
		Outputs
			```terraform
				output "internal ip" {
				value = google_compute_instance.vm_instance.network_interface.0.network_ip
			}
			```
			```terraform
				output "external ip" {
					value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
				}
			```
	2 Non-required VM arguments
		...
		...
		...
		...

Additional Resources Used
	https://www.nobl9.com/service-availability/high-availability-vs-fault-tolerance
	https://www.scalecomputing.com/resources/fault-tolerance-vs-high-availability
	https://aerospike.com/blog/understanding-elasticity-scalability-cloud-computing/
	