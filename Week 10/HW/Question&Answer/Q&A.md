# Q&A

## DNS & SSL/TLS

### Explain what the traceroute and dig commands do. Compare and contrast?
  - Traceroute tracks the path packets take from the host to each individual router to the final destination and time between each hop.
  - Dig commands are used to lookup domain information by querying DNS servers.
### What are the 3 or 4 most common DNS records and what are their use cases?
  - Most common DNS records are A, NS, AAAA, MX.
    - A records are the mapping of domain names to IPv4 addresses.
    - NS records tells us what authoritative DNS server is responsible for a second level domain.
    - AAAA records are mapping of domain names to IPv6 addresses.
    - MX records identity which mail servers handle email.
### Give an overview of the steps in a TLS handshake.
  - Client sends a request to the server to authenticate itself.
  - The server responds back with its SSL certificate to authenticate itself.
  - The client vertifies the SSL certificate with the certificate authority that issued it.
  - Once Authenticated the virtual handshake happens between the client and the server.
  - Now mutual encrypted communication can happen between client and the server.
### How does an SSL/TLS cert know what domain it belongs to?
  - During the authentication of the cert to the certificate domain authority the domain information is a part of the cert being verified.
### What is a certificate authority? 
  - The organization that issues digital certificates.

## Load Balancers

### How do application load balancers in GCP offload (decrypt) SSL? What part of the load balancer does this?
-  ...
-  ...
-  ...
### Are there use cases to have in flight encryption from the backend service to the backend itself?
- ...
- ...
- ...

## Cloud Domain/DNS

### Can multiple domains end up pointing to the same LB?
-  ...
-  ...
-  ...
### In the context of Cloud DNS, what are zones?
- ...
- ...
- ...