<!-- Vector8 DevOps POC -->

This repository contains a proof of concept Kubernetes platform demonstrating Infrastructure as Code, CI/CD, and GitOps using modern cloud-native tooling.

The goal is to show how applications are built and deployed, not to build a complex application.

<!-- Stack -->

AWS EKS – Managed Kubernetes
Terraform – Infrastructure provisioning
GitHub Actions – Build and push container images
Helm – Application packaging
Argo CD – GitOps-based deployments
Docker Hub – Container registry

<!-- Architecture  -->

 Dedicated AWS VPC with public and private subnets
 EKS worker nodes run in private subnets only
 Ingress controller provides the only public entry point
 Simple multi-tier app:

  Frontend (Nginx)
  Backend API
  In-cluster database (POC only)

Git is the single source of truth.
Argo CD deploys changes by reconciling cluster state with Git.

<!-- CI/CD & GitOps Flow -->

Code pushed to GitHub
GitHub Actions builds and pushes images
Helm values reference the new images
Argo CD detects changes and syncs the cluster

CI builds.
Argo CD deploys.

<!-- Scope & Assumptions -->

 Designed as a cost-aware POC
 Minimal node count and resources
 Low traffic, non-production workload
 Focus on platform patterns, not scale


<!-- Notes -->

 All workloads run privately
 Ingress is the only public surface
 Easy to extend to production with autoscaling, managed databases, and observability

Author: Sarah

