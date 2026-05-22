# The anti-drunk engineer runbook

## Issue: The Cloud VM is not reachable from the public internet and also can’t be reached through SSH

## Instructions:

1. Our first step is to verify the errors.
2. In your console head to Compute Engine and select VM instance and select the homework-vm instance.
3. Click Start to get your instance to start running.
4. What we want is the Instance to be running and from there we can select the external IP
5. While checking the instance there are no external IPs present.
6. So from there click on the instance and click Edit. Scroll down to Networking
7. Under Network interfaces, click on the homework-vpc-homework-subnet IPv4.
8. In External IPv4 address, select Ephemeral and select Premium click done.
9. Under Firewalls select, Allow HTTP traffic, scroll down to the bottom of the page and click Save.
10. Head back to VM instances and on homework-vm, copy the External IP, curl http://<External IP> in your terminal 
11. It returns a failed to connect to the External IP, so we can’t connect on port 80 which is one of the issues.
12. The next step is to verify ssh connection, so back on the console, in the VM instances under the Connect ribbon click on SSH
13. Click Authorize, to establish connection to SSH server, a dialog box pops up Connection via Cloud Identity-Aware Proxy Failed, this verifies that we can reach the instance via SSH
14. We verified that the VM isn’t reachable through public internet or through SSH.
15. These issues are pointing to a firewall issue, next we head to the VPC networks, select VPC networks
16. Click on homework-vpc, head to the Firewalls.
17. Inside Firewalls we have the homework-deny-all rule, which deny all  protocols and ports with a priority of 0.
18. This priority will override all of our other rules especially with it being a priority of 0.
19. Click on the homework-deny-all, delete the rule
20. Head back to the VPC network, in the Firewalls, we’ll take a look at the next rules to see if there are any incorrect configurations
21. The  homework-allow-ssh, scroll to the Source filters IP range which is 1.2.3.4/32, which well keep us from accessing through SSH it won’t match our IP
22. Click on Edit
23. So we’ll change the IP range to 0.0.0.0/0, this way we can access through SSH through any IP range, since it’s open to all.
24. We verified the Specified protocols and ports , TCP , Port 22
25. Head back to VPC networks, Firewalls, check the next rule homework-vpc-allow-http, going through the rule it matches the IP range of 0.0.0.0/0, protocol and port are both TCP and 80 for the port.
26. So the rule is correct and won’t need any necessary adjustments.
27. Those corrections have been made so let’s check if the VM is accessible via the public internet.
28. Let’s head back to the VM instance, copy the External IP, and in your terminal. Run curl http://<External IP>
29. We received an error that can’t connect on port 80, so we still have a connection issue to the internet.
30. Next we’ll check the SSH connection, in the VM instance on homework-vm click on SSH, click Authorize .
31. So we have been able to access the VM instance through SSH.
32. The SSH connection has been resolved.
33. Our next step is to check with our VPC to see why we can’t establish a connection through the public internet.
34. In the console head back to the VPC network and click on homework-vpc.
35. We’ll check through the subnets, and everything is configure correctly.
36. In Firewalls we verified that all of them have been correct.
37. We don’t have to change anything with Endpoint groups nor Firewall endpoints
38. Under Routes we discovered that homework-vpc did not have a default internet route configured.
39. Earlier route verification was performed against the default network, not homework-vpc.
40. Because homework-vpc was missing a 0.0.0.0/0 route, the VM could not communicate properly with the public internet.
41. While still in VPC networks, click Routes, then click Route management.
42. Click Create Route.
43. Configure the route, the network will be homework-vpc, IPv4 range will be 0.0.0.0/0, make sure the next hop is Default internet gateway.
44. Click Create.
45. After the route was created, head back to VM instances, copy the External IP, and run:
    curl http://<External IP>
46. The VM instance was now reachable from the public internet.