terraform {
  required_version = ">= 1.3"

  required_providers {
    k3d = {
      source  = "pvotal-tech/k3d"
      version = "0.0.7"
    }
    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = ">= 2.0"
    }

    local = {
          source = "hashicorp/local"
          version = "~> 2.0" # Specify a suitable version constraint
        }

  }
}

provider "k3d" { }
provider "local" {}