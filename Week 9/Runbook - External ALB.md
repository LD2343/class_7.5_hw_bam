## Runbook

### Runbook Goals
- Build External Application Loadbalancer using a MIG as the backend

### Prerequistes
- GCP Account
- Properly Configured Instance Template
- Properly Configured MIGs
    - Desired Region & Zones
    - MIG Health Check
    - Autoscaling

### Runbook Steps - External Load Balancer
- Creation Steps
  - Navigate to Load Balancing
  - Click Create Load Balancer
  - Select the following settings and click Configure
    - Application Load Balancer (HTTP/HTTPS)
    - Public facing (external)
    - Best for Global Workloads
    - Global External Application Load Balancer
- Name Load Balancer
- Frontend Configuration
  - Enter name & description
  - Protocol = HTTP
  - IP Version = IPv4
  - IP Address = Ephemeral (Automatic)
  - Port = 80
- Backend Configuration
  - Create a backend service #1
    - Enter name & description
    - Backend Type = Instance Group
    - Protocol = HTTP
    - Named Port = http
    - Timeout = 30 secs
    - IP Address Selection Policy = Only IPv4
    - Health Check = select ALB hc (create if don't exist)
  - New Backend #1
    - IP Stack Type = IPv4 (single-stack)
    - Instance Group = select appropriate regional mig
    - Port Number = 80
    - Balancing Mode = Rate
      - Traffic Duration = Default (Short)
      - Maximum RPS = 10
      - Scope = per instance
      - Backend Preference Level = None
    - New Backend #2
      - Follow the steps above for all additional backends
    - Cloud CDN = Unchecked
    - Logging = Unchecked
    - Identity-Aware Proxy = Unchecked
    - Cloud Armor = None
- Routing Rules
  - Mode = Simple Host and Path Rule
- Click Create