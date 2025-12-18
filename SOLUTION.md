This proof of concept demonstrates how I would design and implement a cost-aware, cloud-native deployment platform using Kubernetes and GitOps. The focus is on building a clear, automated workflow that replaces manual deployments, while keeping infrastructure and operational overhead intentionally low.

The solution is scoped as a POC, but it follows patterns that scale naturally to production environments.

<!-- Platform -->
The platform is built on AWS EKS and provisioned entirely using Terraform. Applications are packaged with Helm, built using GitHub Actions, and deployed through Argo CD using GitOps principles.

Git is the single source of truth. Infrastructure changes are managed through Terraform, and application deployments occur when Argo CD detects changes in Git, rather than being pushed directly from CI.


A dedicated AWS VPC with public and private subnets across two availability zones
An EKS cluster with an AWS-managed control plane
Worker nodes running exclusively in private subnets
A simple multi-tier application** consisting of:
 Frontend (Nginx)
 Backend API
Database
External access provided through a Kubernetes Ingress Controller, which provisions a cloud load balancer

The only publicly exposed component is the ingress layer. Application workloads and worker nodes are not directly reachable from the internet.

<!-- Design Decisions and Rationale -->

<!-- Kubernetes Platform (EKS) -->

EKS was selected to reduce operational overhead by using a managed control plane. This keeps the focus on application delivery, automation, and security rather than cluster maintenance, while still reflecting a production-style setup.

<!-- Networking -->

The cluster runs inside a dedicated VPC with a clear separation between public and private subnets. Public subnets are used only for ingress load balancers, while worker nodes and application pods run in private subnets. A single NAT Gateway enables outbound access for image pulls and updates.

This design balances security and simplicity, which is appropriate for a POC.

<!-- Infrastructure as Code -->

Terraform is used with a modular structure to keep infrastructure definitions clear, reusable, and easy to extend. This allows the same approach to be applied across environments with minimal changes.

<!-- Application Packaging -->

The application is deployed using Helm rather than raw Kubernetes manifests. This simplifies configuration management and supports environment-specific values without duplicating YAML.

<!-- CI/CD and GitOps -->

GitHub Actions handles continuous integration by building and pushing container images.
Argo CD handles continuous delivery by reconciling the cluster state with what is defined in Git.
CI does not deploy directly to Kubernetes. Deployments happen when Git changes, following GitOps best practices.

This approach improves traceability, enables easy rollbacks, and keeps deployments predictable.


<!-- Cost-Conscious Implementation -->

Cost efficiency was an explicit requirement, and this POC reflects that:
Two small worker nodes are used to avoid a single point of failure while keeping compute costs low
Only one NAT Gateway is deployed to reduce baseline networking costs
A single ingress and external load balancer are created
Resource requests and replicas are kept minimal
These choices reduce cost while still demonstrating Kubernetes orchestration, GitOps workflows, and cloud-native networking.


<!-- Security Considerations -->

Basic security best practices are applied, even within the limited scope of a POC:

Workloads run in private subnets
Secrets are managed via Kubernetes Secrets rather than hardcoded values
Ingress is the only externally exposed entry point
Permissions are kept minimal and scoped appropriately

This provides a secure baseline without introducing unnecessary complexity.

<!-- Assumptions -->

The environment is intended for demonstration and testing, not live production traffic
Traffic volume is low and predictable
The database runs in-cluster for simplicity
AWS-managed services are trusted for control plane availability


<!-- Trade-offs -->

To keep this POC simple and cost-effective, a few deliberate compromises were made.

The cluster runs with a minimal worker node setup, so application-level high availability is limited compared to a full production environment. The database runs inside the cluster instead of using a managed service, and a full monitoring and alerting stack was intentionally left out to keep scope and cost under control.


Network isolation is kept basic, with ingress acting as the main external boundary. Public container images are used to avoid spending time on application development and keep the focus on infrastructure, GitOps, and deployment workflows.

In a production setup, these areas would be expanded with multiple nodes, managed services, stronger isolation, and full observability.

<!-- Production Considerations -->

In a production environment, this setup would be extended with:

Multiple worker nodes spread across availability zones
Pod and cluster autoscaling based on real traffic and usage
Managed database services with backups and encryption
TLS everywhere, WAF integration, and stricter network policies
Centralized logging, metrics, and alerting
Stronger IAM integration using IRSA and fine-grained roles

This proof of concept focuses on demonstrating the core architecture and workflows in a cost-aware way, while clearly showing how the platform could evolve into a production-ready setup.