## Individual Q&A

### Load Balancers:
    
#### How does load balancing contribute to Fault tolerance? What about high availability? 
   - Load balancers contribute to Fault Tolerance through the use of utilizing health checks to route traffic to healthy instances avoid single points of failure.
   - Load balancers contribute to high availability through the ability to route traffic to instances in different regions/zones to avoid regional/zonal failure.

#### Do global load balancers decrease latency for end users? Why or why not? 
   - Yes global load balancers decrease latency due to the ability to route traffic to the closest region/zonal backend.
#### What are LB health checks for? Do we always need them? Is a LB different from a reverse proxy? 
   - LB Health checks are for checking if a backend is healthy for routing traffic.
   - Yes LB Health checks are required.
   - Load balancer just handles routing traffic and the reverse proxy is for routing request to backends and handles SSL termination and caching.
#### What are LB routing rules and URL maps for? Give an example or two of them in use. 
   - Forwarding (Routing) Rules provides the ability to route traffic to specific backends based on IP address/protocol/port.
   - URL maps are for routing traffic after it hits the load balancer based on rules defined in the URL map.
#### Explain what an anycast IP address is used for in the context of a global load balancer. 
- The anycast IP is a single global IP that is used by the global load balancer to have just one frontend IP that w/ the global load balancer can route traffic to the closest healthy backend.
    

### Cloud Armor:
    

#### What does cloud armor offer? 
   - Cloud Armor offers protection for apps and websites for things like DDOS, WAF, OWASP Top 10 mitigation & other threats.
#### Why is it used in the first place?
   - Since the global load balancer is accessible via the anycast IP, we need protection against bad actors and security threats.
#### What layer in the OSI model does it operate at? Why is this important and how is this firewall different from VPC firewall rules? 
   - Operation layer is Layer 7 as well as 3 and 4.
   - The VPC firewalls operate at layer 3 and 4 while Cloud Armor works at layer 7.
#### What are rate based rules for? 
   - These are used to protect against large volume of request brute force attacks.
#### What is reCAPTCHA and how does it relate to this service? 
   - reCAPTCHA is a Google provided service that protects against spam, automated bots & fraudulent activities.
   - Cloud Armor can integrate with Google's reCAPTCHA to evaluate request from the reCAPTCHA.
    

### Cloud CDN: 
    

#### What are POPs used for? 
   - POPs (Points of Presences) are physical edge locations that provide access to cached data to users based on geo location to reduce latency.
#### What kind of files are served with Cloud CDN? 
   - Images, videos, audio, ccs files, javascript and documents like pdfs
#### What services can be used with cloud CDN for the source of content (the origin)? 
   - MIGs, buckets, Cloud Run, GKE
#### Does Cloud CDN help protect against any types of malicious actors or cyberattacks? Explain. 
   - Cloud Armor is used for this. Cloud CDN is used more managing large amounts of traffic (DDOS).
#### Should an enterprise always use cloud CDN? Why or why not? 
   - Depends on the use case. Cloud CDN is best for situations where there will be an app with lots of static content and a global user base. Outside if this use case it might not be cost effective.
#### What is TTL and how does it control content “freshness”?
   - TTL means Time to Live. TTL determines how long data stays cached before Cloud CDN checks the origin for updates.
    

#### Resources
   - https://www.geeksforgeeks.org/system-design/reverse-proxy-vs-load-balancer/
   - https://medium.com/@dinesharney/load-balancer-vs-reverse-proxy-vs-api-gateway-understanding-the-modern-web-traffic-managers-409ce280a256
   - https://www.cloudns.net/blog/what-is-a-point-of-presence-pop-and-why-does-it-matter/