terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.6"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}
# Kubernetes provider uses kubeconfig from k3s
provider "kubernetes" {
  host                   = var.kube_host
  client_certificate     = base64decode(var.kube_client_certificate)
  client_key             = base64decode(var.kube_client_key)
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
}
provider "flux" {
  kubernetes = {
    host                   = var.kube_host
    client_certificate     = base64decode(var.kube_client_certificate)
    client_key             = base64decode(var.kube_client_key)
    cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
  }
  git = {
    url = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    http = {
      username = "leeminluc"
      password = var.github_token
    }
    branch = var.branch
  }
}
provider "github" {
  token = var.github_token
  owner = var.github_owner
}