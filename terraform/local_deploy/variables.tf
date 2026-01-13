variable "env" {
  type = string
  description = "Name of the environment"
}

variable "cluster_name" {
  type = string
  description = "Name of the k3d cluster"
  default = "taskapi-cluster-local"
}

variable "namespace" {
  type = string
  description = "kubernetes namespace for deploying app"
  default = "task-api-local"
}
variable "chart_version" {
  default = "0.1.0"
}

variable "image_repo" {
  description = "Container image repository"
  default     = "ghcr.io/poorniman-personal/task-api"
}

variable "image_tag" {
  description = "Container image tag"
  default     = "latest"
}
variable "node_desired_size" {
  type = number
  description = "Desired size of the node"
  
}
variable "node_min_size" {
  type = number
  description = "Minimum size of the node"
  
}
variable "node_max_size" {
  type = number
  description = "Maximum size of the node"
  
}