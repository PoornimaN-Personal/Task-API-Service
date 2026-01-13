terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.10.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "3.0.1"
    }
      helm = {
      source = "hashicorp/helm"
      version = "3.1.1"
    }
  }
}

provider "kind" {
  # Configuration options
}

provider "kubernetes" {
  alias = "namespace"
  host = kind_cluster.local.endpoint
  cluster_ca_certificate = kind_cluster.local.cluster_ca_certificate
  client_certificate = kind_cluster.local.client_certificate
  client_key = kind_cluster.local.client_key
}

provider "helm" {
    alias = "release"
    kubernetes = {
    host = kind_cluster.local.endpoint
    cluster_ca_certificate = kind_cluster.local.cluster_ca_certificate
    client_certificate = kind_cluster.local.client_certificate
    client_key = kind_cluster.local.client_key
    }
 
}